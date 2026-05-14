import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/database/repositories/log_repositories.dart';
import '../../../core/database/repositories/baby_repository.dart';
import '../../../core/network/notification_service.dart';
import '../../../core/ai/intent_parser.dart';
import '../../../core/ai/ai_config.dart';
import '../../../core/ai/proactive_engine_service.dart';
import '../../../core/ai/ai_config_service.dart';
import '../../../core/error/error_handler.dart';
import 'package:drift/drift.dart' show Value;

import 'logging_events.dart';
import 'logging_states.dart';

export 'logging_events.dart';
export 'logging_states.dart';

// --- Bloc ---
class LoggingBloc extends Bloc<LoggingEvent, LoggingState> {
  LoggingBloc({
    required this.feedingRepo,
    required this.sleepRepo,
    required this.diaperRepo,
    required this.activityRepo,
    required this.medicalRepo,
    required this.growthRepo,
    required this.babyRepo,
    required this.aiConfigService,
    required this.proactiveEngine,
    required this.notificationService,
  }) : super(LoggingInitial()) {
    on<SaveFeedLogEvent>(_onSaveFeedLog);
    on<SaveSleepLogEvent>(_onSaveSleepLog);
    on<SaveDiaperLogEvent>(_onSaveDiaperLog);
    on<SaveGrowthLogEvent>(_onSaveGrowthLog);
    on<SaveActivityLogEvent>(_onSaveActivityLog);
    on<SaveMedicalLogEvent>(_onSaveMedicalLog);
    on<UpdateFeedLogEvent>(_onUpdateFeedLog);
    on<UpdateSleepLogEvent>(_onUpdateSleepLog);
    on<UpdateDiaperLogEvent>(_onUpdateDiaperLog);
    on<UpdateGrowthLogEvent>(_onUpdateGrowthLog);
    on<UpdateActivityLogEvent>(_onUpdateActivityLog);
    on<UpdateMedicalLogEvent>(_onUpdateMedicalLog);
    on<ProcessVoiceInputEvent>(_onProcessVoiceInput);
  }

  final FeedingLogRepository feedingRepo;
  final SleepLogRepository sleepRepo;
  final DiaperLogRepository diaperRepo;
  final GrowthLogRepository growthRepo;
  final ActivityLogRepository activityRepo;
  final MedicalLogRepository medicalRepo;
  final BabyRepository babyRepo;
  final NotificationService notificationService;

  final AiConfigService aiConfigService;
  final ProactiveEngineService proactiveEngine;

  /// Helper method to handle errors consistently
  LoggingFailure _handleError(dynamic error, StackTrace stackTrace, String context) {
    final appError = ErrorHandler.handleError(
      error,
      stackTrace: stackTrace,
      context: 'LoggingBloc.$context',
      logError: true,
    );
    return LoggingFailure(appError);
  }

  Future<void> _onUpdateFeedLog(UpdateFeedLogEvent event, Emitter<LoggingState> emit) async {
    emit(LoggingLoading());
    try {
      await feedingRepo.updateFeedingLog(event.log);
      emit(LoggingSuccess());
    } catch (e, stackTrace) {
      emit(_handleError(e, stackTrace, 'updateFeedLog'));
    }
  }

  Future<void> _onUpdateSleepLog(UpdateSleepLogEvent event, Emitter<LoggingState> emit) async {
    emit(LoggingLoading());
    try {
      await sleepRepo.updateSleepLog(event.log);
      emit(LoggingSuccess());
    } catch (e, stackTrace) {
      emit(_handleError(e, stackTrace, 'updateSleepLog'));
    }
  }

  Future<void> _onUpdateDiaperLog(UpdateDiaperLogEvent event, Emitter<LoggingState> emit) async {
    emit(LoggingLoading());
    try {
      await diaperRepo.updateDiaperLog(event.log);
      emit(LoggingSuccess());
    } catch (e, stackTrace) {
      emit(_handleError(e, stackTrace, 'updateDiaperLog'));
    }
  }

  Future<void> _onUpdateGrowthLog(UpdateGrowthLogEvent event, Emitter<LoggingState> emit) async {
    emit(LoggingLoading());
    try {
      await growthRepo.updateGrowthLog(event.log);
      emit(LoggingSuccess());
    } catch (e, stackTrace) {
      emit(_handleError(e, stackTrace, 'updateGrowthLog'));
    }
  }

  Future<void> _onUpdateActivityLog(UpdateActivityLogEvent event, Emitter<LoggingState> emit) async {
    emit(LoggingLoading());
    try {
      await activityRepo.updateActivityLog(event.log);
      emit(LoggingSuccess());
    } catch (e, stackTrace) {
      emit(_handleError(e, stackTrace, 'updateActivityLog'));
    }
  }

  Future<void> _onUpdateMedicalLog(UpdateMedicalLogEvent event, Emitter<LoggingState> emit) async {
    emit(LoggingLoading());
    try {
      await medicalRepo.updateMedicalLog(event.log);
      emit(LoggingSuccess());
    } catch (e, stackTrace) {
      emit(_handleError(e, stackTrace, 'updateMedicalLog'));
    }
  }

