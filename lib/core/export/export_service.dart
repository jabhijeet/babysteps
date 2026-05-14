library;

/// Data export functionality for BabySteps app.
/// Supports CSV and PDF formats for exporting baby logs.

import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import '../database/repositories/log_repositories.dart';
import '../database/repositories/baby_repository.dart';
import '../error/error_handler.dart';

/// Supported export formats.
enum ExportFormat {
  csv,
  pdf,
}

/// Configuration for data export.
class ExportConfig {
  const ExportConfig({
    required this.babyId,
    required this.startDate,
    required this.endDate,
    this.format = ExportFormat.csv,
    this.includeFeeding = true,
    this.includeSleep = true,
    this.includeDiaper = true,
    this.includeGrowth = true,
    this.includeActivity = true,
    this.includeMedical = true,
  });

  final int babyId;
  final DateTime startDate;
  final DateTime endDate;
  final ExportFormat format;
  final bool includeFeeding;
  final bool includeSleep;
  final bool includeDiaper;
  final bool includeGrowth;
  final bool includeActivity;
  final bool includeMedical;
}

/// Service for exporting baby data to external files.
class ExportService {
  ExportService({
    required FeedingLogRepository feedingRepo,
    required SleepLogRepository sleepRepo,
    required DiaperLogRepository diaperRepo,
    required GrowthLogRepository growthRepo,
    required ActivityLogRepository activityRepo,
    required MedicalLogRepository medicalRepo,
    required BabyRepository babyRepo,
  })  : _feedingRepo = feedingRepo,
        _sleepRepo = sleepRepo,
        _diaperRepo = diaperRepo,
        _growthRepo = growthRepo,
        _activityRepo = activityRepo,
        _medicalRepo = medicalRepo;

  final FeedingLogRepository _feedingRepo;
  final SleepLogRepository _sleepRepo;
  final DiaperLogRepository _diaperRepo;
  final GrowthLogRepository _growthRepo;
  final ActivityLogRepository _activityRepo;
  final MedicalLogRepository _medicalRepo;

  /// Export data based on configuration.
  /// Returns the path to the exported file.
  Future<String> exportData(ExportConfig config) async {
    return await ErrorHandler.executeWithErrorHandling(
      () async {
        switch (config.format) {
          case ExportFormat.csv:
            return await _exportToCsv(config);
          case ExportFormat.pdf:
            return await _exportToPdf(config);
        }
      },
      context: 'ExportService.exportData',
      maxRetries: 1,
    );
  }

  /// Share the exported file using the platform's share sheet.
  Future<void> shareExportedFile(String filePath) async {
    final file = File(filePath);
    if (!await file.exists()) {
      throw Exception('Exported file not found: $filePath');
    }
    await SharePlus.instance.share(ShareParams(files: [XFile(filePath)]));
  }

