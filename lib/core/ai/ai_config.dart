/// Configuration for AI services used in BabySteps.
/// Supports Whisper (speech-to-text), TTS (text-to-speech), and optional LLM backends.
class AiConfig {
  const AiConfig({
    this.enabled = true,
    this.whisperModel = 'base',
    this.whisperOnDevice = true,
    this.openAiApiKey,
    this.openAiBaseUrl,
    this.llmModel,
    this.llmProvider = 'openai',
    this.useLocalLlm = false,
    this.language = 'en',
    this.proactiveSuggestionsEnabled = false,
    this.voiceFeedbackEnabled = false,
  });

  /// Configuration with cloud Whisper (requires OpenAI API key).
  AiConfig.cloud({
    required String openAiApiKey,
    String whisperModel = 'whisper-1',
    String? llmModel,
  }) : this(
          whisperOnDevice: false,
          openAiApiKey: openAiApiKey,
          whisperModel: whisperModel,
          llmModel: llmModel ?? 'gpt-4-turbo',
          llmProvider: 'openai',
          useLocalLlm: false,
        );

  /// Configuration with local LLM (Ollama).
  AiConfig.localLlm({
    String openAiBaseUrl = 'http://localhost:11434/v1',
    String llmModel = 'llama3',
    String whisperModel = 'base',
  }) : this(
          whisperOnDevice: true,
          openAiBaseUrl: openAiBaseUrl,
          llmModel: llmModel,
          llmProvider: 'ollama',
          useLocalLlm: true,
          whisperModel: whisperModel,
        );

  /// Whether AI features are enabled.
  final bool enabled;

  /// Whisper model to use for speech recognition.
  /// Options: 'tiny', 'base', 'small', 'medium', 'large'
  final String whisperModel;

  /// Whether to use on-device Whisper (true) or cloud API (false).
  final bool whisperOnDevice;

  /// API key for OpenAI (if using cloud Whisper or GPT).
  final String? openAiApiKey;

  /// Base URL for OpenAI-compatible API (e.g., Ollama).
  final String? openAiBaseUrl;

  /// Model for LLM intent parsing (e.g., 'gpt-4', 'llama3', 'gemma').
  final String? llmModel;

  /// LLM provider to use for intent parsing.
  /// Possible values: 'openai', 'gemini', 'ollama', 'openrouter'.
  final String llmProvider;

  /// Whether to use local LLM (Ollama) for intent parsing.
  final bool useLocalLlm;

  /// Language for speech recognition (ISO 639-1 code).
  final String language;

  /// Whether to enable proactive routine suggestions.
  final bool proactiveSuggestionsEnabled;

  /// Whether to enable voice feedback (TTS).
  final bool voiceFeedbackEnabled;

  /// Default configuration with on-device Whisper and no LLM.
  static const AiConfig defaultConfig = AiConfig();

  /// Whether OpenAI API is configured (either cloud or local).
  bool get hasOpenAi => openAiApiKey != null || openAiBaseUrl != null;

  /// Whether LLM intent parsing is available.
  bool get hasLlm => (openAiApiKey != null || llmProvider == 'ollama') && llmModel != null;

  /// Effective base URL for the selected provider.
  String get effectiveBaseUrl {
    if (openAiBaseUrl != null && openAiBaseUrl!.isNotEmpty) {
      return openAiBaseUrl!;
    }
    switch (llmProvider) {
      case 'openrouter':
        return 'https://openrouter.ai/api/v1';
      case 'ollama':
        return 'http://localhost:11434/v1';
      case 'gemini':
        return 'https://generativelanguage.googleapis.com/v1beta/openai';
      case 'openai':
      default:
        return 'https://api.openai.com/v1';
    }
  }

  /// Creates a copy of this configuration with the given fields replaced.
  AiConfig copyWith({
    bool? enabled,
    String? whisperModel,
    bool? whisperOnDevice,
    String? openAiApiKey,
    String? openAiBaseUrl,
    String? llmModel,
    String? llmProvider,
    bool? useLocalLlm,
    String? language,
    bool? proactiveSuggestionsEnabled,
    bool? voiceFeedbackEnabled,
  }) {
    return AiConfig(
      enabled: enabled ?? this.enabled,
      whisperModel: whisperModel ?? this.whisperModel,
      whisperOnDevice: whisperOnDevice ?? this.whisperOnDevice,
      openAiApiKey: openAiApiKey ?? this.openAiApiKey,
      openAiBaseUrl: openAiBaseUrl ?? this.openAiBaseUrl,
      llmModel: llmModel ?? this.llmModel,
      llmProvider: llmProvider ?? this.llmProvider,
      useLocalLlm: useLocalLlm ?? this.useLocalLlm,
      language: language ?? this.language,
      proactiveSuggestionsEnabled:
          proactiveSuggestionsEnabled ?? this.proactiveSuggestionsEnabled,
      voiceFeedbackEnabled: voiceFeedbackEnabled ?? this.voiceFeedbackEnabled,
    );
  }

  @override
  String toString() {
    return 'AiConfig(enabled: $enabled, whisperModel: $whisperModel, whisperOnDevice: $whisperOnDevice, language: $language)';
  }
}