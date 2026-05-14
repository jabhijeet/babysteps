import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../../core/theme/theme_cubit.dart';
import '../../../core/database/repositories/log_repositories.dart';
import '../../../core/database/app_database.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/theme/colors.dart';
import '../../../core/constants/enums.dart';
import '../../home/cubit/baby_selection_cubit.dart';
import '../../logging/presentation/feed_logging_sheet.dart';
import '../../logging/presentation/sleep_logging_sheet.dart';
import '../../logging/presentation/diaper_logging_sheet.dart';
import '../../logging/presentation/activity_logging_sheet.dart';
import '../../logging/presentation/medical_logging_sheet.dart';
import '../../logging/presentation/growth_logging_sheet.dart';
import 'widgets/insight_charts.dart';

class CategoryDetailScreen extends StatefulWidget {
  const CategoryDetailScreen({
    super.key,
    required this.babyId,
    required this.category,
  });

  final int babyId;
  final LogCategory category;

  @override
  State<CategoryDetailScreen> createState() => _CategoryDetailScreenState();
}

class _CategoryDetailScreenState extends State<CategoryDetailScreen> {
  late int _selectedDays;

  @override
  void initState() {
    super.initState();
    _selectedDays = widget.category == LogCategory.growth ? 182 : 7;
  }