  /// Export data to CSV format.
  Future<String> _exportToCsv(ExportConfig config) async {
    final csvLines = <String>[];
    
    // Add header
    csvLines.add('Baby Steps Data Export');
    csvLines.add('Baby ID: ${config.babyId}');
    csvLines.add('Date Range: ${config.startDate.toLocal()} - ${config.endDate.toLocal()}');
    csvLines.add('Exported on: ${DateTime.now().toLocal()}');
    csvLines.add('');

    if (config.includeFeeding) {
      csvLines.add('=== Feeding Logs ===');
      final feedingLogs = await _feedingRepo.getFeedingLogsForBaby(
        config.babyId,
        startDate: config.startDate,
        endDate: config.endDate,
      );
      if (feedingLogs.isEmpty) {
        csvLines.add('No feeding logs in this period.');
      } else {
        csvLines.add('ID,Type,Start Time,End Time,Volume,Unit,Breast Side,Left Duration (s),Right Duration (s),Formula Brand,Formula Temp,Notes');
        for (final log in feedingLogs) {
          csvLines.add([
            log.id,
            log.type,
            log.startTime.toLocal().toString(),
            log.endTime?.toLocal().toString() ?? '',
            log.volumeAmount ?? '',
            log.volumeUnit ?? '',
            log.breastSide ?? '',
            log.leftDurationSeconds ?? '',
            log.rightDurationSeconds ?? '',
            log.formulaBrand ?? '',
            log.formulaTemp ?? '',
            _escapeCsvField(log.notes ?? ''),
          ].join(','));
        }
      }
      csvLines.add('');
    }

    if (config.includeSleep) {
      csvLines.add('=== Sleep Logs ===');
      final sleepLogs = await _sleepRepo.getSleepLogsForBaby(
        config.babyId,
        startDate: config.startDate,
        endDate: config.endDate,
      );
      if (sleepLogs.isEmpty) {
        csvLines.add('No sleep logs in this period.');
      } else {
        csvLines.add('ID,Start Time,End Time,Notes');
        for (final log in sleepLogs) {
          csvLines.add([
            log.id,
            log.startTime.toLocal().toString(),
            log.endTime?.toLocal().toString() ?? '',
            _escapeCsvField(log.notes ?? ''),
          ].join(','));
        }
      }
      csvLines.add('');
    }

    if (config.includeDiaper) {
      csvLines.add('=== Diaper Logs ===');
      final diaperLogs = await _diaperRepo.getDiaperLogsForBaby(
        config.babyId,
        startDate: config.startDate,
        endDate: config.endDate,
      );
      if (diaperLogs.isEmpty) {
        csvLines.add('No diaper logs in this period.');
      } else {
        csvLines.add('ID,Start Time,End Time,Type,Consistency,Color,Notes');
        for (final log in diaperLogs) {
          csvLines.add([
            log.id,
            log.startTime.toLocal().toString(),
            log.endTime?.toLocal().toString() ?? '',
            log.type,
            log.consistency ?? '',
            log.color ?? '',
            _escapeCsvField(log.notes ?? ''),
          ].join(','));
        }
      }
      csvLines.add('');
    }

    if (config.includeGrowth) {
      csvLines.add('=== Growth Logs ===');
      final growthLogs = await _growthRepo.getGrowthLogsForBaby(
        config.babyId,
        startDate: config.startDate,
        endDate: config.endDate,
      );
      if (growthLogs.isEmpty) {
        csvLines.add('No growth logs in this period.');
      } else {
        csvLines.add('ID,Start Time,End Time,Weight (kg),Height (cm),Head Circumference (cm),Notes');
        for (final log in growthLogs) {
          csvLines.add([
            log.id,
            log.startTime.toLocal().toString(),
            log.endTime?.toLocal().toString() ?? '',
            log.weight ?? '',
            log.height ?? '',
            log.headCircumference ?? '',
            _escapeCsvField(log.notes ?? ''),
          ].join(','));
        }
      }
      csvLines.add('');
    }

    if (config.includeActivity) {
      csvLines.add('=== Activity Logs ===');
      final activityLogs = await _activityRepo.getActivityLogsForBaby(
        config.babyId,
        startDate: config.startDate,
        endDate: config.endDate,
      );
      if (activityLogs.isEmpty) {
        csvLines.add('No activity logs in this period.');
      } else {
        csvLines.add('ID,Start Time,End Time,Type,Milestones,Notes');
        for (final log in activityLogs) {
          csvLines.add([
            log.id,
            log.startTime.toLocal().toString(),
            log.endTime?.toLocal().toString() ?? '',
            log.type,
            log.milestones ?? '',
            _escapeCsvField(log.notes ?? ''),
          ].join(','));
        }
      }
      csvLines.add('');
    }

    if (config.includeMedical) {
      csvLines.add('=== Medical Logs ===');
      final medicalLogs = await _medicalRepo.getMedicalLogsForBaby(
        config.babyId,
        startDate: config.startDate,
        endDate: config.endDate,
      );
      if (medicalLogs.isEmpty) {
        csvLines.add('No medical logs in this period.');
      } else {
        csvLines.add('ID,Name,Type,Dosage,Start Time,End Time,Reminder Time,Notes');
        for (final log in medicalLogs) {
          csvLines.add([
            log.id,
            log.name,
            log.type,
            log.dosage ?? '',
            log.startTime.toLocal().toString(),
            log.endTime?.toLocal().toString() ?? '',
            log.reminderTime?.toLocal().toString() ?? '',
            _escapeCsvField(log.notes ?? ''),
          ].join(','));
        }
      }
      csvLines.add('');
    }

    // Write to file
    final directory = await getApplicationDocumentsDirectory();
    final timestamp = DateTime.now().toIso8601String().replaceAll(':', '-').replaceAll('.', '-');
    final fileName = 'baby_steps_export_$timestamp.csv';
    final filePath = '${directory.path}/$fileName';
    final file = File(filePath);
    await file.writeAsString(csvLines.join('\n'), flush: true);
    
    return filePath;
  }

  /// Export data to PDF format (placeholder).
  Future<String> _exportToPdf(ExportConfig config) async {
    // TODO: Implement PDF export using a library like pdf or printing
    throw UnimplementedError('PDF export not yet implemented');
  }

  /// Escape CSV field (wrap in quotes if contains comma, newline, or quote).
  String _escapeCsvField(String field) {
    if (field.contains(',') || field.contains('\n') || field.contains('"')) {
      return '"${field.replaceAll('"', '""')}"';
    }
    return field;
  }
}
