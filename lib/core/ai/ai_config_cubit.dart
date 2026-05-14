import 'package:flutter_bloc/flutter_bloc.dart';
import 'ai_config_service.dart';
import 'ai_config.dart';

/// State for AI configuration.
class AiConfigState {
  const AiConfigState({
    required this.config,
    this.isLoading = false,
    this.error,
  });

  final AiConfig config;
  final bool isLoading;
  final String? error;

  AiConfigState copyWith({
    AiConfig? config,
    bool? isLoading,
    String? error,
  }) {
    return AiConfigState(
      config: config ?? this.config,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}

/// Cubit for managing AI configuration.
class AiConfigCubit extends Cubit<AiConfigState> {
  AiConfigCubit(this._service) : super(AiConfigState(
    config: AiConfig.defaultConfig,
    isLoading: true,
  )) {
    loadConfig();
  }

  final AiConfigService _service;

  /// Load configuration from persistent storage.
  Future<void> loadConfig() async {
    emit(state.copyWith(isLoading: true, error: null));
    try {
      final config = await _service.loadConfig();
      emit(state.copyWith(config: config, isLoading: false));
    } catch (e) {
      emit(state.copyWith(error: e.toString(), isLoading: false));
    }
  }

  /// Update configuration and persist.
  Future<void> updateConfig(AiConfig config) async {
    emit(state.copyWith(isLoading: true, error: null));
    try {
      await _service.saveConfig(config);
      emit(state.copyWith(config: config, isLoading: false));
    } catch (e) {
      emit(state.copyWith(error: e.toString(), isLoading: false));
    }
  }

  /// Reset to default configuration.
  Future<void> resetToDefault() async {
    emit(state.copyWith(isLoading: true, error: null));
    try {
      await _service.resetToDefault();
      final defaultConfig = AiConfig.defaultConfig;
      emit(state.copyWith(config: defaultConfig, isLoading: false));
    } catch (e) {
      emit(state.copyWith(error: e.toString(), isLoading: false));
    }
  }
}