  String _getCategoryTitle() {
    switch (widget.category) {
      case LogCategory.sleep: return 'Sleep History';
      case LogCategory.feeding: return 'Feeding History';
      case LogCategory.diaper: return 'Diaper History';
      case LogCategory.activity: return 'Activity History';
      case LogCategory.medical: return 'Medical History';
      case LogCategory.growth: return 'Growth History';
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BabySelectionCubit, BabySelectionState>(
      builder: (context, babyState) {
        final isDark = Theme.of(context).brightness == Brightness.dark;
        final babyName = babyState.selectedBaby?.name ?? 'Baby';

        return Scaffold(
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            title: Text(
              '$babyName - ${_getCategoryTitle()}',
              style: TextStyle(
                color: isDark ? Colors.white : Colors.black87,
                fontWeight: FontWeight.bold,
              ),
            ),
            backgroundColor: Colors.transparent,
            elevation: 0,
            iconTheme: IconThemeData(
              color: isDark ? Colors.white : Colors.black87,
            ),
            actions: [
              IconButton(
                icon: Icon(Theme.of(context).brightness == Brightness.light
                    ? Icons.dark_mode
                    : Icons.light_mode),
                onPressed: () => context.read<ThemeCubit>().toggleTheme(Theme.of(context).brightness),
                tooltip: 'Toggle Theme',
              ),
              IconButton(
                icon: const Icon(Icons.add_circle_outline),
                tooltip: 'Log Activity',
                onPressed: () => _showAddLogBottomSheet(context, widget.babyId),
              ),
            ],
          ),
      body: Container(
        decoration: BoxDecoration(
          gradient: isDark ? AppColors.backgroundGradientDark : AppColors.backgroundGradient,
        ),
        child: SafeArea(
          child: Column(
            children: [
              _buildTimeRangeSelector(),
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.all(24),
                  children: [
                    _buildChartSection(babyState.selectedBaby?.dateOfBirth, babyState.selectedBaby?.gender),
                    const SizedBox(height: 32),
                    _buildHistoryHeader(),
                    const SizedBox(height: 16),
                    _buildLogsList(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          showModalBottomSheet<void>(
            context: context,
            isScrollControlled: true,
            builder: (_) {
              switch (widget.category) {
                case LogCategory.sleep:
                  return SleepLoggingSheet(babyId: widget.babyId);
                case LogCategory.feeding:
                  return FeedLoggingSheet(babyId: widget.babyId);
                case LogCategory.diaper:
                  return DiaperLoggingSheet(babyId: widget.babyId);
                case LogCategory.activity:
                  return ActivityLoggingSheet(babyId: widget.babyId);
                case LogCategory.medical:
                  return MedicalLoggingSheet(babyId: widget.babyId);
                case LogCategory.growth:
                  return GrowthLoggingSheet(babyId: widget.babyId);
              }
            },
          );
        },
        icon: const Icon(Icons.add),
        label: Text('Log ${_getCategoryTitle().replaceAll(" History", "")}'),
      ),
    );
    },
    );
  }

  void _showAddLogBottomSheet(BuildContext context, int babyId) {
    showModalBottomSheet<void>(
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
    );
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

  Widget _buildTimeRangeSelector() {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isGrowth = widget.category == LogCategory.growth;
    final options = isGrowth 
        ? DurationConstants.growthChartPeriodOptions 
        : DurationConstants.chartPeriodOptions;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: options.map((int days) {
          final isSelected = _selectedDays == days;
          
          String label = '$days Days';
          if (isGrowth) {
            if (days == 91) {
              label = '3m';
            } else if (days == 182) {
              label = '6m';
            } else if (days == 365) {
              label = '1y';
            } else if (days == 547) {
              label = '1.5y';
            } else if (days == 730) {
              label = '2y';
            }
          }

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: ChoiceChip(
              label: Text(label),
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

  Widget _buildChartSection(DateTime? birthDate, [String? gender]) {
    switch (widget.category) {
      case LogCategory.feeding:
        return _buildFeedingChart();
      case LogCategory.sleep:
        return _buildSleepChart();
      case LogCategory.diaper:
        return _buildDiaperChart();
      case LogCategory.activity:
        return _buildActivityChart();
      case LogCategory.medical:
        return _buildMedicalChart();
      case LogCategory.growth:
        return _buildGrowthChart(birthDate, gender);
    }
  }

  Widget _buildFeedingChart() {
    final now = DateTime.now();
    final startOfToday = DateTime(now.year, now.month, now.day, 23, 59, 59);

    return StreamBuilder<List<FeedingLog>>(
      stream: context.read<FeedingLogRepository>().watchFeedingLogs(widget.babyId),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return const SizedBox(height: 200, child: Center(child: CircularProgressIndicator()));
        final dailyData = List.filled(_selectedDays, 0.0);
        final dailyCounts = List.generate(_selectedDays, (_) => <String, int>{});
        final rodGradients = List.generate(_selectedDays, (index) => AppColors.feedingGradient);
        
        for (var log in snapshot.data!) {
          final diff = startOfToday.difference(log.startTime).inDays;
          if (diff >= 0 && diff < _selectedDays && log.volumeAmount != null) {
            final dayIdx = (_selectedDays - 1) - diff;
            
            double amount = log.volumeAmount!;
            if (log.volumeUnit == 'oz') {
              amount *= ConversionFactors.ouncesToMilliliters;
            }
            
            dailyData[dayIdx] += amount;
            dailyCounts[dayIdx][log.type] = (dailyCounts[dayIdx][log.type] ?? 0) + 1;
          }
        }

        // Determine dominant type for each day's color
        for (int i = 0; i < _selectedDays; i++) {
          if (dailyCounts[i].isNotEmpty) {
            final dominantType = dailyCounts[i].entries.reduce((a, b) => a.value > b.value ? a : b).key;
            rodGradients[i] = AppColors.getFeedingGradient(dominantType);
          }
        }

        return InsightCharts.buildGenericBarChart(
          context: context,
          title: 'Feeding Volume (ml)',
          icon: Icons.local_drink,
          color: AppColors.accentGreen,
          gradient: AppColors.feedingGradient,
          dailyData: dailyData,
          selectedDays: _selectedDays,
          rodGradients: rodGradients,
        );
      },
    );
  }

  Widget _buildSleepChart() {
    final now = DateTime.now();
    final startOfToday = DateTime(now.year, now.month, now.day, 23, 59, 59);

    return StreamBuilder<List<SleepLog>>(
      stream: context.read<SleepLogRepository>().watchSleepLogs(widget.babyId),
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
          icon: Icons.nights_stay,
          color: AppColors.accentBlue,
          gradient: const LinearGradient(colors: [Color(0xFFBBDEFB), Color(0xFF4A90E2)]),
          dailyData: dailyData,
          selectedDays: _selectedDays,
        );
      },
    );
  }

  Widget _buildDiaperChart() {
    final now = DateTime.now();
    final startOfToday = DateTime(now.year, now.month, now.day, 23, 59, 59);

    return StreamBuilder<List<DiaperLog>>(
      stream: context.read<DiaperLogRepository>().watchDiaperLogs(widget.babyId),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return const SizedBox(height: 200, child: Center(child: CircularProgressIndicator()));
        final dailyData = List.filled(_selectedDays, 0.0);
        for (var log in snapshot.data!) {
          final diff = startOfToday.difference(log.startTime).inDays;
          if (diff >= 0 && diff < _selectedDays) {
            dailyData[(_selectedDays - 1) - diff] += 1;
          }
        }
        final rodGradients = List.generate(_selectedDays, (index) => AppColors.diaperGradient);
        final dailyCounts = List.generate(_selectedDays, (_) => <String, int>{});

        for (var log in snapshot.data!) {
          final diff = startOfToday.difference(log.startTime).inDays;
          if (diff >= 0 && diff < _selectedDays) {
            final dayIdx = (_selectedDays - 1) - diff;
            dailyData[dayIdx] += 1;
            dailyCounts[dayIdx][log.type] = (dailyCounts[dayIdx][log.type] ?? 0) + 1;
          }
        }

        for (int i = 0; i < _selectedDays; i++) {
          if (dailyCounts[i].isNotEmpty) {
            final dominantType = dailyCounts[i].entries.reduce((a, b) => a.value > b.value ? a : b).key;
            rodGradients[i] = AppColors.getDiaperGradient(dominantType);
          }
        }

        return InsightCharts.buildGenericBarChart(
          context: context,
          title: 'Diaper Changes',
          icon: Icons.baby_changing_station,
          color: AppColors.accentYellow,
          gradient: AppColors.diaperGradient,
          dailyData: dailyData,
          selectedDays: _selectedDays,
          rodGradients: rodGradients,
        );
      },
    );
  }

  Widget _buildActivityChart() {
    final now = DateTime.now();
    final startOfToday = DateTime(now.year, now.month, now.day, 23, 59, 59);

    return StreamBuilder<List<ActivityLog>>(
      stream: context.read<ActivityLogRepository>().watchActivityLogs(widget.babyId),
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
        final rodGradients = List.generate(_selectedDays, (index) => AppColors.activityGradient);
        final dailyCounts = List.generate(_selectedDays, (_) => <String, int>{});

        for (var log in snapshot.data!) {
          if (log.endTime != null) {
            final diff = startOfToday.difference(log.startTime).inDays;
            if (diff >= 0 && diff < _selectedDays) {
              final dayIdx = (_selectedDays - 1) - diff;
              dailyData[dayIdx] += log.endTime!.difference(log.startTime).inMinutes.toDouble();
              dailyCounts[dayIdx][log.type] = (dailyCounts[dayIdx][log.type] ?? 0) + 1;
            }
          }
        }

        for (int i = 0; i < _selectedDays; i++) {
          if (dailyCounts[i].isNotEmpty) {
            final dominantType = dailyCounts[i].entries.reduce((a, b) => a.value > b.value ? a : b).key;
            rodGradients[i] = AppColors.getActivityGradient(dominantType);
          }
        }

        return InsightCharts.buildGenericBarChart(
          context: context,
          title: 'Activity Duration (Mins)',
          icon: Icons.extension,
          color: AppColors.accentOrange,
          gradient: AppColors.activityGradient,
          dailyData: dailyData,
          selectedDays: _selectedDays,
          rodGradients: rodGradients,
        );
      },
    );
  }

  Widget _buildMedicalChart() {
    final now = DateTime.now();
    final startOfToday = DateTime(now.year, now.month, now.day, 23, 59, 59);

    return StreamBuilder<List<MedicalLog>>(
      stream: context.read<MedicalLogRepository>().watchMedicalLogs(widget.babyId),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return const SizedBox(height: 200, child: Center(child: CircularProgressIndicator()));
        final dailyData = List.filled(_selectedDays, 0.0);
        for (var log in snapshot.data!) {
          final diff = startOfToday.difference(log.startTime).inDays;
          if (diff >= 0 && diff < _selectedDays) {
            dailyData[(_selectedDays - 1) - diff] += 1;
          }
        }
        final rodGradients = List.generate(_selectedDays, (index) => AppColors.medicalGradient);
        final dailyCounts = List.generate(_selectedDays, (_) => <String, int>{});

        for (var log in snapshot.data!) {
          final diff = startOfToday.difference(log.startTime).inDays;
          if (diff >= 0 && diff < _selectedDays) {
            final dayIdx = (_selectedDays - 1) - diff;
            dailyData[dayIdx] += 1;
            dailyCounts[dayIdx][log.type] = (dailyCounts[dayIdx][log.type] ?? 0) + 1;
          }
        }

        for (int i = 0; i < _selectedDays; i++) {
          if (dailyCounts[i].isNotEmpty) {
            final dominantType = dailyCounts[i].entries.reduce((a, b) => a.value > b.value ? a : b).key;
            rodGradients[i] = AppColors.getMedicalGradient(dominantType);
          }
        }

        return InsightCharts.buildGenericBarChart(
          context: context,
          title: 'Medical Logs',
          icon: Icons.healing,
          color: AppColors.accentRed,
          gradient: AppColors.medicalGradient,
          dailyData: dailyData,
          selectedDays: _selectedDays,
          rodGradients: rodGradients,
        );
      },
    );
  }

  Widget _buildGrowthChart(DateTime? birthDate, [String? gender]) {
    return StreamBuilder<List<GrowthLog>>(
      stream: context.read<GrowthLogRepository>().watchGrowthLogs(widget.babyId),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return const SizedBox(height: 200, child: Center(child: CircularProgressIndicator()));
        final now = DateTime.now();
        final cutoff = now.subtract(Duration(days: _selectedDays));
        final logs = (snapshot.data ?? []).where((l) => l.startTime.isAfter(cutoff)).toList();
        
        return InsightCharts.buildGrowthChart(
          context: context,
          logs: logs,
          selectedDays: _selectedDays,
          birthDate: birthDate,
          gender: gender,
        );
      },
    );
  }

  Widget _buildHistoryHeader() {
    return Text(
      'Recent Logs',
      style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
    );
  }

  Widget _buildLogsList() {
    switch (widget.category) {
      case LogCategory.feeding:
        return _buildFeedingLogsList();
      case LogCategory.sleep:
        return _buildSleepLogsList();
      case LogCategory.diaper:
        return _buildDiaperLogsList();
      case LogCategory.activity:
        return _buildActivityLogsList();
      case LogCategory.medical:
        return _buildMedicalLogsList();
      case LogCategory.growth:
        return _buildGrowthLogsList();
    }
  }

  Widget _buildFeedingLogsList() {
    return StreamBuilder<List<FeedingLog>>(
      stream: context.read<FeedingLogRepository>().watchFeedingLogs(widget.babyId),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
        final logs = snapshot.data!;
        if (logs.isEmpty) return const Center(child: Text('No feeding logs yet.'));

        return ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: logs.length,
          separatorBuilder: (_, index) => const SizedBox(height: 12),
          itemBuilder: (context, index) {
            final log = logs[index];
            return _buildLogCard(
              title: log.type.toUpperCase(),
              subtitle: '${log.volumeAmount ?? ""} ${log.volumeUnit ?? ""}',
              time: DateFormat('MMM d, h:mm a').format(log.startTime),
              icon: Icons.local_drink,
              gradient: AppColors.getFeedingGradient(log.type),
              onEdit: () {
                showModalBottomSheet<void>(
                  context: context,
                  isScrollControlled: true,
                  builder: (_) => FeedLoggingSheet(babyId: widget.babyId, existingLog: log),
                );
              },
              onDelete: () => context.read<FeedingLogRepository>().deleteFeedingLog(log.id),
            );
          },
        );
      },
    );
  }

