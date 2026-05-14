import 'dart:math';
import '../database/repositories/log_repositories.dart';
import '../database/repositories/baby_repository.dart';

class ProactiveEngineService {
  ProactiveEngineService({
    required this.sleepRepo,
    required this.feedingRepo,
    required this.babyRepo,
  });

  final SleepLogRepository sleepRepo;
  final FeedingLogRepository feedingRepo;
  final BabyRepository babyRepo;

  /// Analyzes historical sleep data to find the optimal wake window for a specific baby.
  /// Returns duration in minutes.
  Future<int> getOptimalWakeWindow(int babyId) async {
    final baby = await babyRepo.getBabyById(babyId);
    if (baby == null) return 90; // Default

    final now = DateTime.now();
    final ageInMonths = _calculateAgeInMonths(baby.dateOfBirth);
    final defaultWindow = _getAgeBasedWakeWindow(ageInMonths);

    // Fetch last 7 days of sleep logs
    final logs = await sleepRepo.getSleepLogs(babyId);
    final recentLogs = logs
        .where((l) => l.startTime.isAfter(now.subtract(const Duration(days: 7))))
        .toList();

    // Sort by time ascending to calculate windows between them
    recentLogs.sort((a, b) => a.startTime.compareTo(b.startTime));

    if (recentLogs.length < 5) {
      return defaultWindow;
    }

    final List<int> wakeWindows = [];
    for (int i = 0; i < recentLogs.length - 1; i++) {
      final currentSleepEnd = recentLogs[i].endTime;
      final nextSleepStart = recentLogs[i + 1].startTime;

      if (currentSleepEnd != null) {
        final window = nextSleepStart.difference(currentSleepEnd).inMinutes;
        // Filter out extreme outliers (e.g., night sleep gaps or forgotten logs)
        if (window > 30 && window < defaultWindow * 2.5) {
          wakeWindows.add(window);
        }
      }
    }

    if (wakeWindows.isEmpty) return defaultWindow;

    // Use median or weighted average to avoid single outliers
    wakeWindows.sort();
    final median = wakeWindows[wakeWindows.length ~/ 2];
    
    // Blend median with default based on data confidence
    final confidence = min(1.0, wakeWindows.length / 15.0);
    return (median * confidence + defaultWindow * (1 - confidence)).round();
  }

  /// Analyzes feeding trends to provide insights.
  Future<Map<String, dynamic>> getFeedingInsights(int babyId) async {
    final logs = await feedingRepo.getFeedingLogs(babyId);
    if (logs.isEmpty) return {'status': 'neutral', 'message': 'Not enough data.'};

    final now = DateTime.now();
    final last24Hours = logs.where((l) => l.startTime.isAfter(now.subtract(const Duration(days: 1)))).toList();
    final previous24Hours = logs.where((l) => 
      l.startTime.isAfter(now.subtract(const Duration(days: 2))) && 
      l.startTime.isBefore(now.subtract(const Duration(days: 1)))
    ).toList();

    if (last24Hours.isEmpty) {
      return {
        'status': 'warning',
        'message': 'No feedings logged in the last 24 hours.',
      };
    }

    final totalVolumeToday = last24Hours.fold<double>(0, (sum, l) => sum + (l.volumeAmount ?? 0));
    final totalVolumeYesterday = previous24Hours.fold<double>(0, (sum, l) => sum + (l.volumeAmount ?? 0));

    if (totalVolumeYesterday > 0) {
      final percentChange = (totalVolumeToday - totalVolumeYesterday) / totalVolumeYesterday;
      if (percentChange < -0.25) {
        return {
          'status': 'alert',
          'message': 'Feeding volume is down ${ (percentChange.abs() * 100).round() }% compared to yesterday.',
          'type': 'volume_drop'
        };
      }
    }

    // Check intervals
    last24Hours.sort((a, b) => a.startTime.compareTo(b.startTime));
    final List<int> intervals = [];
    for (int i = 0; i < last24Hours.length - 1; i++) {
      intervals.add(last24Hours[i + 1].startTime.difference(last24Hours[i].startTime).inMinutes);
    }

    if (intervals.isNotEmpty) {
      final avgInterval = intervals.reduce((a, b) => a + b) / intervals.length;
      final lastFeedTime = last24Hours.last.startTime;
      final timeSinceLastFeed = now.difference(lastFeedTime).inMinutes;

      if (timeSinceLastFeed > avgInterval * 1.5 && timeSinceLastFeed > 180) {
        return {
          'status': 'reminder',
          'message': 'It has been ${ (timeSinceLastFeed / 60).toStringAsFixed(1) } hours since the last feed.',
          'type': 'hunger_likely'
        };
      }
    }

    return {'status': 'healthy', 'message': 'Feeding patterns look normal.'};
  }

  int _calculateAgeInMonths(DateTime dob) {
    final now = DateTime.now();
    return (now.year - dob.year) * 12 + now.month - dob.month;
  }

  int _getAgeBasedWakeWindow(int ageInMonths) {
    if (ageInMonths < 1) return 60;
    if (ageInMonths < 3) return 90;
    if (ageInMonths < 6) return 120;
    if (ageInMonths < 9) return 150;
    if (ageInMonths < 12) return 180;
    return 240;
  }
}
