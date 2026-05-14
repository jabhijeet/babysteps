import 'package:equatable/equatable.dart';
import '../../../core/database/app_database.dart';
import '../../../core/ai/ai_config.dart';
import '../../../core/ai/voice_input_service.dart';

// --- Events ---
abstract class LoggingEvent extends Equatable {
  const LoggingEvent();
  @override
  List<Object?> get props => [];
}

class SaveFeedLogEvent extends LoggingEvent {
  const SaveFeedLogEvent({
    required this.babyId,
    required this.type,
    required this.startTime,
    this.endTime,
    this.volumeAmount,
    this.volumeUnit,
    this.breastSide,
    this.leftDuration,
    this.rightDuration,
    this.formulaBrand,
    this.formulaTemp,
    this.solidFoodReaction,
    this.solidFoodReactionPhotoPath,
    this.notes,
  });

  final int babyId;
  final String type;
  final DateTime startTime;
  final DateTime? endTime;
  final double? volumeAmount;
  final String? volumeUnit;
  final String? breastSide;
  final int? leftDuration;
  final int? rightDuration;
  final String? formulaBrand;
  final double? formulaTemp;
  final String? solidFoodReaction;
  final String? solidFoodReactionPhotoPath;
  final String? notes;
}

class SaveSleepLogEvent extends LoggingEvent {
  const SaveSleepLogEvent({
    required this.babyId,
    required this.startTime,
    this.endTime,
    this.notes,
  });

  final int babyId;
  final DateTime startTime;
  final DateTime? endTime;
  final String? notes;
}

class SaveDiaperLogEvent extends LoggingEvent {
  const SaveDiaperLogEvent({
    required this.babyId,
    required this.startTime,
    this.endTime,
    required this.type,
    this.consistency,
    this.color,
    this.notes,
  });

  final int babyId;
  final DateTime startTime;
  final DateTime? endTime;
  final String type;
  final String? consistency;
  final String? color;
  final String? notes;
}

class SaveGrowthLogEvent extends LoggingEvent {
  const SaveGrowthLogEvent({
    required this.babyId,
    required this.startTime,
    this.endTime,
    this.weight,
    this.height,
    this.headCircumference,
    this.notes,
  });

  final int babyId;
  final DateTime startTime;
  final DateTime? endTime;
  final double? weight;
  final double? height;
  final double? headCircumference;
  final String? notes;
}

class SaveActivityLogEvent extends LoggingEvent {
  const SaveActivityLogEvent({
    required this.babyId,
    required this.type,
    required this.startTime,
    this.endTime,
    this.milestones,
    this.notes,
  });

  final int babyId;
  final String type;
  final DateTime startTime;
  final DateTime? endTime;
  final String? milestones;
  final String? notes;
}

class SaveMedicalLogEvent extends LoggingEvent {
  const SaveMedicalLogEvent({
    required this.babyId,
    required this.type,
    required this.name,
    this.dosage,
    required this.startTime,
    this.endTime,
    this.reminderTime,
    this.notes,
  });

  final int babyId;
  final String type;
  final String name;
  final String? dosage;
  final DateTime startTime;
  final DateTime? endTime;
  final DateTime? reminderTime;
  final String? notes;
}

/// Voice input processing event.
class ProcessVoiceInputEvent extends LoggingEvent {
  const ProcessVoiceInputEvent({
    required this.babyId,
    required this.transcript,
    this.aiConfig,
    this.voiceService,
  });

  final int babyId;
  final String transcript;
  final AiConfig? aiConfig;
  final VoiceInputService? voiceService;
}

// Update Events
class UpdateFeedLogEvent extends LoggingEvent {
  const UpdateFeedLogEvent(this.log);
  final FeedingLog log;
}

class UpdateSleepLogEvent extends LoggingEvent {
  const UpdateSleepLogEvent(this.log);
  final SleepLog log;
}

class UpdateDiaperLogEvent extends LoggingEvent {
  const UpdateDiaperLogEvent(this.log);
  final DiaperLog log;
}

class UpdateGrowthLogEvent extends LoggingEvent {
  const UpdateGrowthLogEvent(this.log);
  final GrowthLog log;
}

class UpdateActivityLogEvent extends LoggingEvent {
  const UpdateActivityLogEvent(this.log);
  final ActivityLog log;
}

class UpdateMedicalLogEvent extends LoggingEvent {
  const UpdateMedicalLogEvent(this.log);
  final MedicalLog log;
}