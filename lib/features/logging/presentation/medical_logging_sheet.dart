import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:drift/drift.dart' show Value;
import '../../../core/database/app_database.dart';
import '../../../core/theme/colors.dart';
import '../bloc/logging_bloc.dart';

class MedicalLoggingSheet extends StatefulWidget {
  const MedicalLoggingSheet({super.key, required this.babyId, this.existingLog});

  final int babyId;
  final MedicalLog? existingLog;

  @override
  State<MedicalLoggingSheet> createState() => _MedicalLoggingSheetState();
}

class _MedicalLoggingSheetState extends State<MedicalLoggingSheet> {
  String _type = 'Medication';
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _dosageController = TextEditingController();
  final TextEditingController _notesController = TextEditingController();
  bool _setReminder = false;
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;

  DateTime _startTime = DateTime.now();
  DateTime _endTime = DateTime.now();

  @override
  void initState() {
    super.initState();
    if (widget.existingLog != null) {
      final log = widget.existingLog!;
      _type = log.type;
      _nameController.text = log.name;
      _dosageController.text = log.dosage ?? '';
      _notesController.text = log.notes ?? '';
      _startTime = log.startTime;
      _endTime = log.endTime ?? DateTime.now();
      if (log.reminderTime != null) {
        _setReminder = true;
        _selectedDate = log.reminderTime;
        _selectedTime = TimeOfDay.fromDateTime(log.reminderTime!);
      }
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
  void dispose() {
    _nameController.dispose();
    _dosageController.dispose();
    _notesController.dispose();
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
                Text('Medical Log', style: Theme.of(context).textTheme.displaySmall?.copyWith(fontSize: 24, color: Theme.of(context).colorScheme.onSurface)),
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
                selectedBackgroundColor: AppColors.getMedicalAccentColor(_type),
                selectedForegroundColor: Colors.white,
              ),
              segments: const [
                ButtonSegment(value: 'Medication', label: Text('Medication'), icon: Icon(Icons.medication)),
                ButtonSegment(value: 'Vaccination', label: Text('Vaccination'), icon: Icon(Icons.vaccines)),
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
            const SizedBox(height: 24),
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'Name / Type',
                prefixIcon: const Icon(Icons.medical_services),
                filled: true,
                fillColor: Colors.grey.withValues(alpha: 0.05),
              ),
            ),
            const SizedBox(height: 16),
            if (_type == 'Medication') ...[
              TextField(
                controller: _dosageController,
                decoration: InputDecoration(
                  labelText: 'Dosage',
                  prefixIcon: const Icon(Icons.science),
                  filled: true,
                  fillColor: Colors.grey.withValues(alpha: 0.05),
                  hintText: 'e.g., 2.5ml',
                ),
              ),
              const SizedBox(height: 16),
            ],
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
            const SizedBox(height: 16),
            SwitchListTile(
              title: const Text('Set Reminder'),
              subtitle: _setReminder 
                ? Text(_selectedDate != null && _selectedTime != null 
                    ? 'Reminder set for ${_selectedDate!.toLocal().toString().split(' ')[0]} ${_selectedTime!.format(context)}' 
                    : 'Tap to select date and time')
                : const Text('Notify for the next dose or appointment'),
              value: _setReminder,
              activeThumbColor: AppColors.accentPrimary,
              onChanged: (val) async {
                if (val) {
                  final DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime.now().add(const Duration(days: 365)),
                  );
                  if (pickedDate != null && context.mounted) {
                    final TimeOfDay? pickedTime = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.now(),
                    );
                    if (pickedTime != null) {
                      setState(() {
                        _selectedDate = pickedDate;
                        _selectedTime = pickedTime;
                        _setReminder = true;
                      });
                    }
                  }
                } else {
                  setState(() {
                    _setReminder = false;
                    _selectedDate = null;
                    _selectedTime = null;
                  });
                }
              },
            ),
            const SizedBox(height: 32),
            Container(
              decoration: BoxDecoration(
                gradient: AppColors.getMedicalGradient(_type),
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.getMedicalAccentColor(_type).withValues(alpha: 0.3),
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
                  final String name = _nameController.text.isNotEmpty ? _nameController.text : 'Unknown';
                  final String? dosage = _dosageController.text.isNotEmpty ? _dosageController.text : null;
                  final String? notes = _notesController.text.isNotEmpty ? _notesController.text : null;
                  
                  DateTime? reminderTime;
                  if (_setReminder && _selectedDate != null && _selectedTime != null) {
                    reminderTime = DateTime(
                      _selectedDate!.year,
                      _selectedDate!.month,
                      _selectedDate!.day,
                      _selectedTime!.hour,
                      _selectedTime!.minute,
                    );
                  }

                  if (widget.existingLog != null) {
                    final updatedLog = widget.existingLog!.copyWith(
                      type: _type,
                      name: name,
                      dosage: Value(dosage),
                      startTime: _startTime,
                      endTime: Value(null),
                      reminderTime: Value(reminderTime),
                      notes: Value(notes),
                    );
                    context.read<LoggingBloc>().add(UpdateMedicalLogEvent(updatedLog));
                  } else {
                    context.read<LoggingBloc>().add(
                      SaveMedicalLogEvent(
                        babyId: widget.babyId,
                        type: _type,
                        name: name,
                        dosage: dosage,
                        startTime: _startTime,
                        endTime: null,
                        reminderTime: reminderTime,
                        notes: notes,
                      ),
                    );
                  }
                  Navigator.pop(context);
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: Text(widget.existingLog != null ? 'Update Medical Log' : 'Save Medical Log', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                ),

              ),
            ),
          ],
        ),
      ),
    );
  }
}
