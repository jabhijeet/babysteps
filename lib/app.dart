import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/database/app_database.dart';
import 'core/security/secure_storage.dart';
import 'core/theme/app_theme.dart';
import 'core/database/repositories/log_repositories.dart';
import 'core/database/repositories/baby_repository.dart';
import 'features/home/presentation/home_screen.dart';
import 'features/home/presentation/baby_management_screen.dart';
import 'features/home/cubit/baby_selection_cubit.dart';
import 'features/logging/bloc/logging_bloc.dart';
import 'core/network/notification_service.dart';
import 'core/network/sync_service.dart';
import 'core/network/sync_cubit.dart';
import 'package:provider/provider.dart';
import 'core/theme/theme_cubit.dart';
import 'core/ai/ai_config_service.dart';
import 'core/ai/ai_config_cubit.dart';
import 'core/ai/proactive_engine_service.dart';

class BabyStepsApp extends StatelessWidget {
  const BabyStepsApp({
    super.key,
    required this.database,
    required this.secureStorage,
  });

  final AppDatabase database;
  final SecureStorage secureStorage;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<NotificationService>(
          create: (_) => NotificationService()..init(),
        ),
        RepositoryProvider<BabyRepository>(
          create: (_) => BabyRepository(database, secureStorage),
        ),
        RepositoryProvider<FeedingLogRepository>(
          create: (_) => FeedingLogRepository(database, secureStorage),
        ),
        RepositoryProvider<SleepLogRepository>(
          create: (_) => SleepLogRepository(database, secureStorage),
        ),
        RepositoryProvider<DiaperLogRepository>(
          create: (_) => DiaperLogRepository(database, secureStorage),
        ),
        RepositoryProvider<GrowthLogRepository>(
          create: (_) => GrowthLogRepository(database, secureStorage),
        ),
        RepositoryProvider<ActivityLogRepository>(
          create: (_) => ActivityLogRepository(database, secureStorage),
        ),
        RepositoryProvider<MedicalLogRepository>(
          create: (_) => MedicalLogRepository(database, secureStorage),
        ),
        RepositoryProvider<AiConfigService>(
          create: (_) => AiConfigService(secureStorage)..init(),
        ),
        RepositoryProvider<ProactiveEngineService>(
          create: (context) => ProactiveEngineService(
            sleepRepo: context.read<SleepLogRepository>(),
            feedingRepo: context.read<FeedingLogRepository>(),
            babyRepo: context.read<BabyRepository>(),
          ),
        ),
      ],
      child: ChangeNotifierProvider<SyncService>(
        create: (_) => SyncService(),
        child: MultiBlocProvider(
          providers: [
            BlocProvider<BabySelectionCubit>(
              create: (context) => BabySelectionCubit(
                context.read<BabyRepository>(),
              )..loadBabies(),
            ),
            BlocProvider<LoggingBloc>(
              create: (context) => LoggingBloc(
                feedingRepo: context.read<FeedingLogRepository>(),
                sleepRepo: context.read<SleepLogRepository>(),
                diaperRepo: context.read<DiaperLogRepository>(),
                growthRepo: context.read<GrowthLogRepository>(),
                activityRepo: context.read<ActivityLogRepository>(),
                medicalRepo: context.read<MedicalLogRepository>(),
                babyRepo: context.read<BabyRepository>(),
                notificationService: context.read<NotificationService>(),
                aiConfigService: context.read<AiConfigService>(),
                proactiveEngine: context.read<ProactiveEngineService>(),
              ),
            ),
            BlocProvider<ThemeCubit>(
              create: (_) => ThemeCubit(),
            ),
            BlocProvider<AiConfigCubit>(
              create: (context) => AiConfigCubit(
                context.read<AiConfigService>(),
              )..loadConfig(),
            ),
            BlocProvider<SyncCubit>(
              create: (context) => SyncCubit(
                context.read<SyncService>(),
              ),
            ),
          ],
          child: BlocBuilder<ThemeCubit, ThemeMode>(
            builder: (context, themeMode) {
              return MaterialApp(
                title: 'BabySteps',
                theme: AppTheme.lightTheme,
                darkTheme: AppTheme.darkTheme,
                themeMode: themeMode,
                home: BlocBuilder<BabySelectionCubit, BabySelectionState>(
                  builder: (context, state) {
                    if (state.isLoading && state.babies.isEmpty) {
                      return const Scaffold(
                        body: Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    }
                    if (state.babies.isEmpty) {
                      return const BabyManagementScreen();
                    }
                    return const HomeScreen();
                  },
                ),
                debugShowCheckedModeBanner: false,
              );
            },
          ),
        ),
      ),
    );
  }
}
