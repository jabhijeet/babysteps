import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/theme/theme_cubit.dart';
import '../../../core/database/repositories/log_repositories.dart';
import '../../../core/database/app_database.dart';
import '../../../core/database/repositories/baby_repository.dart';
import '../../../core/theme/colors.dart';
import '../../../core/ai/proactive_engine_service.dart';
import 'widgets/insight_charts.dart';

class InsightsScreen extends StatefulWidget {
  const InsightsScreen({super.key, required this.babyId});

  final int babyId;

  @override
  State<InsightsScreen> createState() => _InsightsScreenState();
}

class _InsightsScreenState extends State<InsightsScreen> {
  int _selectedDays = 7;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text('Insights'),
        backgroundColor: Colors.transparent,
        elevation: 0,
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
      body: Container(
        decoration: BoxDecoration(
          gradient: isDark ? AppColors.backgroundGradientDark : AppColors.backgroundGradient,
        ),
        child: SafeArea(
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1000),
              child: Column(
                children: [
                  _buildTimeRangeSelector(),
                  Expanded(
                    child: ListView(
                      padding: const EdgeInsets.all(24),
                      children: [
                        _buildProactiveSuggestions(context),
                        const SizedBox(height: 24),
                        _buildMilkInventory(context),
                        const SizedBox(height: 24),
                        _buildFeedingChart(context),
                        const SizedBox(height: 24),
                        _buildSleepChart(context),
                        const SizedBox(height: 24),
                        _buildDiaperChart(context),
                        const SizedBox(height: 24),
                        _buildActivityChart(context),
                        const SizedBox(height: 24),
                        _buildMedicalChart(context),
                        const SizedBox(height: 24),
                        _buildGrowthChart(context),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTimeRangeSelector() {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [3, 7, 15, 30].map((days) {
          final isSelected = _selectedDays == days;
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: ChoiceChip(
              label: Text('$days Days'),
              selected: isSelected,
              onSelected: (selected) {
                if (selected) setState(() => _selectedDays = days);
              },
              backgroundColor: isDark ? Colors.grey[900] : Colors.white,
              selectedColor: AppColors.accentBlue,
              labelStyle: TextStyle(
                color: isSelected ? Colors.white : (isDark ? Colors.white70 : Colors.black87),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildMilkInventory(BuildContext context) {
    return FutureBuilder<List<FeedingLog>>(
      future: context.read<FeedingLogRepository>().getFeedingLogs(widget.babyId),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return const SizedBox.shrink();

        double totalPumped = 0;
        double totalConsumed = 0;

        for (final log in snapshot.data!) {
          if (log.type == 'pumping' && log.volumeAmount != null) {
            final double amount = log.volumeUnit == 'oz' ? log.volumeAmount! * 29.5735 : log.volumeAmount!;
            totalPumped += amount;
          } else if (log.type == 'expressed' && log.volumeAmount != null) {
            final double amount = log.volumeUnit == 'oz' ? log.volumeAmount! * 29.5735 : log.volumeAmount!;
            totalConsumed += amount;
          }
        }

        final inventory = totalPumped - totalConsumed;
        final displayInventory = inventory > 0 ? inventory : 0.0;

        return Card(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppColors.accentGreen.withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.inventory_2, color: AppColors.accentGreen, size: 28),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Expressed Milk Inventory', style: Theme.of(context).textTheme.titleMedium),
                      const SizedBox(height: 4),
                      Text('${displayInventory.toStringAsFixed(1)} ml available', style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold, color: AppColors.accentGreen)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildFeedingChart(BuildContext context) {
    final now = DateTime.now();
    final startOfToday = DateTime(now.year, now.month, now.day, 23, 59, 59);

    return FutureBuilder<List<FeedingLog>>(
      future: context.read<FeedingLogRepository>().getFeedingLogs(widget.babyId),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return const SizedBox(height: 200, child: Center(child: CircularProgressIndicator()));
        final dailyData = List.filled(_selectedDays, 0.0);
        for (var log in snapshot.data!) {
          final diff = startOfToday.difference(log.startTime).inDays;
          if (diff >= 0 && diff < _selectedDays && log.volumeAmount != null) {
            dailyData[(_selectedDays - 1) - diff] += log.volumeAmount!;
          }
        }
        return InsightCharts.buildGenericBarChart(
          context: context,
          title: 'Feeding Volume (ml)',
          icon: Icons.restaurant,
          color: AppColors.accentGreen,
          gradient: const LinearGradient(colors: [Color(0xFFA5D6A7), Color(0xFF66BB6A)]),
          dailyData: dailyData,
          selectedDays: _selectedDays,
        );
      },
    );
  }

  Widget _buildSleepChart(BuildContext context) {
    final now = DateTime.now();
    final startOfToday = DateTime(now.year, now.month, now.day, 23, 59, 59);

    return FutureBuilder<List<SleepLog>>(
      future: context.read<SleepLogRepository>().getSleepLogs(widget.babyId),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return const SizedBox(height: 200, child: Center(child: CircularProgressIndicator()));
        final dailyData = List.filled(_selectedDays, 0.0);
        for (var log in snapshot.data!) {
          if (log.endTime != null) {
            final diff = startOfToday.difference(log.startTime).inDays;
            if (diff >= 0 && diff < _selectedDays) {
              dailyData[(_selectedDays - 1) - diff] += log.endTime!.difference(log.startTime).inMinutes / 60.0;
            }
          }
        }
        return InsightCharts.buildGenericBarChart(
          context: context,
          title: 'Sleep Duration (Hrs)',
          icon: Icons.bedtime,
          color: AppColors.accentBlue,
          gradient: const LinearGradient(colors: [Color(0xFFBBDEFB), Color(0xFF4A90E2)]),
          dailyData: dailyData,
          selectedDays: _selectedDays,
        );
      },
    );
  }

  Widget _buildDiaperChart(BuildContext context) {
    final now = DateTime.now();
    final startOfToday = DateTime(now.year, now.month, now.day, 23, 59, 59);

    return FutureBuilder<List<DiaperLog>>(
      future: context.read<DiaperLogRepository>().getDiaperLogs(widget.babyId),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return const SizedBox(height: 200, child: Center(child: CircularProgressIndicator()));
        final dailyData = List.filled(_selectedDays, 0.0);
        for (var log in snapshot.data!) {
          final diff = startOfToday.difference(log.startTime).inDays;
          if (diff >= 0 && diff < _selectedDays) {
            dailyData[(_selectedDays - 1) - diff] += 1;
          }
        }
        return InsightCharts.buildGenericBarChart(
          context: context,
          title: 'Diaper Changes',
          icon: Icons.baby_changing_station,
          color: AppColors.accentYellow,
          gradient: const LinearGradient(colors: [Color(0xFFFFF59D), Color(0xFFFBC02D)]),
          dailyData: dailyData,
          selectedDays: _selectedDays,
        );
      },
    );
  }

  Widget _buildActivityChart(BuildContext context) {
    final now = DateTime.now();
    final startOfToday = DateTime(now.year, now.month, now.day, 23, 59, 59);

    return FutureBuilder<List<ActivityLog>>(
      future: context.read<ActivityLogRepository>().getActivityLogs(widget.babyId),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return const SizedBox(height: 200, child: Center(child: CircularProgressIndicator()));
        final dailyData = List.filled(_selectedDays, 0.0);
        for (var log in snapshot.data!) {
          if (log.endTime != null) {
            final diff = startOfToday.difference(log.startTime).inDays;
            if (diff >= 0 && diff < _selectedDays) {
              dailyData[(_selectedDays - 1) - diff] += log.endTime!.difference(log.startTime).inMinutes.toDouble();
            }
          }
        }
        return InsightCharts.buildGenericBarChart(
          context: context,
          title: 'Activity Duration (Mins)',
          icon: Icons.toys,
          color: AppColors.accentOrange,
          gradient: const LinearGradient(colors: [Color(0xFFFFCC80), Color(0xFFF57C00)]),
          dailyData: dailyData,
          selectedDays: _selectedDays,
        );
      },
    );
  }

  Widget _buildMedicalChart(BuildContext context) {
    final now = DateTime.now();
    final startOfToday = DateTime(now.year, now.month, now.day, 23, 59, 59);

    return FutureBuilder<List<MedicalLog>>(
      future: context.read<MedicalLogRepository>().getMedicalLogs(widget.babyId),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return const SizedBox(height: 200, child: Center(child: CircularProgressIndicator()));
        final dailyData = List.filled(_selectedDays, 0.0);
        for (var log in snapshot.data!) {
          final diff = startOfToday.difference(log.startTime).inDays;
          if (diff >= 0 && diff < _selectedDays) {
            dailyData[(_selectedDays - 1) - diff] += 1;
          }
        }
        return InsightCharts.buildGenericBarChart(
          context: context,
          title: 'Medical Logs',
          icon: Icons.medical_services,
          color: AppColors.accentRed,
          gradient: const LinearGradient(colors: [Color(0xFFEF9A9A), Color(0xFFE53935)]),
          dailyData: dailyData,
          selectedDays: _selectedDays,
        );
      },
    );
  }

  Widget _buildGrowthChart(BuildContext context) {
    return FutureBuilder<List<dynamic>>(
      future: Future.wait([
        context.read<GrowthLogRepository>().getGrowthLogs(widget.babyId),
        context.read<BabyRepository>().getBabyById(widget.babyId),
      ]),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return const SizedBox(height: 200, child: Center(child: CircularProgressIndicator()));
        
        final logsData = snapshot.data![0] as List<GrowthLog>;
        final baby = snapshot.data![1] as BabyModel?;
        
        final now = DateTime.now();
        final cutoff = now.subtract(Duration(days: _selectedDays));
        final logs = logsData.where((l) => l.startTime.isAfter(cutoff)).toList();
        
        return InsightCharts.buildGrowthChart(
          context: context,
          logs: logs,
          selectedDays: _selectedDays,
          birthDate: baby?.dateOfBirth,
          gender: baby?.gender,
        );
      },
    );
  }

  Widget _buildProactiveSuggestions(BuildContext context) {
    final proactiveEngine = context.read<ProactiveEngineService>();
    final babyRepo = context.read<BabyRepository>();

    return FutureBuilder<BabyModel?>(
      future: babyRepo.getBabyById(widget.babyId),
      builder: (context, babySnapshot) {
        final babyName = babySnapshot.data?.name ?? 'the baby';
        
        return FutureBuilder<Map<String, dynamic>>(
          future: proactiveEngine.getFeedingInsights(widget.babyId),
          builder: (context, feedingSnapshot) {
            return FutureBuilder<int>(
              future: proactiveEngine.getOptimalWakeWindow(widget.babyId),
              builder: (context, sleepSnapshot) {
                final feedingInsight = feedingSnapshot.data;
                final optimalWakeWindow = sleepSnapshot.data;

                if (feedingInsight == null || optimalWakeWindow == null) {
                  return const SizedBox.shrink();
                }

                final hasWarning = feedingInsight['status'] == 'alert' || feedingInsight['status'] == 'warning';

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Proactive Suggestions',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 12),
                    if (hasWarning)
                      _buildInsightCard(
                        context,
                        title: 'Feeding Trend',
                        message: (feedingInsight['message'] as Object?).toString(),
                        icon: Icons.warning_amber_rounded,
                        color: AppColors.accentRed,
                      ),
                    const SizedBox(height: 12),
                    _buildInsightCard(
                      context,
                      title: 'Optimal Wake Window',
                      message: 'Based on recent patterns, $babyName\'s optimal wake window is $optimalWakeWindow minutes.',
                      icon: Icons.auto_awesome,
                      color: AppColors.accentBlue,
                    ),
                  ],
                );
              },
            );
          },
        );
      },
    );
  }

  Widget _buildInsightCard(
    BuildContext context, {
    required String title,
    required String message,
    required IconData icon,
    required Color color,
  }) {
    return Card(
      elevation: 0,
      color: color.withValues(alpha: 0.1),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: color.withValues(alpha: 0.2)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: color),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: TextStyle(fontWeight: FontWeight.bold, color: color)),
                  const SizedBox(height: 4),
                  Text(message, style: Theme.of(context).textTheme.bodyMedium),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
