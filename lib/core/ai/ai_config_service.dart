import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'ai_config.dart';
import '../security/secure_storage.dart';

/// Service for persisting and retrieving AI configuration.
/// Sensitive fields (API keys, URLs) are encrypted using SecureStorage.
class AiConfigService {
  AiConfigService(this._secureStorage);

  static const String _prefsKey = 'ai_config';
  static const List<String> _sensitiveFields = [
    'openAiApiKey',
    'openAiBaseUrl',
    'llmModel',
  ];

  SharedPreferences? _prefs;
  final SecureStorage _secureStorage;
  bool _initialized = false;

  /// Initialize the service with SharedPreferences.
  /// Must be called before using any other methods.
  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
    _initialized = true;
  }

  /// Ensure the service is initialized.
  void _ensureInitialized() {
    if (!_initialized || _prefs == null) {
      throw StateError('AiConfigService not initialized. Call init() first.');
    }
  }

  /// Load the saved AI configuration, or return default if none exists.
  Future<AiConfig> loadConfig() async {
    _ensureInitialized();
    final jsonString = _prefs!.getString(_prefsKey);
    if (jsonString == null) {
      return AiConfig.defaultConfig;
    }
    try {
      final map = _decodeJson(jsonString);
      // Decrypt sensitive fields if they are encrypted
      final decryptedMap = await _decryptSensitiveFields(map);
      return AiConfig(
        enabled: (decryptedMap['enabled'] as bool?) ?? true,
        whisperModel: (decryptedMap['whisperModel'] as String?) ?? 'base',
        whisperOnDevice: (decryptedMap['whisperOnDevice'] as bool?) ?? true,
        openAiApiKey: decryptedMap['openAiApiKey'] as String?,
        openAiBaseUrl: decryptedMap['openAiBaseUrl'] as String?,
        llmModel: decryptedMap['llmModel'] as String?,
        llmProvider: (decryptedMap['llmProvider'] as String?) ?? 'openai',
        useLocalLlm: (decryptedMap['useLocalLlm'] as bool?) ?? false,
        language: (decryptedMap['language'] as String?) ?? 'en',
        proactiveSuggestionsEnabled: (decryptedMap['proactiveSuggestionsEnabled'] as bool?) ?? false,
        voiceFeedbackEnabled: (decryptedMap['voiceFeedbackEnabled'] as bool?) ?? false,
      );
    } catch (e) {
      // If parsing fails, return default config.
      return AiConfig.defaultConfig;
    }
  }

  /// Save the AI configuration to persistent storage.
  Future<void> saveConfig(AiConfig config) async {
    _ensureInitialized();
    final map = {
      'enabled': config.enabled,
      'whisperModel': config.whisperModel,
      'whisperOnDevice': config.whisperOnDevice,
      'openAiApiKey': config.openAiApiKey,
      'openAiBaseUrl': config.openAiBaseUrl,
      'llmModel': config.llmModel,
      'llmProvider': config.llmProvider,
      'useLocalLlm': config.useLocalLlm,
      'language': config.language,
      'proactiveSuggestionsEnabled': config.proactiveSuggestionsEnabled,
      'voiceFeedbackEnabled': config.voiceFeedbackEnabled,
    };
    // Encrypt sensitive fields before storage
    final encryptedMap = await _encryptSensitiveFields(map);
    final jsonString = _encodeJson(encryptedMap);
    await _prefs!.setString(_prefsKey, jsonString);
  }

  /// Reset configuration to default.
  Future<void> resetToDefault() async {
    _ensureInitialized();
    await _prefs!.remove(_prefsKey);
  }

  /// Encrypt sensitive fields in the configuration map.
  Future<Map<String, dynamic>> _encryptSensitiveFields(Map<String, dynamic> map) async {
    final result = Map<String, dynamic>.from(map);
    for (final field in _sensitiveFields) {
      final value = result[field];
      if (value != null && value is String) {
        // Encrypt the value
        result[field] = _secureStorage.encryptData(value);
      }
    }
    return result;
  }

  /// Decrypt sensitive fields in the configuration map.
  /// Handles backward compatibility: if a field is not encrypted (doesn't contain ':'),
  /// returns it as-is.
  Future<Map<String, dynamic>> _decryptSensitiveFields(Map<String, dynamic> map) async {
    final result = Map<String, dynamic>.from(map);
    for (final field in _sensitiveFields) {
      final value = result[field];
      if (value != null && value is String) {
        if (_isEncrypted(value)) {
          try {
            result[field] = await _secureStorage.decryptData(value);
          } catch (e) {
            // If decryption fails, keep the encrypted value (will be treated as invalid)
            // This could happen if encryption key changed or data corrupted
            // In production, you might want to log this and handle gracefully
            result[field] = null;
          }
        }
        // If not encrypted, keep as-is (backward compatibility)
      }
    }
    return result;
  }

  /// Check if a string appears to be encrypted (contains ':' separator).
  bool _isEncrypted(String value) {
    return value.contains(':') && value.split(':').length == 2;
  }

  // Simple JSON encoding/decoding (using dart:convert).
  // Since the map contains only primitive types, we can use jsonEncode.
  String _encodeJson(Map<String, dynamic> map) {
    // Remove null values to keep JSON clean.
    map.removeWhere((key, value) => value == null);
    return jsonEncode(map);
  }

  Map<String, dynamic> _decodeJson(String jsonString) {
    return jsonDecode(jsonString) as Map<String, dynamic>;
  }
}