import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/theme/theme_cubit.dart';
import '../../../../core/ai/ai_config_cubit.dart';

class AiConfigScreen extends StatelessWidget {
  const AiConfigScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AI & Voice Configuration'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: Icon(Theme.of(context).brightness == Brightness.light
                ? Icons.dark_mode
                : Icons.light_mode),
            onPressed: () => context.read<ThemeCubit>().toggleTheme(Theme.of(context).brightness),
            tooltip: 'Toggle Theme',
          ),
        ],
      ),
      body: BlocBuilder<AiConfigCubit, AiConfigState>(
        builder: (context, state) {
          final config = state.config;
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ── AI Enable/Disable ─────────────────────────────────────
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.smart_toy, color: Colors.blue),
                            const SizedBox(width: 12),
                            const Text(
                              'AI Assistant',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const Spacer(),
                            Switch(
                              value: config.enabled,
                              onChanged: (value) {
                                context.read<AiConfigCubit>().updateConfig(
                                      config.copyWith(enabled: value),
                                    );
                              },
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Enable AI-powered voice input and smart suggestions',
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(color: Colors.grey.shade600),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                // ── Voice Input Settings ──────────────────────────────────
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Voice Input',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 12),
                        ListTile(
                          contentPadding: EdgeInsets.zero,
                          leading: const Icon(Icons.mic, color: Colors.green),
                          title: const Text('Whisper Model'),
                          subtitle: const Text('Speech-to-text model for voice input'),
                          trailing: DropdownButton<String>(
                            value: config.whisperModel,
                            items: const [
                              DropdownMenuItem(
                                value: 'tiny',
                                child: Text('Tiny (fastest)'),
                              ),
                              DropdownMenuItem(
                                value: 'base',
                                child: Text('Base (balanced)'),
                              ),
                              DropdownMenuItem(
                                value: 'small',
                                child: Text('Small (accurate)'),
                              ),
                              DropdownMenuItem(
                                value: 'medium',
                                child: Text('Medium (high accuracy)'),
                              ),
                            ],
                            onChanged: (value) {
                              if (value != null) {
                                context.read<AiConfigCubit>().updateConfig(
                                      config.copyWith(whisperModel: value),
                                    );
                              }
                            },
                          ),
                        ),
                        SwitchListTile(
                          contentPadding: EdgeInsets.zero,
                          title: const Text('On‑Device Processing'),
                          subtitle: const Text(
                              'Process speech locally for privacy (requires download)'),
                          value: config.whisperOnDevice,
                          onChanged: (value) {
                            context.read<AiConfigCubit>().updateConfig(
                                  config.copyWith(whisperOnDevice: value),
                                );
                          },
                        ),
                        const Divider(),
                        ListTile(
                          contentPadding: EdgeInsets.zero,
                          leading: const Icon(Icons.language, color: Colors.orange),
                          title: const Text('Language'),
                          subtitle: const Text('Preferred language for voice input'),
                          trailing: DropdownButton<String>(
                            value: config.language,
                            items: const [
                              DropdownMenuItem(
                                value: 'en',
                                child: Text('English'),
                              ),
                              DropdownMenuItem(
                                value: 'es',
                                child: Text('Spanish'),
                              ),
                              DropdownMenuItem(
                                value: 'fr',
                                child: Text('French'),
                              ),
                              DropdownMenuItem(
                                value: 'de',
                                child: Text('German'),
                              ),
                              DropdownMenuItem(
                                value: 'zh',
                                child: Text('Chinese'),
                              ),
                            ],
                            onChanged: (value) {
                              if (value != null) {
                                context.read<AiConfigCubit>().updateConfig(
                                      config.copyWith(language: value),
                                    );
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                // ── LLM Provider Settings ─────────────────────────────────
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'LLM Provider',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 12),
                        // Provider selection dropdown
                        ListTile(
                          contentPadding: EdgeInsets.zero,
                          leading: const Icon(Icons.cloud, color: Colors.blue),
                          title: const Text('LLM Provider'),
                          subtitle: const Text('Choose which LLM service to use'),
                          trailing: DropdownButton<String>(
                            value: config.llmProvider,
                            items: const [
                              DropdownMenuItem(
                                value: 'openai',
                                child: Text('OpenAI'),
                              ),
                              DropdownMenuItem(
                                value: 'openrouter',
                                child: Text('OpenRouter'),
                              ),
                              DropdownMenuItem(
                                value: 'gemini',
                                child: Text('Google Gemini'),
                              ),
                              DropdownMenuItem(
                                value: 'ollama',
                                child: Text('Ollama (Local)'),
                              ),
                            ],
                            onChanged: (value) {
                              if (value != null) {
                                // When provider changes, update both llmProvider and useLocalLlm
                                final isLocal = value == 'ollama';
                                context.read<AiConfigCubit>().updateConfig(
                                  config.copyWith(
                                    llmProvider: value,
                                    useLocalLlm: isLocal,
                                  ),
                                );
                              }
                            },
                          ),
                        ),
                        const SizedBox(height: 8),
                        // Show API key fields for OpenAI and Gemini (non-local)
                        if (config.llmProvider == 'openai' || config.llmProvider == 'gemini' || config.llmProvider == 'openrouter') ...[
                          TextField(
                            decoration: InputDecoration(
                              labelText: config.llmProvider == 'openai'
                                ? 'OpenAI API Key'
                                : config.llmProvider == 'gemini'
                                  ? 'Gemini API Key'
                                  : 'OpenRouter API Key',
                              hintText: 'Enter your API key',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              prefixIcon: const Icon(Icons.key),
                            ),
                            obscureText: true,
                            onChanged: (value) {
                              context.read<AiConfigCubit>().updateConfig(
                                    config.copyWith(openAiApiKey: value),
                                  );
                            },
                          ),
                          const SizedBox(height: 12),
                          TextField(
                            decoration: InputDecoration(
                              labelText: 'Base URL (optional)',
                              hintText: config.llmProvider == 'openai'
                                ? 'https://api.openai.com/v1'
                                : config.llmProvider == 'gemini'
                                  ? 'https://generativelanguage.googleapis.com/v1beta/openai'
                                  : 'https://openrouter.ai/api/v1',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              prefixIcon: const Icon(Icons.link),
                            ),
                            onChanged: (value) {
                              context.read<AiConfigCubit>().updateConfig(
                                    config.copyWith(openAiBaseUrl: value),
                                  );
                            },
                          ),
                          const SizedBox(height: 12),
                          TextField(
                            decoration: InputDecoration(
                              labelText: 'Model',
                              hintText: config.llmProvider == 'openai'
                                ? 'gpt-3.5-turbo'
                                : 'gemini-1.5-pro',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              prefixIcon: const Icon(Icons.model_training),
                            ),
                            onChanged: (value) {
                              context.read<AiConfigCubit>().updateConfig(
                                    config.copyWith(llmModel: value),
                                  );
                            },
                          ),
                          const SizedBox(height: 12),
                        ],
                        // For Ollama, show local configuration
                        if (config.llmProvider == 'ollama') ...[
                          ListTile(
                            contentPadding: EdgeInsets.zero,
                            leading: const Icon(Icons.computer, color: Colors.green),
                            title: const Text('Local LLM (Ollama)'),
                            subtitle: const Text('Run LLM locally on your machine'),
                          ),
                          const SizedBox(height: 8),
                          TextField(
                            decoration: InputDecoration(
                              labelText: 'Ollama Base URL',
                              hintText: 'http://localhost:11434/v1',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              prefixIcon: const Icon(Icons.link),
                            ),
                            onChanged: (value) {
                              context.read<AiConfigCubit>().updateConfig(
                                    config.copyWith(openAiBaseUrl: value),
                                  );
                            },
                          ),
                          const SizedBox(height: 12),
                          TextField(
                            decoration: InputDecoration(
                              labelText: 'Model',
                              hintText: 'llama3',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              prefixIcon: const Icon(Icons.model_training),
                            ),
                            onChanged: (value) {
                              context.read<AiConfigCubit>().updateConfig(
                                    config.copyWith(llmModel: value),
                                  );
                            },
                          ),
                          const SizedBox(height: 12),
                        ],
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                // ── Features ──────────────────────────────────────────────
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Features',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 12),
                        SwitchListTile(
                          contentPadding: EdgeInsets.zero,
                          title: const Text('Proactive Suggestions'),
                          subtitle: const Text(
                              'AI suggests patterns and reminders based on data'),
                          value: config.proactiveSuggestionsEnabled,
                          onChanged: (value) {
                            context.read<AiConfigCubit>().updateConfig(
                                  config.copyWith(
                                    proactiveSuggestionsEnabled: value,
                                  ),
                                );
                          },
                        ),
                        SwitchListTile(
                          contentPadding: EdgeInsets.zero,
                          title: const Text('Voice Feedback'),
                          subtitle: const Text(
                              'Read back logged entries with text‑to‑speech'),
                          value: config.voiceFeedbackEnabled,
                          onChanged: (value) {
                            context.read<AiConfigCubit>().updateConfig(
                                  config.copyWith(
                                    voiceFeedbackEnabled: value,
                                  ),
                                );
                          },
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                // ── Actions ───────────────────────────────────────────────
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () {
                          context.read<AiConfigCubit>().resetToDefault();
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Reset to default configuration'),
                            ),
                          );
                        },
                        icon: const Icon(Icons.restore),
                        label: const Text('Reset to Default'),
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () {
                          // The config is already saved via updateConfig calls
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Configuration saved'),
                            ),
                          );
                          Navigator.pop(context);
                        },
                        icon: const Icon(Icons.save),
                        label: const Text('Save & Close'),
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 32),
              ],
            ),
          );
        },
      ),
    );
  }
}