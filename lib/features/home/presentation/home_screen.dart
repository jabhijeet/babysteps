import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/ai/ai_config_cubit.dart';
import '../../../core/ai/voice_input_service.dart';
import '../../../core/theme/colors.dart';
import '../../../core/theme/theme_cubit.dart';
import '../../logging/bloc/logging_bloc.dart';
import '../../logging/presentation/feed_logging_sheet.dart';
import '../../logging/presentation/sleep_logging_sheet.dart';
import '../../logging/presentation/diaper_logging_sheet.dart';
import '../../logging/presentation/activity_logging_sheet.dart';
import '../../logging/presentation/medical_logging_sheet.dart';
import '../../logging/presentation/growth_logging_sheet.dart';
import '../../insights/presentation/insights_screen.dart';
import '../cubit/baby_selection_cubit.dart';
import 'baby_management_screen.dart';
import 'widgets/dashboard_view.dart';
import 'widgets/settings_drawer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;


  Future<void> _startVoiceInput(int babyId) async {
    final aiConfigCubit = context.read<AiConfigCubit>();
    final state = aiConfigCubit.state;
    if (!state.config.enabled) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('AI & Voice is disabled. Enable it in settings.')),
      );
      return;
    }

    final loggingBloc = context.read<LoggingBloc>();
    final messenger = ScaffoldMessenger.of(context);
    final voiceService = VoiceInputService(config: state.config);

    unawaited(showModalBottomSheet<void>(
      context: context,
      isDismissible: false,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setModalState) {
            String currentTranscript = 'Listening...';
            bool isInit = false;
            
            if (!isInit) {
              isInit = true;
              voiceService.initialize().then((_) {
                if (!voiceService.isSpeechRecognitionAvailable) {
                  setModalState(() => currentTranscript = 'Speech recognition not available.');
                  return;
                }
                voiceService.startListening(
                  onResult: (result, isFinal) {
                    setModalState(() {
                      currentTranscript = result;
                    });
                    if (isFinal && result.isNotEmpty) {
                      Navigator.pop(ctx);
                      _processTranscript(result, babyId, loggingBloc, messenger, voiceService);
                    }
                  },
                );
              }).catchError((Object e) {
                setModalState(() => currentTranscript = 'Error starting voice: $e');
              });
            }

            return Padding(
              padding: const EdgeInsets.all(32.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'AI Assistant',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 24),
                  const CircularProgressIndicator(),
                  const SizedBox(height: 24),
                  Text(
                    currentTranscript,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const SizedBox(height: 32),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.redAccent,
                          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                        ),
                        onPressed: () {
                          voiceService.cancelListening();
                          Navigator.pop(ctx);
                        },
                        child: const Text('Cancel', style: TextStyle(color: Colors.white)),
                      ),
                      const SizedBox(width: 16),
                      if (state.config.whisperOnDevice && !kIsWeb)
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                          ),
                          onPressed: () async {
                            await voiceService.stopListening(
                              onTranscriptionComplete: (result) {
                                setModalState(() {
                                  currentTranscript = result;
                                });
                                if (result != "Transcribing..." && result.isNotEmpty) {
                                  Future.delayed(const Duration(milliseconds: 500), () {
                                    if (ctx.mounted) {
                                      Navigator.pop(ctx);
                                      _processTranscript(result, babyId, loggingBloc, messenger, voiceService);
                                    }
                                  });
                                }
                              },
                            );
                          },
                          child: const Text('Stop & Process', style: TextStyle(color: Colors.white)),
                        ),
                    ],
                  ),
                ],
              ),
            );
          },
        );
      },
    ));
  }

  void _processTranscript(String transcript, int babyId, LoggingBloc loggingBloc, ScaffoldMessengerState messenger, VoiceInputService voiceService) {
    log('Processing transcript="$transcript"');
    loggingBloc.add(
      ProcessVoiceInputEvent(
        transcript: transcript,
        babyId: babyId,
        voiceService: voiceService,
      ),
    );
    messenger.showSnackBar(
      SnackBar(
        content: Text('Processing: "$transcript"'),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            // Ideally dispatch an undo event if supported
            log('Undo AI action');
          },
        ),
      ),
    );
  }

  void _showAddLogBottomSheet(int babyId) {
    unawaited(showModalBottomSheet<void>(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Log Activity',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 20),
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                  _startVoiceInput(babyId);
                },
                borderRadius: BorderRadius.circular(16),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primaryContainer,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.mic, size: 28, color: Theme.of(context).colorScheme.onPrimaryContainer),
                      const SizedBox(width: 12),
                      Text(
                        'Log with AI Voice Assistant',
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: Theme.of(context).colorScheme.onPrimaryContainer,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Wrap(
                spacing: 24,
                runSpacing: 24,
                alignment: WrapAlignment.center,
                children: [
                  _buildActionIcon(context, title: 'Feed', color: AppColors.feedingGreen, icon: Icons.local_drink,
                    onTap: () {
                      Navigator.pop(context);
                      showModalBottomSheet<void>(context: context, isScrollControlled: true,
                        builder: (_) => FeedLoggingSheet(babyId: babyId));
                    }),
                  _buildActionIcon(context, title: 'Sleep', color: AppColors.sleepBlue, icon: Icons.nights_stay,
                    onTap: () {
                      Navigator.pop(context);
                      showModalBottomSheet<void>(context: context, isScrollControlled: true,
                        builder: (_) => SleepLoggingSheet(babyId: babyId));
                    }),
                  _buildActionIcon(context, title: 'Diaper', color: AppColors.diaperYellow, icon: Icons.baby_changing_station,
                    onTap: () {
                      Navigator.pop(context);
                      showModalBottomSheet<void>(context: context, isScrollControlled: true,
                        builder: (_) => DiaperLoggingSheet(babyId: babyId));
                    }),
                  _buildActionIcon(context, title: 'Activity', color: AppColors.activityOrange, icon: Icons.extension,
                    onTap: () {
                      Navigator.pop(context);
                      showModalBottomSheet<void>(context: context, isScrollControlled: true,
                        builder: (_) => ActivityLoggingSheet(babyId: babyId));
                    }),
                  _buildActionIcon(context, title: 'Medical', color: AppColors.medicalRed, icon: Icons.healing,
                    onTap: () {
                      Navigator.pop(context);
                      showModalBottomSheet<void>(context: context, isScrollControlled: true,
                        builder: (_) => MedicalLoggingSheet(babyId: babyId));
                    }),
                  _buildActionIcon(context, title: 'Growth', color: AppColors.growthTeal, icon: Icons.trending_up,
                    onTap: () {
                      Navigator.pop(context);
                      showModalBottomSheet<void>(context: context, isScrollControlled: true,
                        builder: (_) => GrowthLoggingSheet(babyId: babyId));
                    }),
                ],
              ),
              const SizedBox(height: 20),
            ],
          ),
        );
      },
    ));
  }

  Widget _buildActionIcon(BuildContext context, {
    required String title, required Color color,
    required IconData icon, required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircleAvatar(
            radius: 32,
            backgroundColor: color,
            child: Icon(icon, size: 32, color: AppColors.textLightPrimary),
          ),
          const SizedBox(height: 8),
          Text(title, style: Theme.of(context).textTheme.bodyMedium),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BabySelectionCubit, BabySelectionState>(
      builder: (context, babyState) {
        final babyId = babyState.selectedBabyId ?? 0;
        final babyName = babyState.selectedBaby?.name;

        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: GestureDetector(
              onTap: () => _showBabySwitcher(context, babyState),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(babyName ?? 'BabySteps'),
                  if (babyState.babies.length > 1) ...[
                    const SizedBox(width: 4),
                    const Icon(Icons.arrow_drop_down, size: 20),
                  ],
                ],
              ),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.child_care),
                tooltip: 'Manage Babies',
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute<void>(
                    builder: (_) => BlocProvider.value(
                      value: context.read<BabySelectionCubit>(),
                      child: const BabyManagementScreen(),
                    ),
                  ),
                ),
              ),
              IconButton(
                icon: Icon(Theme.of(context).brightness == Brightness.dark
                    ? Icons.light_mode
                    : Icons.dark_mode),
                onPressed: () => context.read<ThemeCubit>().toggleTheme(
                    Theme.of(context).brightness),
              ),
            ],
          ),
          drawer: SettingsDrawer(babyId: babyId),
          body: IndexedStack(
            index: _currentIndex,
            children: [
              DashboardView(babyId: babyId),
              InsightsScreen(babyId: babyId),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () => _showAddLogBottomSheet(babyId),
            child: const Icon(Icons.add, size: 32),
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: _currentIndex,
            onTap: (index) => setState(() => _currentIndex = index),
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.dashboard),
                label: 'Dashboard',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.bar_chart),
                label: 'Insights',
              ),
            ],
          ),
        );
      },
    );
  }

  void _showBabySwitcher(BuildContext context, BabySelectionState state) {
    if (state.babies.length <= 1) return;
    unawaited(showModalBottomSheet<void>(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => BlocProvider.value(
        value: context.read<BabySelectionCubit>(),
        child: _BabySwitcherSheet(state: state),
      ),
    ));
  }
}


class _BabySwitcherSheet extends StatelessWidget {
  const _BabySwitcherSheet({required this.state});

  final BabySelectionState state;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.outline.withValues(alpha: 0.4),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text('Switch Baby', style: Theme.of(context).textTheme.titleLarge),
          ),
          const SizedBox(height: 8),
          ...state.babies.map((baby) {
            final isSelected = baby.id == state.selectedBabyId;
            return ListTile(
              leading: CircleAvatar(
                backgroundColor: isSelected
                    ? Theme.of(context).colorScheme.primary
                    : Theme.of(context).colorScheme.surfaceContainerHighest,
                child: Icon(Icons.child_care,
                    color: isSelected
                        ? Colors.white
                        : Theme.of(context).colorScheme.onSurface),
              ),
              title: Text(baby.name),
              trailing: isSelected
                  ? Icon(Icons.check, color: Theme.of(context).colorScheme.primary)
                  : null,
              onTap: () {
                context.read<BabySelectionCubit>().selectBaby(baby.id);
                Navigator.pop(context);
              },
            );
          }),
        ],
      ),
    );
  }
}
