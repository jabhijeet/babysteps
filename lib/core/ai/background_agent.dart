import 'package:workmanager/workmanager.dart';
import '../database/app_database.dart';
import '../database/repositories/log_repositories.dart';
import '../database/repositories/baby_repository.dart';
import '../security/secure_storage.dart';
import '../network/notification_service.dart';
import 'proactive_engine_service.dart';
import 'ai_config_service.dart';
import 'dart:developer';

@pragma('vm:entry-point')
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    try {
      final database = AppDatabase();
      final secureStorage = SecureStorage();
      // Note: Secure storage might not work in background on some platforms if it needs UI context,
      // but we mainly need it for the BabyRepository to get DOB.
      // If it fails, we fallback to defaults.
      try {
        await secureStorage.init();
      } catch (e) {
        log('Background SecureStorage init failed: $e');
      }

      final babyRepo = BabyRepository(database, secureStorage);
      final sleepRepo = SleepLogRepository(database, secureStorage);
      final feedingRepo = FeedingLogRepository(database, secureStorage);
      final aiConfigService = AiConfigService(secureStorage);
      await aiConfigService.init();
      
      final config = await aiConfigService.loadConfig();
      if (!config.proactiveSuggestionsEnabled) {
        return Future.value(true);
      }

      final notificationService = NotificationService();
      await notificationService.init();

      final proactiveEngine = ProactiveEngineService(
        sleepRepo: sleepRepo,
        feedingRepo: feedingRepo,
        babyRepo: babyRepo,
      );

      final babies = await babyRepo.getAllBabies();
      for (final baby in babies) {
        // 1. Feeding Insights
        final feedingInsight = await proactiveEngine.getFeedingInsights(baby.id);
        if (feedingInsight['status'] == 'alert' || feedingInsight['status'] == 'reminder') {
          await notificationService.scheduleReminder(
            baby.id * 1000 + 10, // Background feeding alert ID
            'BabySteps Insight',
            feedingInsight['message'] as String,
            DateTime.now().add(const Duration(seconds: 1)),
          );
        }

        // 2. Check if baby has been awake too long (Wake Window check)
        final latestSleep = await sleepRepo.getLatestSleepLog(baby.id);
        if (latestSleep != null && latestSleep.endTime != null) {
          final timeSinceSleep = DateTime.now().difference(latestSleep.endTime!).inMinutes;
          final optimalWindow = await proactiveEngine.getOptimalWakeWindow(baby.id);
          
          if (timeSinceSleep > optimalWindow && timeSinceSleep < optimalWindow + 30) {
            await notificationService.scheduleReminder(
              baby.id * 1000 + 11, // Background sleep alert ID
              'Nap Time?',
              'It\'s been $timeSinceSleep minutes since the last nap. ${baby.name} might be tired!',
              DateTime.now().add(const Duration(seconds: 1)),
            );
          }
        }
      }

      return Future.value(true);
    } catch (e) {
      log('Background task failed: $e');
      return Future.value(false);
    }
  });
}

class BackgroundAgent {
  static const taskName = "com.babysteps.proactive_analysis";

  static Future<void> init() async {
    await Workmanager().initialize(
      callbackDispatcher,
    );
  }

  static Future<void> startService() async {
    await Workmanager().registerPeriodicTask(
      "1",
      taskName,
      frequency: const Duration(hours: 2), // Run every 2 hours
      constraints: Constraints(
        networkType: NetworkType.notRequired,
      ),
    );
  }
}
