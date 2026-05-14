import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:drift/drift.dart' show Value;
import '../../../core/database/app_database.dart';
import '../../../core/theme/colors.dart';
import '../bloc/logging_bloc.dart';

class ActivityLoggingSheet extends StatefulWidget {
  const ActivityLoggingSheet({super.key, required this.babyId, this.existingLog});

  final int babyId;
  final ActivityLog? existingLog;

  @override
  State<ActivityLoggingSheet> createState() => _ActivityLoggingSheetState();
}

class _ActivityLoggingSheetState extends State<ActivityLoggingSheet> {
  String _activityType = 'Tummy Time';
  final TextEditingController _notesController = TextEditingController();
  final TextEditingController _milestonesController = TextEditingController();
  
  DateTime _startTime = DateTime.now().subtract(const Duration(hours: 1));
  DateTime _endTime = DateTime.now();

  @override
  void initState() {
    super.initState();
    if (widget.existingLog != null) {
      final log = widget.existingLog!;
      _activityType = log.type;
      _notesController.text = log.notes ?? '';
      _milestonesController.text = log.milestones ?? '';
      _startTime = log.startTime;
      _endTime = log.endTime ?? DateTime.now();
    }
  }


  Future<void> _pickDateTime(bool isStart) async {
    final initial = isStart ? _startTime : _endTime;
    final date = await showDatePicker(
      context: context,
      initialDate: initial,
      firstDate: DateTime(2000),
      lastDate: DateTime.now().add(const Duration(days: 1)),
    );
    if (date == null || !mounted) return;
    
    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(initial),
    );
    if (time == null) return;
    
    final finalDateTime = DateTime(date.year, date.month, date.day, time.hour, time.minute);
    setState(() {
      if (isStart) {
        _startTime = finalDateTime;
        if (_endTime.isBefore(_startTime)) {
          _endTime = _startTime.add(const Duration(hours: 1));
        }
      } else {
        _endTime = finalDateTime;
      }
    });
  }

  @override
  void dispose() {
    _notesController.dispose();
    _milestonesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
      ),
      padding: EdgeInsets.only(
        top: 12, left: 24, right: 24,
        bottom: MediaQuery.of(context).viewInsets.bottom + 32,
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: Container(
                width: 40, height: 4,
                margin: const EdgeInsets.only(bottom: 24),
                decoration: BoxDecoration(color: Colors.grey.withValues(alpha: 0.3), borderRadius: BorderRadius.circular(2)),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Activity Logger', style: Theme.of(context).textTheme.displaySmall?.copyWith(fontSize: 24, color: Theme.of(context).colorScheme.onSurface)),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.pop(context),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
              ],
            ),
            const SizedBox(height: 24),
            DropdownButtonFormField<String>(
              initialValue: _activityType,
              decoration: InputDecoration(
                labelText: 'Activity Type',
                prefixIcon: Icon(Icons.category, color: AppColors.getActivityAccentColor(_activityType)),
                filled: true,
                fillColor: AppColors.getActivityColor(_activityType).withValues(alpha: 0.1),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
              items: ['Tummy Time', 'Play', 'Bath', 'Other'].map((String value) {
                return DropdownMenuItem<String>(
                  value: value, 
                  child: Row(
                    children: [
                      Icon(_getActivityIcon(value), size: 20, color: AppColors.getActivityAccentColor(value)),
                      const SizedBox(width: 12),
                      Text(value),
                    ],
                  ),
                );
              }).toList(),
              onChanged: (String? val) {
                if (val != null) setState(() => _activityType = val);
              },
            ),
            const SizedBox(height: 24),
            
            ListTile(
              title: const Text('Start Time'),
              subtitle: Text('${_startTime.toLocal()}'.split(':').sublist(0,2).join(':')),
              trailing: const Icon(Icons.access_time),
              onTap: () => _pickDateTime(true),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12), side: BorderSide(color: Colors.grey.withValues(alpha: 0.2))),
            ),
            const SizedBox(height: 16),
            ListTile(
              title: const Text('End Time'),
              subtitle: Text('${_endTime.toLocal()}'.split(':').sublist(0,2).join(':')),
              trailing: const Icon(Icons.access_time),
              onTap: () => _pickDateTime(false),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12), side: BorderSide(color: Colors.grey.withValues(alpha: 0.2))),
            ),
            
            const SizedBox(height: 24),
            TextField(
              controller: _milestonesController,
              decoration: InputDecoration(
                labelText: 'Milestones (Optional)',
                prefixIcon: const Icon(Icons.stars),
                filled: true,
                fillColor: Colors.grey.withValues(alpha: 0.05),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _notesController,
              decoration: InputDecoration(
                labelText: 'Notes',
                prefixIcon: const Icon(Icons.notes),
                filled: true,
                fillColor: Colors.grey.withValues(alpha: 0.05),
              ),
              maxLines: 2,
            ),
            const SizedBox(height: 32),
            Container(
              decoration: BoxDecoration(
                gradient: AppColors.getActivityGradient(_activityType),
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.getActivityAccentColor(_activityType).withValues(alpha: 0.3),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                  foregroundColor: AppColors.textLightPrimary,
                ),
                onPressed: () {
                  final String? milestones = _milestonesController.text.isNotEmpty ? _milestonesController.text : null;
                  final String? notes = _notesController.text.isNotEmpty ? _notesController.text : null;

                  if (widget.existingLog != null) {
                    final updatedLog = widget.existingLog!.copyWith(
                      type: _activityType,
                      startTime: _startTime,
                      endTime: Value(_endTime),
                      milestones: Value(milestones),
                      notes: Value(notes),
                    );
                    context.read<LoggingBloc>().add(UpdateActivityLogEvent(updatedLog));
                  } else {
                    context.read<LoggingBloc>().add(
                      SaveActivityLogEvent(
                        babyId: widget.babyId,
                        type: _activityType,
                        startTime: _startTime,
                        endTime: _endTime,
                        milestones: milestones,
                        notes: notes,
                      ),
                    );
                  }
                  Navigator.pop(context);
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: Text(widget.existingLog != null ? 'Update Activity' : 'Save Activity', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                ),

              ),
            ),
          ],
        ),
      ),
    );
  }
  IconData _getActivityIcon(String type) {
    switch (type) {
      case 'Tummy Time':
        return Icons.child_care;
      case 'Play':
        return Icons.extension;
      case 'Bath':
        return Icons.bathtub;
      default:
        return Icons.more_horiz;
    }
  }
}
