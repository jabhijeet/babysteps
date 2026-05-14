import 'dart:convert';
import 'dart:developer';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:googleapis/drive/v3.dart' as drive;
import 'package:extension_google_sign_in_as_googleapis_auth/extension_google_sign_in_as_googleapis_auth.dart';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../config/environment.dart';

class SyncService with ChangeNotifier {
  SyncService({GoogleSignIn? googleSignIn}) : _testGoogleSignIn = googleSignIn;

  final GoogleSignIn? _testGoogleSignIn;
  drive.DriveApi? _driveApi;
  GoogleSignInAccount? _currentUser;

  static const String _clientIdKey = 'custom_google_client_id';
  
  static String get defaultClientId {
    // Use environment-specific client IDs configured via --dart-define
    if (kIsWeb) {
      final id = Environment.googleOAuthWebClientId;
      if (id.isEmpty) {
        log('Warning: GOOGLE_OAUTH_WEB_CLIENT_ID not configured. Google Sign-In will fail.');
      }
      return id;
    }
    if (Platform.isIOS) {
      final id = Environment.googleOAuthIosClientId;
      if (id.isEmpty) {
        log('Warning: GOOGLE_OAUTH_IOS_CLIENT_ID not configured. Google Sign-In will fail.');
      }
      return id;
    }
    if (Platform.isMacOS || Platform.isWindows || Platform.isLinux) {
      final id = Environment.googleOAuthDesktopClientId;
      if (id.isEmpty) {
        log('Warning: GOOGLE_OAUTH_DESKTOP_CLIENT_ID not configured. Google Sign-In will fail.');
      }
      return id;
    }
    // Android or other platforms
    final id = Environment.googleOAuthAndroidClientId;
    if (id.isEmpty) {
      log('Warning: GOOGLE_OAUTH_ANDROID_CLIENT_ID not configured. Google Sign-In will fail.');
    }
    return id;
  }

  GoogleSignInAccount? get currentUser => _currentUser;

  final List<String> _scopes = [
    drive.DriveApi.driveFileScope,
  ];

  Future<GoogleSignIn> _getGoogleSignIn() async {
    if (_testGoogleSignIn != null) return _testGoogleSignIn;
    await _ensureInitialized();
    return GoogleSignIn.instance;
  }

  Future<void> _ensureInitialized() async {
    final gsi = GoogleSignIn.instance;
    final clientId = await getCurrentClientId();
    final isAndroid = !kIsWeb && Platform.isAndroid;

    await gsi.initialize(
      clientId: isAndroid ? null : clientId,
      serverClientId: isAndroid ? Environment.googleOAuthWebClientId : null,
    );
  }

  Future<void> updateClientId(String newClientId) async {
    final prefs = await SharedPreferences.getInstance();
    final id = newClientId.trim().isEmpty ? defaultClientId : newClientId.trim();
    await prefs.setString(_clientIdKey, id);
    
    // Reset state to force re-initialization
    _driveApi = null;
    _currentUser = null;
    notifyListeners();
  }
  
