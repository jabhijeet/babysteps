import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:babysteps/core/network/sync_service.dart';

class MockGoogleSignIn extends Mock implements GoogleSignIn {}
class MockGoogleSignInAccount extends Mock implements GoogleSignInAccount {}

void main() {
  late SyncService syncService;
  late MockGoogleSignIn mockGoogleSignIn;
  late MockGoogleSignInAccount mockAccount;

  setUp(() {
    SharedPreferences.setMockInitialValues({});
    mockGoogleSignIn = MockGoogleSignIn();
    mockAccount = MockGoogleSignInAccount();
    syncService = SyncService(googleSignIn: mockGoogleSignIn);
    
    // Register fallback for mocktail
    registerFallbackValue(mockAccount);
  });

  group('SyncService', () {
    test('signIn calls googleSignIn.authenticate()', () async {
      when(() => mockGoogleSignIn.initialize()).thenAnswer((_) async => Future.value());
      when(() => mockGoogleSignIn.authenticate()).thenAnswer((_) async => mockAccount);
      
      try {
        await syncService.signIn();
      } catch (_) {}
      
      verify(() => mockGoogleSignIn.authenticate()).called(1);
    });

    test('signOut calls googleSignIn.signOut()', () async {
      when(() => mockGoogleSignIn.signOut()).thenAnswer((_) async => Future.value());
      
      await syncService.signOut();
      
      verify(() => mockGoogleSignIn.signOut()).called(1);
    });
  });
}