  Widget _buildSleepLogsList() {
    return StreamBuilder<List<SleepLog>>(
      stream: context.read<SleepLogRepository>().watchSleepLogs(widget.babyId),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
        final logs = snapshot.data!;
        if (logs.isEmpty) return const Center(child: Text('No sleep logs yet.'));

        return ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: logs.length,
          separatorBuilder: (_, index) => const SizedBox(height: 12),
          itemBuilder: (context, index) {
            final log = logs[index];
            final duration = log.endTime?.difference(log.startTime);
            return _buildLogCard(
              title: 'SLEEP',
              subtitle: duration != null ? '${duration.inHours}h ${duration.inMinutes % 60}m' : 'In Progress',
              time: DateFormat('MMM d, h:mm a').format(log.startTime),
              icon: Icons.nights_stay,
              gradient: AppColors.sleepGradient,
              onEdit: () {
                showModalBottomSheet<void>(
                  context: context,
                  isScrollControlled: true,
                  builder: (_) => SleepLoggingSheet(babyId: widget.babyId, existingLog: log),
                );
              },
              onDelete: () => context.read<SleepLogRepository>().deleteSleepLog(log.id),
            );
          },
        );
      },
    );
  }

  Widget _buildDiaperLogsList() {
    return StreamBuilder<List<DiaperLog>>(
      stream: context.read<DiaperLogRepository>().watchDiaperLogs(widget.babyId),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
        final logs = snapshot.data!;
        if (logs.isEmpty) return const Center(child: Text('No diaper logs yet.'));

        return ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: logs.length,
          separatorBuilder: (_, index) => const SizedBox(height: 12),
          itemBuilder: (context, index) {
            final log = logs[index];
            return _buildLogCard(
              title: log.type.toUpperCase(),
              subtitle: '${log.consistency ?? ""} ${log.color ?? ""}',
              time: DateFormat('MMM d, h:mm a').format(log.startTime),
              icon: Icons.baby_changing_station,
              gradient: AppColors.getDiaperGradient(log.type),
              onEdit: () {
                showModalBottomSheet<void>(
                  context: context,
                  isScrollControlled: true,
                  builder: (_) => DiaperLoggingSheet(babyId: widget.babyId, existingLog: log),
                );
              },
              onDelete: () => context.read<DiaperLogRepository>().deleteDiaperLog(log.id),
            );
          },
        );
      },
    );
  }

  Widget _buildActivityLogsList() {
    return StreamBuilder<List<ActivityLog>>(
      stream: context.read<ActivityLogRepository>().watchActivityLogs(widget.babyId),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
        final logs = snapshot.data!;
        if (logs.isEmpty) return const Center(child: Text('No activity logs yet.'));

        return ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: logs.length,
          separatorBuilder: (_, index) => const SizedBox(height: 12),
          itemBuilder: (context, index) {
            final log = logs[index];
            final hasMilestone = log.milestones != null && log.milestones!.trim().isNotEmpty;
            return _buildLogCard(
              title: log.type.toUpperCase(),
              subtitle: hasMilestone ? log.milestones! : 'No milestones recorded', // Handled carefully
              showSubtitle: hasMilestone,
              time: DateFormat('MMM d, h:mm a').format(log.startTime),
              icon: Icons.extension,
              gradient: AppColors.getActivityGradient(log.type),
              onEdit: () {
                showModalBottomSheet<void>(
                  context: context,
                  isScrollControlled: true,
                  builder: (_) => ActivityLoggingSheet(babyId: widget.babyId, existingLog: log),
                );
              },
              onDelete: () => context.read<ActivityLogRepository>().deleteActivityLog(log.id),
            );
          },
        );
      },
    );
  }

  Widget _buildMedicalLogsList() {
    return StreamBuilder<List<MedicalLog>>(
      stream: context.read<MedicalLogRepository>().watchMedicalLogs(widget.babyId),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
        final logs = snapshot.data!;
        if (logs.isEmpty) return const Center(child: Text('No medical logs yet.'));

        return ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: logs.length,
          separatorBuilder: (_, index) => const SizedBox(height: 12),
          itemBuilder: (context, index) {
            final log = logs[index];
            return _buildLogCard(
              title: log.type.toUpperCase(),
              subtitle: '${log.name} - ${log.dosage ?? ""}',
              time: DateFormat('MMM d, h:mm a').format(log.startTime),
              icon: Icons.healing,
              gradient: AppColors.getMedicalGradient(log.type),
              onEdit: () {
                showModalBottomSheet<void>(
                  context: context,
                  isScrollControlled: true,
                  builder: (_) => MedicalLoggingSheet(babyId: widget.babyId, existingLog: log),
                );
              },
              onDelete: () => context.read<MedicalLogRepository>().deleteMedicalLog(log.id),
            );
          },
        );
      },
    );
  }

  Widget _buildGrowthLogsList() {
    return StreamBuilder<List<GrowthLog>>(
      stream: context.read<GrowthLogRepository>().watchGrowthLogs(widget.babyId),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
        final logs = snapshot.data!;
        if (logs.isEmpty) return const Center(child: Text('No growth logs yet.'));

        return ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: logs.length,
          separatorBuilder: (_, index) => const SizedBox(height: 12),
          itemBuilder: (context, index) {
            final log = logs[index];
            return _buildLogCard(
              title: 'GROWTH',
              subtitle: 'W: ${log.weight ?? "-"}kg, H: ${log.height ?? "-"}cm',
              time: DateFormat('MMM d, yyyy').format(log.startTime),
              icon: Icons.trending_up,
              gradient: AppColors.growthGradient,
              onEdit: () {
                showModalBottomSheet<void>(
                  context: context,
                  isScrollControlled: true,
                  builder: (_) => GrowthLoggingSheet(babyId: widget.babyId, existingLog: log),
                );
              },
              onDelete: () => context.read<GrowthLogRepository>().deleteGrowthLog(log.id),
            );
          },
        );
      },
    );
  }

  Widget _buildLogCard({
    required String title,
    required String subtitle,
    required String time,
    required IconData icon,
    required LinearGradient gradient,
    VoidCallback? onDelete,
    VoidCallback? onEdit,
    bool showSubtitle = true,
  }) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            colors: [
              gradient.colors.first.withValues(alpha: 0.05),
              gradient.colors.last.withValues(alpha: 0.02),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                gradient: gradient,
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: Colors.white, size: 20),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12, letterSpacing: 1.2)),
                  if (showSubtitle) ...[
                    const SizedBox(height: 4),
                    Text(subtitle, style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
                  ],
                ],
              ),
            ),
            Text(time, style: Theme.of(context).textTheme.bodySmall),
            if (onEdit != null) ...[
              IconButton(
                icon: const Icon(Icons.edit_outlined, size: 20),
                color: Colors.blue[300],
                onPressed: onEdit,
              ),
            ],
            if (onDelete != null) ...[
              IconButton(
                icon: const Icon(Icons.delete_outline, size: 20),
                color: Colors.red[300],
                onPressed: () {
                  showDialog<void>(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Delete Log'),
                      content: const Text('Are you sure you want to delete this log?'),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text('Cancel'),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                            onDelete();
                          },
                          child: const Text('Delete', style: TextStyle(color: Colors.red)),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ],
        ),
      ),
    );
  }
}
