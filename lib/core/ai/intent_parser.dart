import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'ai_config.dart';

/// Represents a parsed intent from natural language.
class ParsedIntent {
  ParsedIntent({
    required this.logType,
    required this.action,
    required this.parameters,
    required this.confidence,
    required this.transcript,
  });

  /// Type of log: 'feed', 'sleep', 'diaper', 'growth', 'activity', 'medical'
  final String logType;

  /// Action: 'start', 'stop', 'log'
  final String action;

  /// Extracted parameters (key-value pairs).
  final Map<String, dynamic> parameters;

  /// Confidence score (0.0 to 1.0).
  final double confidence;

  /// Raw transcript.
  final String transcript;

  @override
  String toString() {
    return 'ParsedIntent(logType: $logType, action: $action, parameters: $parameters, confidence: $confidence)';
  }
}

/// Parses natural language into structured logging intents.
/// Supports rule‑based matching and optional LLM‑based parsing.
class IntentParser {
  IntentParser({required this.config, http.Client? client})
      : httpClient = client ?? http.Client();

  final AiConfig config;
  final http.Client? httpClient;

  /// Parse a transcript into a structured intent.
  Future<ParsedIntent> parse(String transcript) async {
    log('IntentParser.parse: "$transcript"');
    // First try rule‑based parsing (fast, offline).
    final ruleBased = _ruleBasedParse(transcript);
    log('Rule‑based result: $ruleBased');
    if (ruleBased.confidence >= 0.8) {
      log('Rule‑based confidence high, returning');
      return ruleBased;
    }

    // If LLM is available and confidence is low, fall back to LLM.
    if (config.hasLlm) {
      log('LLM available, attempting LLM parse');
      try {
        final llmResult = await _llmParse(transcript);
        log('LLM result: $llmResult');
        return llmResult;
      } catch (e) {
        log('LLM parsing failed: $e');
        // Fall back to rule‑based with lower confidence.
        return ruleBased;
      }
    }

    log('No LLM, returning rule‑based');
    return ruleBased;
  }

  /// Rule‑based parsing using keyword matching.
  ParsedIntent _ruleBasedParse(String transcript) {
    final lower = transcript.toLowerCase();

    // Determine log type
    String logType = 'unknown';
    double typeConfidence = 0.0;
    final Map<String, List<String>> typeKeywords = {
      'feed': ['feed', 'breast', 'bottle', 'formula', 'milk', 'nurse', 'eating'],
      'sleep': ['sleep', 'nap', 'bed', 'tired', 'awake'],
      'diaper': ['diaper', 'pee', 'poop', 'wet', 'dirty', 'change'],
      'growth': ['weight', 'height', 'measure', 'growth', 'percentile'],
      'activity': ['play', 'tummy', 'walk', 'activity', 'exercise'],
      'medical': ['medicine', 'fever', 'temperature', 'vaccine', 'sick'],
    };

    for (final entry in typeKeywords.entries) {
      for (final keyword in entry.value) {
        if (lower.contains(keyword)) {
          logType = entry.key;
          typeConfidence = 0.9;
          log('_ruleBasedParse: matched keyword "$keyword" -> logType=$logType');
          break;
        }
      }
      if (typeConfidence > 0) break;
    }

    // Determine action
    String action = 'log';
    double actionConfidence = 0.0;
    if (lower.contains('start') || lower.contains('begin')) {
      action = 'start';
      actionConfidence = 0.9;
    } else if (lower.contains('stop') || lower.contains('end') || lower.contains('finish')) {
      action = 'stop';
      actionConfidence = 0.9;
    } else {
      actionConfidence = 0.7;
    }
    log('_ruleBasedParse: action=$action, actionConfidence=$actionConfidence');

    // Extract parameters (simplistic)
    final params = <String, dynamic>{};
    if (logType == 'feed') {
      if (lower.contains('left')) params['breastSide'] = 'left';
      if (lower.contains('right')) params['breastSide'] = 'right';
      final volumeMatch = RegExp(r'(\d+(\.\d+)?)\s*(ml|oz|milliliter|ounce)').firstMatch(lower);
      if (volumeMatch != null) {
        params['volumeAmount'] = double.tryParse(volumeMatch.group(1)!);
        params['volumeUnit'] = volumeMatch.group(3);
      }
    } else if (logType == 'diaper') {
      if (lower.contains('wet')) params['type'] = 'wet';
      if (lower.contains('dirty') || lower.contains('poop')) params['type'] = 'dirty';
      if (lower.contains('both')) params['type'] = 'both';
    }
    log('_ruleBasedParse: extracted parameters=$params');

    // Overall confidence is average of type and action confidence.
    final confidence = (typeConfidence + actionConfidence) / 2.0;

    return ParsedIntent(
      logType: logType,
      action: action,
      parameters: params,
      confidence: confidence,
      transcript: transcript,
    );
  }

  /// LLM‑based parsing using OpenAI‑compatible API.
  Future<ParsedIntent> _llmParse(String transcript) async {
    final prompt = '''
You are a baby‑care assistant. Parse the following voice command into a structured intent.

Command: "$transcript"

Return a JSON object with:
- "logType": one of "feed", "sleep", "diaper", "growth", "activity", "medical", "unknown"
- "action": one of "start", "stop", "log"
- "parameters": a JSON object with relevant fields (e.g., "volumeAmount", "breastSide", "type", etc.)
- "confidence": a float between 0 and 1

Only return the JSON, no extra text.
''';

    String baseUrl = config.effectiveBaseUrl;
    if (!baseUrl.endsWith('/chat/completions')) {
      if (baseUrl.endsWith('/')) {
        baseUrl += 'chat/completions';
      } else {
        baseUrl += '/chat/completions';
      }
    }
    final uri = Uri.parse(baseUrl);

    final headers = {
      'Content-Type': 'application/json',
      if (config.openAiApiKey != null) 'Authorization': 'Bearer ${config.openAiApiKey!}',
    };

    final body = jsonEncode({
      'model': config.llmModel ?? 'gpt-3.5-turbo',
      'messages': [
        {'role': 'system', 'content': 'You are a helpful baby‑care assistant.'},
        {'role': 'user', 'content': prompt},
      ],
      'temperature': 0.1,
      'max_tokens': 200,
    });

    final response = await httpClient!.post(uri, headers: headers, body: body);
    if (response.statusCode != 200) {
      throw Exception('LLM API error: ${response.statusCode} ${response.body}');
    }

    final jsonResponse = jsonDecode(response.body);
    final content = jsonResponse['choices'][0]['message']['content'];
    final parsedJson = jsonDecode(content as String) as Map<String, dynamic>;

    return ParsedIntent(
      logType: (parsedJson['logType'] as String?) ?? 'unknown',
      action: (parsedJson['action'] as String?) ?? 'log',
      parameters: Map<String, dynamic>.from((parsedJson['parameters'] as Map?) ?? {}),
      confidence: (parsedJson['confidence'] as num?)?.toDouble() ?? 0.5,
      transcript: transcript,
    );
  }

  /// Dispose HTTP client if owned.
  void dispose() {
    httpClient?.close();
  }
}