  Future<void> _onSaveFeedLog(SaveFeedLogEvent event, Emitter<LoggingState> emit) async {
    emit(LoggingLoading());
    try {
      await feedingRepo.addFeedingLog(
        babyId: event.babyId,
        type: event.type,
        startTime: event.startTime,
        endTime: event.endTime,
        volumeAmount: event.volumeAmount,
        volumeUnit: event.volumeUnit,
        breastSide: event.breastSide,
        leftDurationSeconds: event.leftDuration,
        rightDurationSeconds: event.rightDuration,
        formulaBrand: event.formulaBrand,
        formulaTemp: event.formulaTemp,
        solidFoodReaction: event.solidFoodReaction,
        solidFoodReactionPhotoPath: event.solidFoodReactionPhotoPath,
        notes: event.notes,
      );

      // Check for feeding insights
      final config = await aiConfigService.loadConfig();
      if (config.proactiveSuggestionsEnabled) {
        final insight = await proactiveEngine.getFeedingInsights(event.babyId);
        if (insight['status'] != 'healthy' && insight['status'] != 'neutral') {
          if (insight['status'] == 'alert' || insight['status'] == 'warning' || insight['status'] == 'reminder') {
             await notificationService.scheduleReminder(
               event.babyId * 1000 + 2, // Unique ID for feeding alert
               'Feeding Insight',
               (insight['message'] as Object?).toString(),
               DateTime.now().add(const Duration(seconds: 1)),
             );
          }
        }
      }

      emit(LoggingSuccess());
    } catch (e, stackTrace) {
      emit(_handleError(e, stackTrace, 'saveFeedLog'));
    }
  }

  Future<void> _onSaveSleepLog(SaveSleepLogEvent event, Emitter<LoggingState> emit) async {
    emit(LoggingLoading());
    try {
      await sleepRepo.addSleepLog(
        babyId: event.babyId,
        startTime: event.startTime,
        endTime: event.endTime,
        notes: event.notes,
      );

      // Automatically schedule a Wake Window reminder if sleep ended
      final config = await aiConfigService.loadConfig();
      if (event.endTime != null && config.proactiveSuggestionsEnabled) {
        final wakeWindowMinutes = await proactiveEngine.getOptimalWakeWindow(event.babyId);
        await notificationService.scheduleWakeWindowReminder(event.babyId, event.endTime!, wakeWindowMinutes);
      } else {
        // If sleep started, cancel existing reminders
        await notificationService.cancelReminder(event.babyId * 1000 + 1);
      }

      emit(LoggingSuccess());
    } catch (e, stackTrace) {
      emit(_handleError(e, stackTrace, 'saveSleepLog'));
    }
  }

  Future<void> _onSaveDiaperLog(SaveDiaperLogEvent event, Emitter<LoggingState> emit) async {
    emit(LoggingLoading());
    try {
      await diaperRepo.addDiaperLog(
        babyId: event.babyId,
        startTime: event.startTime,
        endTime: event.endTime,
        type: event.type,
        consistency: event.consistency,
        color: event.color,
        notes: event.notes,
      );
      emit(LoggingSuccess());
    } catch (e, stackTrace) {
      emit(_handleError(e, stackTrace, 'saveDiaperLog'));
    }
  }

  Future<void> _onSaveGrowthLog(SaveGrowthLogEvent event, Emitter<LoggingState> emit) async {
    emit(LoggingLoading());
    try {
      await growthRepo.addGrowthLog(
        babyId: event.babyId,
        startTime: event.startTime,
        endTime: event.endTime,
        weight: event.weight,
        height: event.height,
        headCircumference: event.headCircumference,
        notes: event.notes,
      );
      emit(LoggingSuccess());
    } catch (e, stackTrace) {
      emit(_handleError(e, stackTrace, 'saveGrowthLog'));
    }
  }

  Future<void> _onSaveActivityLog(SaveActivityLogEvent event, Emitter<LoggingState> emit) async {
    emit(LoggingLoading());
    try {
      await activityRepo.addActivityLog(
        babyId: event.babyId,
        type: event.type,
        startTime: event.startTime,
        endTime: event.endTime,
        milestones: event.milestones,
        notes: event.notes,
      );
      emit(LoggingSuccess());
    } catch (e, stackTrace) {
      emit(_handleError(e, stackTrace, 'saveActivityLog'));
    }
  }

