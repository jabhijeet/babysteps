/// Error handling utilities for consistent error processing across the application.
///
/// This file provides functions to handle errors consistently, including:
/// - Converting exceptions to AppError
/// - Logging errors appropriately
/// - Providing user-friendly error messages
/// - Suggesting recovery actions.

library;

import 'dart:developer' as developer;
import 'package:flutter/foundation.dart';
import 'app_errors.dart';

/// Handles an error by converting it to AppError, logging it, and optionally showing UI feedback.
class ErrorHandler {
  /// Converts any exception/error to an AppError and logs it.
  static AppError handleError(
    dynamic error, {
    StackTrace? stackTrace,
    String? context,
    bool logError = true,
  }) {
    final appError = convertToAppError(error, stackTrace);

    if (logError) {
      _logError(appError, context: context);
    }

    return appError;
  }

  /// Logs an AppError with appropriate detail level based on environment.
  static void _logError(AppError error, {String? context}) {
    final contextPrefix = context != null ? '[$context] ' : '';

    if (kDebugMode) {
      // In debug mode, log full details including stack trace
      developer.log(
        '$contextPrefix${error.debugMessage}',
        error: error,
        stackTrace: error.stackTrace,
        level: 1000, // ERROR level
      );

      if (error.stackTrace != null) {
        developer.log('Stack trace:', stackTrace: error.stackTrace);
      }
    } else {
      // In production, log only essential information
      developer.log(
        '$contextPrefix${error.message}',
        level: 1000,
      );
    }
  }

  /// Executes an async function with error handling and optional retry logic.
  static Future<T> executeWithErrorHandling<T>(
    Future<T> Function() action, {
    String? context,
    int maxRetries = 0,
    Duration retryDelay = const Duration(seconds: 1),
    bool Function(AppError)? shouldRetry,
  }) async {
    int attempt = 0;

    while (true) {
      try {
        return await action();
      } catch (error, stackTrace) {
        attempt++;
        final appError = handleError(
          error,
          stackTrace: stackTrace,
          context: context,
        );

        // Check if we should retry
        final bool canRetry = attempt <= maxRetries &&
            appError.isTransient &&
            (shouldRetry == null || shouldRetry(appError));

        if (!canRetry) {
          // Re-throw the AppError
          throw appError;
        }

        // Wait before retrying
        if (retryDelay > Duration.zero) {
          await Future<void>.delayed(retryDelay);
        }
      }
    }
  }

  /// Shows a user-friendly error message based on the AppError.
  /// This would typically be used with a snackbar or dialog.
  static String getUserFriendlyMessage(AppError error) {
    return error.userMessage;
  }

  /// Gets recovery suggestion for an error, if available.
  static String? getRecoverySuggestion(AppError error) {
    return error.recoverySuggestion;
  }

  /// Creates a complete error message with recovery suggestion.
  static String getCompleteErrorMessage(AppError error) {
    final suggestion = error.recoverySuggestion;
    if (suggestion != null) {
      return '${error.userMessage}\n\n$suggestion';
    }
    return error.userMessage;
  }

  /// Checks if an error is likely transient and can be retried.
  static bool isTransientError(dynamic error) {
    if (error is AppError) {
      return error.isTransient;
    }

    final errorString = error.toString().toLowerCase();
    return errorString.contains('timeout') ||
           errorString.contains('network') ||
           errorString.contains('connection') ||
           errorString.contains('socket');
  }

  /// Creates a formatted error report for debugging or support.
  static Map<String, dynamic> createErrorReport(AppError error) {
    return {
      'type': error.runtimeType.toString(),
      'message': error.message,
      'userMessage': error.userMessage,
      'debugDetails': error.debugDetails,
      'timestamp': error.timestamp.toIso8601String(),
      'isTransient': error.isTransient,
      'recoverySuggestion': error.recoverySuggestion,
      'stackTrace': error.stackTrace?.toString(),
    };
  }
}

/// Extension methods for easier error handling in async operations.
extension ErrorHandlingExtensions<T> on Future<T> {
  /// Wraps the future with error handling that converts exceptions to AppError.
  Future<T> withErrorHandling({
    String? context,
    bool logError = true,
  }) async {
    try {
      return await this;
    } catch (error, stackTrace) {
      final appError = ErrorHandler.handleError(
        error,
        stackTrace: stackTrace,
        context: context,
        logError: logError,
      );
      throw appError;
    }
  }

  /// Executes with retry logic for transient errors.
  Future<T> withRetry({
    String? context,
    int maxRetries = 3,
    Duration retryDelay = const Duration(seconds: 1),
    bool Function(AppError)? shouldRetry,
  }) {
    return ErrorHandler.executeWithErrorHandling(
      () => this,
      context: context,
      maxRetries: maxRetries,
      retryDelay: retryDelay,
      shouldRetry: shouldRetry,
    );
  }
}

/// Extension for converting exceptions to AppError in catch blocks.
extension ExceptionToAppError on Object {
  /// Converts this exception to an AppError.
  AppError toAppError([StackTrace? stackTrace]) {
    return convertToAppError(this, stackTrace);
  }
}
