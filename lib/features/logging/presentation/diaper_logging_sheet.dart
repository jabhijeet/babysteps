import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:drift/drift.dart' show Value;
import '../../../core/database/app_database.dart';
import '../../../core/theme/colors.dart';
import '../bloc/logging_bloc.dart';

class DiaperLoggingSheet extends StatefulWidget {
  const DiaperLoggingSheet({super.key, required this.babyId, this.existingLog});

  final int babyId;
  final DiaperLog? existingLog;

  @override
  State<DiaperLoggingSheet> createState() => _DiaperLoggingSheetState();
}

class _DiaperLoggingSheetState extends State<DiaperLoggingSheet> {
  String _type = 'Wet';
  String _consistency = 'Soft';
  String _color = 'Yellow';

  DateTime _startTime = DateTime.now();
  DateTime _endTime = DateTime.now();

  @override
  void initState() {
    super.initState();
    if (widget.existingLog != null) {
      final log = widget.existingLog!;
      _type = log.type[0].toUpperCase() + log.type.substring(1);
      _consistency = log.consistency ?? 'Soft';
      _color = log.color ?? 'Yellow';
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
          _endTime = _startTime;
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
                Text('Log Diaper Change', style: Theme.of(context).textTheme.displaySmall?.copyWith(fontSize: 24, color: Theme.of(context).colorScheme.onSurface)),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.pop(context),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
              ],
            ),
            const SizedBox(height: 24),
            SegmentedButton<String>(
              style: SegmentedButton.styleFrom(
                selectedBackgroundColor: AppColors.getDiaperAccentColor(_type),
                selectedForegroundColor: Colors.white,
              ),
              segments: const [
                ButtonSegment(value: 'Wet', label: Text('Wet'), icon: Icon(Icons.water_drop)),
                ButtonSegment(value: 'Dirty', label: Text('Dirty'), icon: Icon(Icons.eco)),
                ButtonSegment(value: 'Both', label: Text('Both'), icon: Icon(Icons.all_inclusive)),
              ],
              selected: {_type},
              onSelectionChanged: (Set<String> newSelection) {
                setState(() {
                  _type = newSelection.first;
                });
              },
            ),
            const SizedBox(height: 24),
            ListTile(
              title: const Text('Time'),
              subtitle: Text('${_startTime.toLocal()}'.split(':').sublist(0,2).join(':')),
              trailing: const Icon(Icons.access_time),
              onTap: () => _pickDateTime(true),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12), side: BorderSide(color: Colors.grey.withValues(alpha: 0.2))),
            ),
            const SizedBox(height: 32),
            if (_type == 'Dirty' || _type == 'Both') ...[
              DropdownButtonFormField<String>(
                initialValue: _consistency,
                decoration: InputDecoration(
                  labelText: 'Consistency',
                  prefixIcon: const Icon(Icons.texture),
                  filled: true,
                  fillColor: Colors.grey.withValues(alpha: 0.05),
                ),
                items: ['Hard', 'Soft', 'Watery'].map((String value) {
                  return DropdownMenuItem<String>(value: value, child: Text(value));
                }).toList(),
                onChanged: (String? val) => setState(() => _consistency = val!),
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                initialValue: _color,
                decoration: InputDecoration(
                  labelText: 'Color',
                  prefixIcon: const Icon(Icons.palette),
                  filled: true,
                  fillColor: Colors.grey.withValues(alpha: 0.05),
                ),
                items: ['Yellow', 'Green', 'Brown', 'Bloody'].map((String value) {
                  return DropdownMenuItem<String>(value: value, child: Text(value));
                }).toList(),
                onChanged: (String? val) => setState(() => _color = val!),
              ),
              const SizedBox(height: 32),
            ],
            Container(
              decoration: BoxDecoration(
                gradient: AppColors.getDiaperGradient(_type),
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(color: AppColors.getDiaperAccentColor(_type).withValues(alpha: 0.3), blurRadius: 12, offset: const Offset(0, 4)),
                ],
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
                      type: _type.toLowerCase(),
                      consistency: Value(_type != 'Wet' ? _consistency : null),
                      color: Value(_type != 'Wet' ? _color : null),
                    );
                    context.read<LoggingBloc>().add(UpdateDiaperLogEvent(updatedLog));
                  } else {
                    context.read<LoggingBloc>().add(
                      SaveDiaperLogEvent(
                        babyId: widget.babyId,
                        startTime: _startTime,
                        endTime: null,
                        type: _type.toLowerCase(),
                        consistency: _type != 'Wet' ? _consistency : null,
                        color: _type != 'Wet' ? _color : null,
                      ),
                    );
                  }
                  Navigator.pop(context);
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: Text(widget.existingLog != null ? 'Update Diaper Log' : 'Save Diaper Log', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                ),

              ),
            ),
          ],
        ),
      ),
    );
  }
}