  Future<String> getCurrentClientId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_clientIdKey) ?? defaultClientId;
  }

  Future<GoogleSignInAccount?> signIn() async {
    try {
      if (_testGoogleSignIn != null) {
         final account = await _testGoogleSignIn.authenticate();
         // For tests using older versions of the extension or mocks
         // we attempt to get a client. If it fails, we assume it's a mock issue.
         try {
           final authorization = await account.authorizationClient.authorizeScopes(_scopes);
           final client = authorization.authClient(scopes: _scopes);
           _driveApi = drive.DriveApi(client);
         } catch (e) {
           log('Test sign in client error (ignoring): $e');
         }
         
         _currentUser = account;
         notifyListeners();
         return account;
      }

      await _ensureInitialized();
      final gsi = GoogleSignIn.instance;
      final account = await gsi.authenticate();

      // In google_sign_in 7.2.0+, authorization is requested explicitly
      final authorization = await account.authorizationClient.authorizeScopes(_scopes);

      // In extension_google_sign_in_as_googleapis_auth 3.0.0, 
      // the authClient extension is on GoogleSignInClientAuthorization
      final client = authorization.authClient(scopes: _scopes);
      
      _driveApi = drive.DriveApi(client);
      _currentUser = account;
      log('User signed in: ${account.email}');
      notifyListeners();
      return account;
    } catch (e) {
      log('Error during sign in: $e');
      _currentUser = null;
      _driveApi = null;
      notifyListeners();
      return null;
    }
  }

  Future<void> signOut() async {
    final googleSignIn = await _getGoogleSignIn();
    await googleSignIn.signOut();
    _driveApi = null;
    _currentUser = null;
    notifyListeners();
  }

  Future<String> _getOrCreateBabyFolder(int babyId, {String? remoteFolderId}) async {
    if (_driveApi == null) throw Exception('Not signed in');

    if (remoteFolderId != null && remoteFolderId.isNotEmpty) {
      return remoteFolderId;
    }

    final folderName = 'BabySteps_Sync_Baby_$babyId';
    final list = await _driveApi!.files.list(
      q: "name = '$folderName' and mimeType = 'application/vnd.google-apps.folder' and trashed = false",
      spaces: 'drive',
    );

    if (list.files != null && list.files!.isNotEmpty) {
      return list.files!.first.id!;
    }

    final folder = drive.File()
      ..name = folderName
      ..mimeType = 'application/vnd.google-apps.folder';

    final created = await _driveApi!.files.create(folder);
    return created.id!;
  }

  Future<void> shareWithPartner(int babyId, String email) async {
    if (_driveApi == null) throw Exception('Not signed in');
    final folderId = await _getOrCreateBabyFolder(babyId);

    final permission = drive.Permission()
      ..type = 'user'
      ..role = 'writer'
      ..emailAddress = email;

    await _driveApi!.permissions.create(
      permission,
      folderId,
      sendNotificationEmail: true,
    );
  }

  Future<Map<String, dynamic>?> getBabyMetadata(String folderId) async {
    if (_driveApi == null) throw Exception('Not signed in');

    final list = await _driveApi!.files.list(
      q: "name = 'baby_metadata.json' and '$folderId' in parents and trashed = false",
      spaces: 'drive',
    );

    if (list.files != null && list.files!.isNotEmpty) {
      final fileId = list.files!.first.id!;
      final media = await _driveApi!.files.get(
        fileId,
        downloadOptions: drive.DownloadOptions.fullMedia,
      ) as drive.Media;

      final bytes = await media.stream.expand((e) => e).toList();
      return json.decode(utf8.decode(bytes)) as Map<String, dynamic>;
    }
    return null;
  }

  Future<void> updateBabyMetadata(int babyId, Map<String, dynamic> metadata, {String? remoteFolderId}) async {
    if (_driveApi == null) throw Exception('Not signed in');
    final folderId = await _getOrCreateBabyFolder(babyId, remoteFolderId: remoteFolderId);
    final fileName = 'baby_metadata.json';
    final content = json.encode(metadata);
    final media = drive.Media(
      Stream.value(utf8.encode(content)),
      utf8.encode(content).length,
    );

    final list = await _driveApi!.files.list(
      q: "name = '$fileName' and '$folderId' in parents and trashed = false",
      spaces: 'drive',
    );

    if (list.files != null && list.files!.isNotEmpty) {
      final fileId = list.files!.first.id!;
      await _driveApi!.files.update(
        drive.File(),
        fileId,
        uploadMedia: media,
      );
    } else {
      final file = drive.File()
        ..name = fileName
        ..parents = [folderId];
      await _driveApi!.files.create(
        file,
        uploadMedia: media,
      );
    }
  }

  Future<String> getBabyFolderId(int babyId, {String? remoteFolderId}) async {
    return await _getOrCreateBabyFolder(babyId, remoteFolderId: remoteFolderId);
  }

  Future<void> backupDatabase(int babyId, String dbContent, {String? remoteFolderId}) async {
    if (_driveApi == null) throw Exception('Not signed in');
    final folderId = await _getOrCreateBabyFolder(babyId, remoteFolderId: remoteFolderId);

    final fileName = 'babysteps_backup.json'; // Constant name inside the specific folder
    final media = drive.Media(
      Stream.value(utf8.encode(dbContent)),
      utf8.encode(dbContent).length,
    );

    final list = await _driveApi!.files.list(
      q: "name = '$fileName' and '$folderId' in parents and trashed = false",
      spaces: 'drive',
    );

    if (list.files != null && list.files!.isNotEmpty) {
      final fileId = list.files!.first.id!;
      await _driveApi!.files.update(
        drive.File(),
        fileId,
        uploadMedia: media,
      );
    } else {
      final file = drive.File()
        ..name = fileName
        ..parents = [folderId];
      await _driveApi!.files.create(
        file,
        uploadMedia: media,
      );
    }
  }

  Future<String?> restoreDatabase(int babyId, {String? remoteFolderId}) async {
    if (_driveApi == null) throw Exception('Not signed in');
    final folderId = await _getOrCreateBabyFolder(babyId, remoteFolderId: remoteFolderId);
    final fileName = 'babysteps_backup.json';

    final list = await _driveApi!.files.list(
      q: "name = '$fileName' and '$folderId' in parents and trashed = false",
      spaces: 'drive',
    );

    if (list.files != null && list.files!.isNotEmpty) {
      final fileId = list.files!.first.id!;
      final media = await _driveApi!.files.get(
        fileId,
        downloadOptions: drive.DownloadOptions.fullMedia,
      ) as drive.Media;

      final bytes = await media.stream.expand((e) => e).toList();
      return utf8.decode(bytes);
    }
    return null;
  }

  Future<void> uploadPhoto(int babyId, Stream<List<int>> stream, int length, String fileName, {String? remoteFolderId}) async {
    if (_driveApi == null) throw Exception('Not signed in');
    final folderId = await _getOrCreateBabyFolder(babyId, remoteFolderId: remoteFolderId);

    final media = drive.Media(
      stream,
      length,
    );

    final list = await _driveApi!.files.list(
      q: "name = '$fileName' and '$folderId' in parents and trashed = false",
      spaces: 'drive',
    );

    if (list.files != null && list.files!.isNotEmpty) {
      await _driveApi!.files.update(
        drive.File(),
        list.files!.first.id!,
        uploadMedia: media,
      );
    } else {
      final file = drive.File()
        ..name = fileName
        ..parents = [folderId];
      await _driveApi!.files.create(file, uploadMedia: media);
    }
  }
}

