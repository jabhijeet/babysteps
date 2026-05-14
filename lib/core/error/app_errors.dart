/// App-specific error types for consistent error handling across the application.
///
/// This file defines a hierarchy of error types that can be used throughout
/// the app to provide better error categorization, user-friendly messages,
/// and recovery suggestions.

library;

import 'package:equatable/equatable.dart';

/// Base class for all app-specific errors.
abstract class AppError extends Equatable implements Exception {
  AppError({
    required this.message,
    this.debugDetails,
    this.stackTrace,
    DateTime? timestamp,
  }) : timestamp = timestamp ?? DateTime.now();

  final String message;
  final String? debugDetails;
  final StackTrace? stackTrace;
  final DateTime timestamp;

  /// Creates a user-friendly error message suitable for UI display.
  String get userMessage => message;

  /// Creates a detailed debug message for logging.
  String get debugMessage {
    final details = debugDetails != null ? ' ($debugDetails)' : '';
    return '$message$details';
  }

  /// Whether this error is likely transient and can be retried.
  bool get isTransient => false;

  /// Suggested recovery action for this error.
  String? get recoverySuggestion => null;

  @override
  List<Object?> get props => [message, debugDetails, timestamp];

  @override
  bool get stringify => true;
}

/// Network-related errors
class NetworkError extends AppError {
  NetworkError({
    required super.message,
    this.statusCode,
    this.url,
    super.debugDetails,
    super.stackTrace,
  }) : super();

  factory NetworkError.fromHttpStatus(int statusCode, String url) {
    String message;

    switch (statusCode) {
      case 400:
        message = 'Bad request. Please check your input.';
        break;
      case 401:
        message = 'Authentication failed. Please sign in again.';
        break;
      case 403:
        message = 'Access denied. You don\'t have permission.';
        break;
      case 404:
        message = 'Resource not found.';
        break;
      case 408:
        message = 'Request timeout. The server took too long to respond.';
        break;
      case 429:
        message = 'Too many requests. Please wait before trying again.';
        break;
      case 500:
        message = 'Server error. Please try again later.';
        break;
      case 502:
      case 503:
      case 504:
        message = 'Service temporarily unavailable.';
        break;
      default:
        message = 'Network error (HTTP $statusCode).';
    }

    return NetworkError(
      message: message,
      statusCode: statusCode,
      url: url,
      debugDetails: 'HTTP $statusCode for $url',
    );
  }

  factory NetworkError.noInternet() {
    return NetworkError(
      message: 'No internet connection.',
      debugDetails: 'Network connectivity unavailable',
    );
  }

  factory NetworkError.timeout() {
    return NetworkError(
      message: 'Request timed out.',
      debugDetails: 'Network request exceeded timeout',
    );
  }

  final int? statusCode;
  final String? url;

  @override
  bool get isTransient => true;

  @override
  String? get recoverySuggestion {
    if (statusCode == 401) return 'Please sign in again.';
    if (statusCode == 429) return 'Wait a few minutes before trying again.';
    if (statusCode == 500 || statusCode == 502 || statusCode == 503 || statusCode == 504) {
      return 'Try again in a few minutes.';
    }
    return 'Check your internet connection and try again.';
  }

  @override
  List<Object?> get props => [...super.props, statusCode, url];
}

/// Database-related errors
class DatabaseError extends AppError {
  DatabaseError({
    required super.message,
    this.operation,
    this.table,
    super.debugDetails,
    super.stackTrace,
  }) : super();

  factory DatabaseError.constraintViolation(String constraint, String table) {
    return DatabaseError(
      message: 'Database constraint violation.',
      operation: 'INSERT/UPDATE',
      table: table,
      debugDetails: 'Constraint "$constraint" violated in table "$table"',
    );
  }

  factory DatabaseError.notFound(String table, int? id) {
    return DatabaseError(
      message: 'Record not found in database.',
      operation: 'SELECT',
      table: table,
      debugDetails: 'Record with ID $id not found in table "$table"',
    );
  }

  factory DatabaseError.uniqueViolation(String column, String table) {
    return DatabaseError(
      message: 'Duplicate entry. This value already exists.',
      operation: 'INSERT',
      table: table,
      debugDetails: 'Unique constraint violation on column "$column" in table "$table"',
    );
  }

  final String? operation;
  final String? table;

  @override
  String get userMessage {
    if (operation == 'INSERT' && table != null) {
      return 'Failed to save data to $table.';
    }
    if (operation == 'SELECT' && table != null) {
      return 'Failed to load data from $table.';
    }
    return message;
  }

