# LLM_AGENT_PROJECT_LEARNINGS
> LLM AGENT MEMORY: READ BEFORE STARTING TASKS. UPDATE ON FAILURES.

- [STYLE] Replace `print` with `log` from `dart:developer` to satisfy `avoid_print` lint rule in Dart/Flutter production code.
- [STYLE] Unused import warnings can be safely removed if the type is still accessible via transitive imports; always verify with flutter analyze.
- [INTEGRATION] Voice input and LLM provider settings were missing from UI. To integrate:
  1. Ensure `VoiceInputService` is instantiated with current `AiConfig` from `AiConfigCubit`.
  2. Add a microphone button in the app bar actions that calls `_startVoiceInput` method.
  3. The method should capture `LoggingBloc` and `ScaffoldMessenger` before async gaps to avoid `use_build_context_synchronously` lint.
  4. Dispatch `ProcessVoiceInputEvent` with transcript and babyId.
  5. LLM provider settings are accessible via the "AI & Voice Configuration" tile in the settings drawer (already present).
  6. Verify integration with `dart analyze` and ensure no lint warnings.
- [DART] When adding a new final field to a Dart class with a const constructor, ensure it has a default value or is properly initialized in all constructors. Otherwise, Dart compiler will throw 'All final variables must be initialized' error.