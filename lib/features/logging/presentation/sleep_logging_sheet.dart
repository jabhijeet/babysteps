import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:drift/drift.dart' show Value;
import '../../../core/database/app_database.dart';
import '../../../core/theme/colors.dart';
import '../bloc/logging_bloc.dart';

class SleepLoggingSheet extends StatefulWidget {
  const SleepLoggingSheet({super.key, required this.babyId, this.existingLog});

  final int babyId;
  final SleepLog? existingLog;

  @override
  State<SleepLoggingSheet> createState() => _SleepLoggingSheetState();
}

class _SleepLoggingSheetState extends State<SleepLoggingSheet> {
  DateTime _startTime = DateTime.now().subtract(const Duration(hours: 1));
  DateTime _endTime = DateTime.now();

  @override
  void initState() {
    super.initState();
    if (widget.existingLog != null) {
      _startTime = widget.existingLog!.startTime;
      _endTime = widget.existingLog!.endTime ?? DateTime.now();
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
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Center(
            child: Container(
              width: 40, height: 4,
              margin: const EdgeInsets.only(bottom: 24),
              decoration: BoxDecoration(color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.3), borderRadius: BorderRadius.circular(2)),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Log Sleep', style: Theme.of(context).textTheme.displaySmall?.copyWith(fontSize: 24, color: Theme.of(context).colorScheme.onSurface)),
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: () => Navigator.pop(context),
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
              ),
            ],
          ),
          const SizedBox(height: 32),
          
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
          const SizedBox(height: 32),
          
          Container(
            decoration: BoxDecoration(
              gradient: AppColors.sleepGradient,
              borderRadius: BorderRadius.circular(16),
            ),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                shadowColor: Colors.transparent,
                foregroundColor: AppColors.textLightPrimary,
              ),
              onPressed: () {
                if (widget.existingLog != null) {
                  final updatedLog = widget.existingLog!.copyWith(
                    startTime: _startTime,
                    endTime: Value(_endTime),
                  );
                  context.read<LoggingBloc>().add(UpdateSleepLogEvent(updatedLog));
                } else {
                  context.read<LoggingBloc>().add(
                    SaveSleepLogEvent(
                      babyId: widget.babyId,
                      startTime: _startTime,
                      endTime: _endTime,
                    ),
                  );
                }
                Navigator.pop(context);
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Text(widget.existingLog != null ? 'Update Sleep Log' : 'Save Sleep Log', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              ),

            ),
          ),
        ],
      ),
    );
  }
}
