import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/database/repositories/log_repositories.dart';
import '../../../../core/database/app_database.dart';
import '../../../../core/constants/enums.dart';
import 'package:intl/intl.dart';
import 'timeline_event.dart';
import '../../../insights/presentation/category_detail_screen.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({super.key, required this.babyId});

  final int babyId;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      decoration: BoxDecoration(
        gradient: isDark ? AppColors.backgroundGradientDark : AppColors.backgroundGradient,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1000),
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(24, 32, 24, 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Welcome back,',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      Text(
                        'Baby Steps',
                        style: Theme.of(context).textTheme.displayLarge?.copyWith(
                          fontSize: 32,
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                      ),
                      const SizedBox(height: 32),
                      _buildQuickSummary(context),
                      const SizedBox(height: 32),
                      Text(
                        'Recent Activities',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: 16),
                    ],
                  ),
                ),
              ),
              _buildRecentLogsList(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildQuickSummary(BuildContext context) {
    final sleepRepo = context.read<SleepLogRepository>();
    final feedingRepo = context.read<FeedingLogRepository>();
    final diaperRepo = context.read<DiaperLogRepository>();
    final activityRepo = context.read<ActivityLogRepository>();
    final medicalRepo = context.read<MedicalLogRepository>();
    final growthRepo = context.read<GrowthLogRepository>();

    return StreamBuilder<List<dynamic>>(
      stream: CombineLatestStream.list<dynamic>([
        sleepRepo.watchSleepLogs(babyId).map((l) => l.isEmpty ? null : l.first),
        feedingRepo.watchFeedingLogs(babyId).map((l) => l.isEmpty ? null : l.first),
        diaperRepo.watchDiaperLogs(babyId).map((l) => l.isEmpty ? null : l.first),
        activityRepo.watchActivityLogs(babyId).map((l) => l.isEmpty ? null : l.first),
        medicalRepo.watchMedicalLogs(babyId).map((l) => l.isEmpty ? null : l.first),
        growthRepo.watchGrowthLogs(babyId).map((l) => l.isEmpty ? null : l.first),
      ]),
      builder: (context, snapshot) {
        final lastSleep = snapshot.data?[0] as SleepLog?;
        final lastFeed = snapshot.data?[1] as FeedingLog?;
        final lastDiaper = snapshot.data?[2] as DiaperLog?;
        final lastActivity = snapshot.data?[3] as ActivityLog?;
        final lastMedical = snapshot.data?[4] as MedicalLog?;
        final lastGrowth = snapshot.data?[5] as GrowthLog?;

        return LayoutBuilder(
          builder: (context, constraints) {
            final crossAxisCount = (constraints.maxWidth / 120).floor().clamp(2, 6);
            return GridView.count(
              crossAxisCount: crossAxisCount,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              childAspectRatio: 1.1,
              children: [
                _buildSummaryCard(
                  context,
                  title: 'Sleep',
                  color: AppColors.sleepBlue,
                  icon: Icons.nights_stay,
                  subtitle: lastSleep != null ? (lastSleep.endTime == null ? 'Sleeping' : _formatDuration(lastSleep.startTime, lastSleep.endTime!)) : 'No logs',
                  gradient: AppColors.sleepGradient,
                  onTap: () => unawaited(Navigator.push<void>(context, MaterialPageRoute<void>(builder: (_) => CategoryDetailScreen(babyId: babyId, category: LogCategory.sleep)))),
                ),
                _buildSummaryCard(
                  context,
                  title: 'Feeding',
                  color: AppColors.feedingGreen,
                  icon: Icons.local_drink,
                  subtitle: lastFeed != null ? '${lastFeed.volumeAmount ?? ""}${lastFeed.volumeUnit ?? "Milk"}' : 'No logs',
                  gradient: AppColors.feedingGradient,
                  onTap: () => unawaited(Navigator.push<void>(context, MaterialPageRoute<void>(builder: (_) => CategoryDetailScreen(babyId: babyId, category: LogCategory.feeding)))),
                ),
                _buildSummaryCard(
                  context,
                  title: 'Diaper',
                  color: AppColors.diaperYellow,
                  icon: Icons.baby_changing_station,
                  subtitle: lastDiaper != null ? lastDiaper.type : 'No logs',
                  gradient: AppColors.diaperGradient,
                  onTap: () => unawaited(Navigator.push<void>(context, MaterialPageRoute<void>(builder: (_) => CategoryDetailScreen(babyId: babyId, category: LogCategory.diaper)))),
                ),
                _buildSummaryCard(
                  context,
                  title: 'Activity',
                  color: AppColors.activityOrange,
                  icon: Icons.extension,
                  subtitle: lastActivity != null ? lastActivity.type : 'No logs',
                  gradient: AppColors.activityGradient,
                  onTap: () => unawaited(Navigator.push<void>(context, MaterialPageRoute<void>(builder: (_) => CategoryDetailScreen(babyId: babyId, category: LogCategory.activity)))),
                ),
                _buildSummaryCard(
                  context,
                  title: 'Medical',
                  color: AppColors.medicalRed,
                  icon: Icons.healing,
                  subtitle: lastMedical != null ? lastMedical.name : 'No logs',
                  gradient: AppColors.medicalGradient,
                  onTap: () => unawaited(Navigator.push<void>(context, MaterialPageRoute<void>(builder: (_) => CategoryDetailScreen(babyId: babyId, category: LogCategory.medical)))),
                ),
                _buildSummaryCard(
                  context,
                  title: 'Growth',
                  color: AppColors.growthTeal,
                  icon: Icons.trending_up,
                  subtitle: lastGrowth != null ? '${lastGrowth.weight ?? lastGrowth.height ?? ""} ${lastGrowth.weight != null ? "kg" : "cm"}' : 'No logs',
                  gradient: AppColors.growthGradient,
                  onTap: () => unawaited(Navigator.push<void>(context, MaterialPageRoute<void>(builder: (_) => CategoryDetailScreen(babyId: babyId, category: LogCategory.growth)))),
                ),
              ],
            );
          },
        );
      },
    );
  }

  Widget _buildSummaryCard(
    BuildContext context, {
    required String title,
    required Color color,
    required IconData icon,
    required String subtitle,
    required LinearGradient gradient,
    required VoidCallback onTap,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final contentColor = isDark ? AppColors.textLightPrimary : Colors.black87; 
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          gradient: gradient,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: color.withValues(alpha: 0.2),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: contentColor, size: 24),
            const SizedBox(height: 4),
            Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
                color: contentColor,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              subtitle,
              style: TextStyle(
                color: contentColor.withValues(alpha: 0.6),
                fontSize: 10,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRecentLogsList(BuildContext context) {
    final sleepRepo = context.read<SleepLogRepository>();
    final feedingRepo = context.read<FeedingLogRepository>();
    final diaperRepo = context.read<DiaperLogRepository>();
    final activityRepo = context.read<ActivityLogRepository>();
    final medicalRepo = context.read<MedicalLogRepository>();
    final growthRepo = context.read<GrowthLogRepository>();

    return StreamBuilder<List<TimelineEvent>>(
      stream: CombineLatestStream.list<dynamic>([
        feedingRepo.watchFeedingLogs(babyId),
        sleepRepo.watchSleepLogs(babyId),
        diaperRepo.watchDiaperLogs(babyId),
        activityRepo.watchActivityLogs(babyId),
        medicalRepo.watchMedicalLogs(babyId),
        growthRepo.watchGrowthLogs(babyId),
      ]).map((lists) {
        final events = <TimelineEvent>[];
        for (var list in lists) {
          if (list is List<FeedingLog>) {
            events.addAll(list.map((l) => TimelineEvent(
              id: l.id,
              type: TimelineEventType.feed,
              time: l.startTime,
              title: 'Feeding (${l.type})',
              subtitle: l.volumeAmount != null ? '${l.volumeAmount} ${l.volumeUnit}' : 'Breastfeed',
              color: AppColors.getFeedingColor(l.type),
              icon: Icons.local_drink,
            )));
          } else if (list is List<SleepLog>) {
            events.addAll(list.map((l) => TimelineEvent(
              id: l.id,
              type: TimelineEventType.sleep,
              time: l.startTime,
              title: 'Sleep',
              subtitle: l.endTime != null ? 'Duration: ${_formatDuration(l.startTime, l.endTime!)}' : 'In progress',
              color: AppColors.sleepBlue,
              icon: Icons.nights_stay,
            )));
          } else if (list is List<DiaperLog>) {
            events.addAll(list.map((l) => TimelineEvent(
              id: l.id,
              type: TimelineEventType.diaper,
              time: l.startTime,
              title: 'Diaper (${l.type})',
              subtitle: '${l.consistency ?? ""} ${l.color ?? ""}',
              color: AppColors.getDiaperAccentColor(l.type),
              icon: Icons.baby_changing_station,
            )));
          } else if (list is List<ActivityLog>) {
            events.addAll(list.map((l) => TimelineEvent(
              id: l.id,
              type: TimelineEventType.activity,
              time: l.startTime,
              title: 'Activity (${l.type})',
              subtitle: l.endTime != null ? 'Duration: ${_formatDuration(l.startTime, l.endTime!)}' : 'In progress',
              color: AppColors.getActivityAccentColor(l.type),
              icon: Icons.extension,
            )));
          } else if (list is List<MedicalLog>) {
            events.addAll(list.map((l) => TimelineEvent(
              id: l.id,
              type: TimelineEventType.medical,
              time: l.startTime,
              title: 'Medical (${l.type})',
              subtitle: '${l.name} ${l.dosage ?? ""}',
              color: AppColors.getMedicalAccentColor(l.type),
              icon: Icons.healing,
            )));
          } else if (list is List<GrowthLog>) {
            events.addAll(list.map((l) => TimelineEvent(
              id: l.id,
              type: TimelineEventType.growth,
              time: l.startTime,
              title: 'Growth',
              subtitle: 'W: ${l.weight ?? "-"} H: ${l.height ?? "-"}',
              color: AppColors.growthTeal,
              icon: Icons.trending_up,
            )));
          }
        }
        events.sort((a, b) => b.time.compareTo(a.time));
        return events.take(10).toList();
      }),
      builder: (context, snapshot) {
        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(48.0),
              child: Center(child: Text('No recent activities yet.')),
            ),
          );
        }

        final events = snapshot.data!;
        return SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final event = events[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  child: ListTile(
                    onTap: () => _showLogDetails(context, event),
                    leading: CircleAvatar(
                      backgroundColor: event.color,
                      child: Icon(event.icon, color: Colors.black87),
                    ),
                    title: Text(event.title),
                    subtitle: Text(event.subtitle),
                    trailing: Text(
                      DateFormat.jm().format(event.time),
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ),
                );
              },
              childCount: events.length,
            ),
          ),
        );
      },
    );
  }

  void _showLogDetails(BuildContext context, TimelineEvent event) {
    unawaited(showModalBottomSheet<void>(
      context: context,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  CircleAvatar(backgroundColor: event.color, child: Icon(event.icon, color: Colors.white)),
                  const SizedBox(width: 16),
                  Text(event.title, style: Theme.of(context).textTheme.headlineSmall),
                ],
              ),
              const SizedBox(height: 24),
              Text('Details', style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 8),
              Text(event.subtitle, style: Theme.of(context).textTheme.bodyLarge),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      _deleteEvent(context, event);
                      Navigator.pop(context);
                    },
                    child: const Text('Delete', style: TextStyle(color: Colors.red)),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Close'),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    ));
  }

  void _deleteEvent(BuildContext context, TimelineEvent event) {
    switch (event.type) {
      case TimelineEventType.feed:
        context.read<FeedingLogRepository>().deleteFeedingLog(event.id);
        break;
      case TimelineEventType.sleep:
        context.read<SleepLogRepository>().deleteSleepLog(event.id);
        break;
      case TimelineEventType.diaper:
        context.read<DiaperLogRepository>().deleteDiaperLog(event.id);
        break;
      case TimelineEventType.activity:
        context.read<ActivityLogRepository>().deleteActivityLog(event.id);
        break;
      case TimelineEventType.medical:
        context.read<MedicalLogRepository>().deleteMedicalLog(event.id);
        break;
      case TimelineEventType.growth:
        context.read<GrowthLogRepository>().deleteGrowthLog(event.id);
        break;
    }
  }

  String _formatDuration(DateTime start, DateTime end) {
    final diff = end.difference(start);
    final hours = diff.inHours;
    final minutes = diff.inMinutes % 60;
    if (hours > 0) return '${hours}h ${minutes}m';
    return '${minutes}m';
  }
}
