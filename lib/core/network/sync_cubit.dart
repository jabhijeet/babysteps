import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'sync_service.dart';

/// Represents the state of Google Drive synchronization.
class SyncState {
  const SyncState({
    this.currentUser,
    this.isLoading = false,
    this.error,
  }) : isSignedIn = currentUser != null;

  final GoogleSignInAccount? currentUser;
  final bool isLoading;
  final String? error;
  final bool isSignedIn;

  SyncState copyWith({
    GoogleSignInAccount? currentUser,
    bool? isLoading,
    String? error,
  }) {
    return SyncState(
      currentUser: currentUser ?? this.currentUser,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }

  @override
  String toString() {
    return 'SyncState(currentUser: ${currentUser?.email}, isLoading: $isLoading, error: $error)';
  }
}

/// Cubit for managing Google Drive synchronization.
class SyncCubit extends Cubit<SyncState> {
  SyncCubit(this._syncService) : super(const SyncState()) {
    // Load initial state
    _loadInitialState();
  }

  final SyncService _syncService;

  Future<void> _loadInitialState() async {
    emit(state.copyWith(currentUser: _syncService.currentUser));
  }

  /// Signs in to Google Drive.
  Future<void> signIn() async {
    emit(state.copyWith(isLoading: true, error: null));
    try {
      final user = await _syncService.signIn();
      emit(state.copyWith(
        currentUser: user,
        isLoading: false,
      ));
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        error: e.toString(),
      ));
      rethrow;
    }
  }

  /// Signs out from Google Drive.
  Future<void> signOut() async {
    emit(state.copyWith(isLoading: true, error: null));
    try {
      await _syncService.signOut();
      emit(state.copyWith(
        currentUser: null,
        isLoading: false,
      ));
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        error: e.toString(),
      ));
      rethrow;
    }
  }

  /// Updates the Google OAuth client ID.
  Future<void> updateClientId(String newClientId) async {
    emit(state.copyWith(isLoading: true, error: null));
    try {
      await _syncService.updateClientId(newClientId);
      emit(state.copyWith(isLoading: false));
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        error: e.toString(),
      ));
      rethrow;
    }
  }

  /// Gets the current client ID.
  Future<String> getCurrentClientId() async {
    return await _syncService.getCurrentClientId();
  }

  /// Shares a baby folder with a partner.
  Future<void> shareWithPartner(int babyId, String email) async {
    emit(state.copyWith(isLoading: true, error: null));
    try {
      await _syncService.shareWithPartner(babyId, email);
      emit(state.copyWith(isLoading: false));
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        error: e.toString(),
      ));
      rethrow;
    }
  }

  /// Backs up database to Google Drive.
  Future<void> backupDatabase(int babyId, String dbContent) async {
    emit(state.copyWith(isLoading: true, error: null));
    try {
      await _syncService.backupDatabase(babyId, dbContent);
      emit(state.copyWith(isLoading: false));
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        error: e.toString(),
      ));
      rethrow;
    }
  }

  /// Restores database from Google Drive.
  Future<String?> restoreDatabase(int babyId) async {
    emit(state.copyWith(isLoading: true, error: null));
    try {
      final content = await _syncService.restoreDatabase(babyId);
      emit(state.copyWith(isLoading: false));
      return content;
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        error: e.toString(),
      ));
      rethrow;
    }
  }

  /// Uploads a photo to Google Drive.
  Future<void> uploadPhoto(int babyId, Stream<List<int>> stream, int length, String fileName) async {
    emit(state.copyWith(isLoading: true, error: null));
    try {
      await _syncService.uploadPhoto(babyId, stream, length, fileName);
      emit(state.copyWith(isLoading: false));
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        error: e.toString(),
      ));
      rethrow;
    }
  }
}