  @override
  String? get recoverySuggestion {
    if (operation == 'INSERT') {
      return 'Check if the data already exists or try again.';
    }
    return 'Try restarting the app or reinstalling if the problem persists.';
  }

  @override
  List<Object?> get props => [...super.props, operation, table];
}

/// Validation errors
class ValidationError extends AppError {
  ValidationError({
    required super.message,
    required this.field,
    this.value,
    this.validationRule,
    super.debugDetails,
    super.stackTrace,
  }) : super();

  factory ValidationError.required(String field) {
    return ValidationError(
      message: '$field is required.',
      field: field,
      validationRule: 'required',
      debugDetails: 'Required field "$field" is empty',
    );
  }

  factory ValidationError.invalidFormat(String field, dynamic value, String expectedFormat) {
    return ValidationError(
      message: '$field has invalid format. Expected: $expectedFormat.',
      field: field,
      value: value,
      validationRule: 'format',
      debugDetails: 'Field "$field" value "$value" does not match format "$expectedFormat"',
    );
  }

  factory ValidationError.outOfRange(String field, dynamic value, dynamic min, dynamic max) {
    return ValidationError(
      message: '$field must be between $min and $max.',
      field: field,
      value: value,
      validationRule: 'range',
      debugDetails: 'Field "$field" value "$value" is outside range [$min, $max]',
    );
  }

  final String field;
  final dynamic value;
  final String? validationRule;

  @override
  String get userMessage => message;

  @override
  String? get recoverySuggestion => 'Please correct the value and try again.';

  @override
  List<Object?> get props => [...super.props, field, value, validationRule];
}

/// Authentication/authorization errors
class AuthError extends AppError {
  AuthError({
    required super.message,
    required this.type,
    super.debugDetails,
    super.stackTrace,
  }) : super();

  factory AuthError.invalidCredentials() {
    return AuthError(
      message: 'Invalid email or password.',
      type: AuthErrorType.invalidCredentials,
      debugDetails: 'Authentication failed due to invalid credentials',
    );
  }

  factory AuthError.expiredToken() {
    return AuthError(
      message: 'Your session has expired. Please sign in again.',
      type: AuthErrorType.expiredToken,
      debugDetails: 'Authentication token has expired',
    );
  }

  factory AuthError.userNotFound() {
    return AuthError(
      message: 'User account not found.',
      type: AuthErrorType.userNotFound,
      debugDetails: 'User account does not exist',
    );
  }

  factory AuthError.notAuthorized() {
    return AuthError(
      message: 'You are not authorized to perform this action.',
      type: AuthErrorType.notAuthorized,
      debugDetails: 'User lacks required permissions',
    );
  }

  final AuthErrorType type;

  @override
  bool get isTransient => type == AuthErrorType.expiredToken;

  @override
  String? get recoverySuggestion {
    switch (type) {
      case AuthErrorType.invalidCredentials:
        return 'Check your email and password and try again.';
      case AuthErrorType.expiredToken:
        return 'Please sign out and sign in again.';
      case AuthErrorType.userNotFound:
        return 'Check if you\'re using the correct email address.';
      case AuthErrorType.notAuthorized:
        return 'Contact the baby\'s primary caregiver for access.';
    }
  }

  @override
  List<Object?> get props => [...super.props, type];
}

enum AuthErrorType {
  invalidCredentials,
  expiredToken,
  userNotFound,
  notAuthorized,
}

/// File/Storage errors
class StorageError extends AppError {
  StorageError({
    required super.message,
    required this.type,
    this.filePath,
    super.debugDetails,
    super.stackTrace,
  }) : super();

  factory StorageError.fileNotFound(String path) {
    return StorageError(
      message: 'File not found.',
      type: StorageErrorType.fileNotFound,
      filePath: path,
      debugDetails: 'File not found at path: $path',
    );
  }

  factory StorageError.insufficientSpace() {
    return StorageError(
      message: 'Insufficient storage space.',
      type: StorageErrorType.insufficientSpace,
      debugDetails: 'Device storage is full',
    );
  }

  factory StorageError.permissionDenied() {
    return StorageError(
      message: 'Storage permission denied.',
      type: StorageErrorType.permissionDenied,
      debugDetails: 'App lacks storage permissions',
    );
  }

  factory StorageError.encryptionFailed() {
    return StorageError(
      message: 'Failed to encrypt/decrypt data.',
      type: StorageErrorType.encryptionFailed,
      debugDetails: 'Encryption/decryption operation failed',
    );
  }