  Future<void> _onSaveMedicalLog(SaveMedicalLogEvent event, Emitter<LoggingState> emit) async {
    emit(LoggingLoading());
    try {
      await medicalRepo.addMedicalLog(
        babyId: event.babyId,
        type: event.type,
        name: event.name,
        dosage: event.dosage,
        startTime: event.startTime,
        endTime: event.endTime,
        reminderTime: event.reminderTime,
        notes: event.notes,
      );

      if (event.reminderTime != null) {
        await notificationService.scheduleReminder(
          event.babyId * 1000 + 2, // 2 indicates medical reminder category
          'Medical Reminder: ${event.name}',
          'Time for ${event.type.toLowerCase()}',
          event.reminderTime!,
        );
      }
      emit(LoggingSuccess());
    } catch (e, stackTrace) {
      emit(_handleError(e, stackTrace, 'saveMedicalLog'));
    }
  }

  /// Process voice input transcript and execute corresponding logging action.
  Future<void> _onProcessVoiceInput(ProcessVoiceInputEvent event, Emitter<LoggingState> emit) async {
    emit(LoggingLoading());
    log('_onProcessVoiceInput: babyId=${event.babyId}, transcript="${event.transcript}"');
    try {
      final config = event.aiConfig ?? AiConfig.defaultConfig;
      final parser = IntentParser(config: config);
      final intent = await parser.parse(event.transcript);

      log('Parsed intent: $intent');

      // Execute the intent
      final now = DateTime.now();
      switch (intent.logType) {
        case 'feed':
          log('_onProcessVoiceInput: feed intent, adding SaveFeedLogEvent');
          add(SaveFeedLogEvent(
            babyId: event.babyId,
            type: 'breast', // Default, could be parsed from parameters
            startTime: now,
            notes: 'Voice command: ${event.transcript}',
          ));
          break;
        case 'sleep':
          log('_onProcessVoiceInput: sleep intent, action=${intent.action}');
          if (intent.action == 'start') {
            add(SaveSleepLogEvent(
              babyId: event.babyId,
              startTime: now,
              notes: 'Voice command: ${event.transcript}',
            ));
          } else if (intent.action == 'stop') {
            final latestLog = await sleepRepo.getLatestSleepLog(event.babyId);
            if (latestLog != null && latestLog.endTime == null) {
              await sleepRepo.updateSleepLog(latestLog.copyWith(endTime: Value(now)));
              log('_onProcessVoiceInput: stopped active sleep log ${latestLog.id}');
              if (config.voiceFeedbackEnabled) {
                await event.voiceService?.speak('Ok, I\'ve recorded that the baby is awake.');
              }
            } else {
              log('_onProcessVoiceInput: no active sleep log found to stop');
              if (config.voiceFeedbackEnabled) {
                await event.voiceService?.speak('I couldn\'t find an active sleep session to stop.');
              }
            }
          } else {
            add(SaveSleepLogEvent(
              babyId: event.babyId,
              startTime: now,
              notes: 'Voice command: ${event.transcript}',
            ));
          }
          break;
        case 'diaper':
          log('_onProcessVoiceInput: diaper intent, adding SaveDiaperLogEvent');
          add(SaveDiaperLogEvent(
            babyId: event.babyId,
            startTime: now,
            type: 'wet', // Default, could be parsed from parameters
            notes: 'Voice command: ${event.transcript}',
          ));
          break;
        case 'growth':
          // Growth logs need measurements; voice command might not provide them
          log('Growth logging via voice requires measurements. Prompt user.');
          break;
        case 'activity':
          log('_onProcessVoiceInput: activity intent, adding SaveActivityLogEvent');
          add(SaveActivityLogEvent(
            babyId: event.babyId,
            type: 'play', // Default
            startTime: now,
            notes: 'Voice command: ${event.transcript}',
          ));
          break;
        case 'medical':
          // Medical logs need more details
          log('Medical logging via voice requires details. Prompt user.');
          break;
        default:
          log('Unknown log type: ${intent.logType}');
      }

      if (config.voiceFeedbackEnabled && (intent.logType != 'sleep' || (intent.logType == 'sleep' && intent.action != 'stop'))) {
        String feedback = 'Ok, I\'ve logged that';
        final params = intent.parameters;

        switch (intent.logType) {
          case 'feed':
            final amount = params['volumeAmount'];
            final unit = params['volumeUnit'] ?? 'ml';
            final side = params['breastSide'];
            if (amount != null) {
              feedback = 'Ok, I\'ve logged $amount $unit of milk.';
            } else if (side != null) {
              feedback = 'Ok, I\'ve logged breastfeeding on the $side side.';
            } else {
              feedback = 'Ok, I\'ve logged a feeding session.';
            }
            break;
          case 'sleep':
            feedback = 'Ok, I\'ve started a sleep timer.';
            break;
          case 'diaper':
            final type = params['type'] ?? 'wet';
            feedback = 'Ok, I\'ve logged a $type diaper.';
            break;
          case 'activity':
            feedback = 'Ok, I\'ve logged an activity session.';
            break;
          default:
            feedback = 'Ok, I\'ve recorded that ${intent.logType} session.';
        }
        await event.voiceService?.speak(feedback);
      }

      emit(const LoggingSuccess('Voice command processed successfully'));
    } catch (e, stackTrace) {
      emit(_handleError(e, stackTrace, 'processVoiceInput'));
    }
  }
}