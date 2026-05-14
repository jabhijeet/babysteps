import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:flutter_tts/flutter_tts.dart';
import 'package:flutter_whisper_kit/flutter_whisper_kit.dart';
import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';
import 'ai_config.dart';

/// Service for handling voice input (speech-to-text) and output (text-to-speech).
class VoiceInputService {
  VoiceInputService({required this.config}) {
    _speech = stt.SpeechToText();
    _tts = FlutterTts();
    log('VoiceInputService created: enabled=${config.enabled}');
  }

  final AiConfig config;
  late stt.SpeechToText _speech;
  late FlutterTts _tts;
  final AudioRecorder _recorder = AudioRecorder();
  
  FlutterWhisperKit? _whisper;
  bool _initialized = false;
  bool _hasSpeechAvailable = false;
  bool _isWhisperInitialized = false;
  String? _recordingPath;

  /// Initialize the speech recognition and TTS engines.
  Future<void> initialize() async {
    if (!config.enabled) return;

    // Initialize Speech To Text (Standard)
    try {
      _hasSpeechAvailable = await _speech.initialize(
        onStatus: (status) => log('STT status: $status'),
        onError: (errorNotification) => log('STT error: $errorNotification'),
      );
      log('Speech available: $_hasSpeechAvailable');
    } catch (e) {
      log('Failed to initialize SpeechToText: $e');
      _hasSpeechAvailable = false;
    }

    // Initialize Whisper (On-Device) if requested and not on Web
    if (config.whisperOnDevice && !kIsWeb) {
      try {
        _whisper = FlutterWhisperKit();
        await _whisper!.loadModel(config.whisperModel);
        _isWhisperInitialized = true;
        log('Whisper ready with model: ${config.whisperModel}');
      } catch (e) {
        log('Failed to initialize Whisper: $e');
        _isWhisperInitialized = false;
      }
    }

    // Initialize TTS
    if (config.voiceFeedbackEnabled) {
      try {
        await _tts.setLanguage(config.language);
        await _tts.setSpeechRate(0.5);
        await _tts.setVolume(1.0);
        await _tts.setPitch(1.0);
      } catch (e) {
        log('Failed to initialize TTS: $e');
      }
    }

    _initialized = true;
    log('VoiceInputService initialized (Whisper=$_isWhisperInitialized)');
  }

  /// Start listening for speech.
  Future<void> startListening({
    required void Function(String result, bool isFinal) onResult,
  }) async {
    if (!_initialized) {
      throw StateError('VoiceInputService not initialized. Call initialize() first.');
    }

    if (config.whisperOnDevice && !kIsWeb && _isWhisperInitialized) {
      log('VoiceInputService: Using Whisper for on-device recording');
      try {
        if (await _recorder.hasPermission()) {
          final tempDir = await getTemporaryDirectory();
          _recordingPath = '${tempDir.path}/whisper_audio.m4a';
          
          await _recorder.start(const RecordConfig(), path: _recordingPath!);
          onResult("Listening (On-Device Recording)...", false);
        } else {
          onResult("Microphone permission denied", true);
        }
      } catch (e) {
        log('Failed to start recorder: $e');
        onResult("Error starting recorder: $e", true);
      }
      return;
    }

    if (!_hasSpeechAvailable) {
      throw StateError('Speech recognition not available on this device or permission denied.');
    }

    log('VoiceInputService: Using standard STT');
    await _speech.listen(
      onResult: (result) {
        onResult(result.recognizedWords, result.finalResult);
      },
      localeId: config.language,
      listenOptions: stt.SpeechListenOptions(
        cancelOnError: true,
        partialResults: true,
      ),
    );
  }

  /// Stop listening and process audio if using Whisper.
  Future<void> stopListening({void Function(String result)? onTranscriptionComplete}) async {
    log('VoiceInputService.stopListening called');
    if (config.whisperOnDevice && !kIsWeb && _recordingPath != null) {
      final path = await _recorder.stop();
      if (path != null && onTranscriptionComplete != null) {
        onTranscriptionComplete("Transcribing...");
        final transcript = await transcribe(path);
        onTranscriptionComplete(transcript ?? "No transcription result");
      }
    } else {
      await _speech.stop();
    }
  }
  
  /// Cancel listening completely.
  Future<void> cancelListening() async {
    if (config.whisperOnDevice && !kIsWeb) {
      await _recorder.stop();
    } else {
      await _speech.cancel();
    }
  }

  /// Transcribe audio file using Whisper.
  Future<String?> transcribe(String filePath) async {
    if (!config.whisperOnDevice || !_isWhisperInitialized || _whisper == null) {
      return null;
    }
    try {
      log('VoiceInputService.transcribe: $filePath');
      final result = await _whisper!.transcribeFromFile(
        filePath,
      );
      return result?.text;
    } catch (e) {
      log('VoiceInputService.transcribe failed: $e');
      return null;
    }
  }

  /// Speak the given text using TTS.
  Future<void> speak(String text) async {
    if (!config.voiceFeedbackEnabled) return;
    try {
      log('VoiceInputService.speak: "$text"');
      await _tts.speak(text);
    } catch (e) {
      log('VoiceInputService.speak failed: $e');
    }
  }

  /// Stop speaking.
  Future<void> stopSpeaking() async {
    await _tts.stop();
  }

  /// Dispose resources.
  void dispose() {
    _speech.cancel();
    _tts.stop();
    _recorder.dispose();
  }

  /// Whether speech recognition is available.
  bool get isSpeechRecognitionAvailable => _hasSpeechAvailable;

  /// Whether TTS is available.
  bool get isTtsAvailable => config.voiceFeedbackEnabled;
}