  final StorageErrorType type;
  final String? filePath;

  @override
  String? get recoverySuggestion {
    switch (type) {
      case StorageErrorType.fileNotFound:
        return 'The file may have been moved or deleted.';
      case StorageErrorType.insufficientSpace:
        return 'Free up some storage space on your device.';
      case StorageErrorType.permissionDenied:
        return 'Grant storage permissions in app settings.';
      case StorageErrorType.encryptionFailed:
        return 'Try restarting the app or reinstalling if the problem persists.';
    }
  }

  @override
  List<Object?> get props => [...super.props, type, filePath];
}

enum StorageErrorType {
  fileNotFound,
  insufficientSpace,
  permissionDenied,
  encryptionFailed,
}

/// AI/ML service errors
class AiServiceError extends AppError {
  AiServiceError({
    required super.message,
    required this.type,
    super.debugDetails,
    super.stackTrace,
  }) : super();

  factory AiServiceError.speechRecognitionFailed() {
    return AiServiceError(
      message: 'Speech recognition failed.',
      type: AiServiceErrorType.speechRecognition,
      debugDetails: 'Speech recognition service failed',
    );
  }

  factory AiServiceError.intentParsingFailed() {
    return AiServiceError(
      message: 'Could not understand your command.',
      type: AiServiceErrorType.intentParsing,
      debugDetails: 'Intent parsing failed',
    );
  }

  factory AiServiceError.modelNotLoaded() {
    return AiServiceError(
      message: 'AI model not available.',
      type: AiServiceErrorType.modelNotLoaded,
      debugDetails: 'AI model failed to load',
    );
  }

  factory AiServiceError.quotaExceeded() {
    return AiServiceError(
      message: 'AI service quota exceeded.',
      type: AiServiceErrorType.quotaExceeded,
      debugDetails: 'AI service API quota exceeded',
    );
  }

  final AiServiceErrorType type;

  @override
  bool get isTransient => type == AiServiceErrorType.quotaExceeded;

  @override
  String? get recoverySuggestion {
    switch (type) {
      case AiServiceErrorType.speechRecognition:
        return 'Speak clearly and try again.';
      case AiServiceErrorType.intentParsing:
        return 'Try rephrasing your command.';
      case AiServiceErrorType.modelNotLoaded:
        return 'Try restarting the app.';
      case AiServiceErrorType.quotaExceeded:
        return 'Try again tomorrow or upgrade your plan.';
    }
  }

  @override
  List<Object?> get props => [...super.props, type];
}

enum AiServiceErrorType {
  speechRecognition,
  intentParsing,
  modelNotLoaded,
  quotaExceeded,
}

/// Generic error class for fallback when we can't categorize
class GenericError extends AppError {
  GenericError({
    required super.message,
    super.debugDetails,
    super.stackTrace,
  }) : super();
}

/// Utility function to convert generic exceptions to AppError
AppError convertToAppError(dynamic error, [StackTrace? stackTrace]) {
  if (error is AppError) {
    return error;
  }

  final errorString = error.toString().toLowerCase();

  // Try to categorize based on error message patterns
  if (errorString.contains('network') ||
      errorString.contains('socket') ||
      errorString.contains('internet') ||
      errorString.contains('connection')) {
    return NetworkError.noInternet();
  }

  if (errorString.contains('timeout') || errorString.contains('timed out')) {
    return NetworkError.timeout();
  }

  if (errorString.contains('sql') ||
      errorString.contains('database') ||
      errorString.contains('constraint') ||
      errorString.contains('unique')) {
    return DatabaseError(
      message: 'Database operation failed.',
      debugDetails: error.toString(),
      stackTrace: stackTrace,
    );
  }

  if (errorString.contains('auth') ||
      errorString.contains('login') ||
      errorString.contains('credential') ||
      errorString.contains('token')) {
    return AuthError(
      message: 'Authentication failed.',
      type: AuthErrorType.invalidCredentials,
      debugDetails: error.toString(),
      stackTrace: stackTrace,
    );
  }

  if (errorString.contains('file') ||
      errorString.contains('storage') ||
      errorString.contains('permission')) {
    return StorageError(
      message: 'Storage operation failed.',
      type: StorageErrorType.permissionDenied,
      debugDetails: error.toString(),
      stackTrace: stackTrace,
    );
  }

  // Default to generic error
  return GenericError(
    message: 'An unexpected error occurred.',
    debugDetails: error.toString(),
    stackTrace: stackTrace,
  );
}
