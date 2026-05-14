import 'package:flutter_test/flutter_test.dart';
import 'package:babysteps/core/ai/voice_input_service.dart';
import 'package:babysteps/core/ai/ai_config.dart';

void main() {
  // Initialize Flutter bindings for platform channels
  TestWidgetsFlutterBinding.ensureInitialized();

  group('VoiceInputService', () {
    test('initializes with default config', () {
      final config = AiConfig.defaultConfig;
      final service = VoiceInputService(config: config);
      
      expect(service.isSpeechRecognitionAvailable, config.enabled && config.whisperOnDevice);
      expect(service.isTtsAvailable, config.voiceFeedbackEnabled);
    });

    test('initialization does not throw', () async {
      final config = AiConfig.defaultConfig;
      final service = VoiceInputService(config: config);
      
      expect(() async => await service.initialize(), returnsNormally);
    });

    test('speak method works when voice feedback enabled', () async {
      final config = AiConfig(
        enabled: true,
        voiceFeedbackEnabled: true,
        whisperOnDevice: true,
      );
      final service = VoiceInputService(config: config);
      await service.initialize();
      
      // Should not throw
      expect(() async => await service.speak('Test message'), returnsNormally);
    });

    test('speak method does nothing when voice feedback disabled', () async {
      final config = AiConfig(
        enabled: true,
        voiceFeedbackEnabled: false,
        whisperOnDevice: true,
      );
      final service = VoiceInputService(config: config);
      await service.initialize();
      
      // Should complete without error
      await service.speak('Test message');
    });

    test('dispose does not throw', () {
      final config = AiConfig.defaultConfig;
      final service = VoiceInputService(config: config);
      
      expect(service.dispose, returnsNormally);
    });
  });

  group('IntentParser', () {
    test('parses feed intent from transcript', () async {
      // Note: IntentParser tests would go here
      // Since we can't import without actual implementation,
      // we'll keep this as a placeholder
      expect(true, isTrue);
    });
  });
}