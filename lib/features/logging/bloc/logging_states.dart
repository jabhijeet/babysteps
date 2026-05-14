import 'package:equatable/equatable.dart';
import 'package:babysteps/core/error/app_errors.dart';

// --- States ---
abstract class LoggingState extends Equatable {
  const LoggingState();
  @override
  List<Object?> get props => [];
}

class LoggingInitial extends LoggingState {}

class LoggingLoading extends LoggingState {}

class LoggingSuccess extends LoggingState {
  const LoggingSuccess([this.message]);

  final String? message;
  
  @override
  List<Object?> get props => [message];
}

class LoggingFailure extends LoggingState {
  const LoggingFailure(this.error);

  final AppError error;
  
  /// Gets a user-friendly error message
  String get userMessage => error.userMessage;
  
  /// Gets recovery suggestion if available
  String? get recoverySuggestion => error.recoverySuggestion;
  
  /// Whether the error is transient and can be retried
  bool get isTransient => error.isTransient;
  
  @override
  List<Object?> get props => [error];
}