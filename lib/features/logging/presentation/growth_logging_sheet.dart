import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:drift/drift.dart' show Value;
import '../../../core/database/app_database.dart';
import '../../../core/theme/colors.dart';
import '../../../core/constants/app_constants.dart';
import '../bloc/logging_bloc.dart';

class GrowthLoggingSheet extends StatefulWidget {
  const GrowthLoggingSheet({super.key, required this.babyId, this.existingLog});

  final int babyId;
  final GrowthLog? existingLog;

  @override
  State<GrowthLoggingSheet> createState() => _GrowthLoggingSheetState();
}

class _GrowthLoggingSheetState extends State<GrowthLoggingSheet> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _headCircumferenceController = TextEditingController();
  String _weightUnit = 'kg';
  String _lengthUnit = 'cm';

  DateTime _startTime = DateTime.now();
  DateTime _endTime = DateTime.now();


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
  void initState() {
    super.initState();
    _loadSavedUnits().then((_) {
      if (widget.existingLog != null) {
        final log = widget.existingLog!;
        _startTime = log.startTime;
        _endTime = log.endTime ?? DateTime.now();
        
        double? w = log.weight;
        if (w != null && _weightUnit == StringLiterals.unitPounds) w = w / ConversionFactors.poundsToKilograms;
        _weightController.text = w?.toStringAsFixed(2) ?? '';

        double? h = log.height;
        if (h != null && _lengthUnit == StringLiterals.unitInches) h = h / ConversionFactors.inchesToCentimeters;
        _heightController.text = h?.toStringAsFixed(2) ?? '';

        double? hc = log.headCircumference;
        if (hc != null && _lengthUnit == StringLiterals.unitInches) hc = hc / ConversionFactors.inchesToCentimeters;
        _headCircumferenceController.text = hc?.toStringAsFixed(2) ?? '';
      }
    });
  }


  Future<void> _loadSavedUnits() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _weightUnit = prefs.getString('growth_weight_unit') ?? StringLiterals.unitKilograms;
      _lengthUnit = prefs.getString('growth_length_unit') ?? StringLiterals.unitCentimeters;
    });
  }

  @override
  void dispose() {
    _weightController.dispose();
    _heightController.dispose();
    _headCircumferenceController.dispose();
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
        child: Form(
          key: _formKey,
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
                  Text('Growth Metrics', style: Theme.of(context).textTheme.displaySmall?.copyWith(fontSize: 24, color: Theme.of(context).colorScheme.onSurface)),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.pop(context),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                ],
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
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _weightController,
                      decoration: InputDecoration(
                        labelText: 'Weight',
                        suffixText: _weightUnit,
                        prefixIcon: const Icon(Icons.monitor_weight),
                        filled: true,
                        fillColor: Colors.grey.withValues(alpha: 0.05),
                      ),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return null; // Allow empty (optional field)
                        }
                        final parsed = double.tryParse(value);
                        if (parsed == null) {
                          return 'Please enter a valid number';
                        }
                        if (parsed <= 0) {
                          return 'Weight must be positive';
                        }
                        if (_weightUnit == StringLiterals.unitKilograms && parsed > ValidationLimits.maxWeightKg) {
                          return 'Weight seems unusually high for a baby';
                        }
                        if (_weightUnit == StringLiterals.unitPounds && parsed > ValidationLimits.maxWeightLbs) {
                          return 'Weight seems unusually high for a baby';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(width: 12),
                  SegmentedButton<String>(
                    segments: const [
                      ButtonSegment(value: 'kg', label: Text('kg')),
                      ButtonSegment(value: 'lbs', label: Text('lbs')),
                    ],
                    selected: {_weightUnit},
                    onSelectionChanged: (Set<String> newSelection) async {
                      final unit = newSelection.first;
                      final prefs = await SharedPreferences.getInstance();
                      await prefs.setString('growth_weight_unit', unit);
                      setState(() {
                        _weightUnit = unit;
                      });
                      // Trigger re-validation to update error messages with new unit
                      _formKey.currentState?.validate();
                    },
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _heightController,
                      decoration: InputDecoration(
                        labelText: 'Height',
                        suffixText: _lengthUnit,
                        prefixIcon: const Icon(Icons.straighten),
                        filled: true,
                        fillColor: Colors.grey.withValues(alpha: 0.05),
                      ),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return null; // Allow empty (optional field)
                        }
                        final parsed = double.tryParse(value);
                        if (parsed == null) {
                          return 'Please enter a valid number';
                        }
                        if (parsed <= 0) {
                          return 'Height must be positive';
                        }
                        if (_lengthUnit == StringLiterals.unitCentimeters && parsed > ValidationLimits.maxHeightCm) {
                          return 'Height seems unusually high for a baby';
                        }
                        if (_lengthUnit == StringLiterals.unitInches && parsed > ValidationLimits.maxHeightIn) {
                          return 'Height seems unusually high for a baby';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(width: 12),
                  SegmentedButton<String>(
                    segments: const [
                      ButtonSegment(value: 'cm', label: Text('cm')),
                      ButtonSegment(value: 'in', label: Text('in')),
                    ],
                    selected: {_lengthUnit},
                    onSelectionChanged: (Set<String> newSelection) async {
                      final unit = newSelection.first;
                      final prefs = await SharedPreferences.getInstance();
                      await prefs.setString('growth_length_unit', unit);
                      setState(() {
                        _lengthUnit = unit;
                      });
                      // Trigger re-validation to update error messages with new unit
                      _formKey.currentState?.validate();
                    },
                  ),
                ],
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _headCircumferenceController,
                decoration: InputDecoration(
                  labelText: 'Head Circumference',
                  suffixText: _lengthUnit,
                  prefixIcon: const Icon(Icons.face),
                  filled: true,
                  fillColor: Colors.grey.withValues(alpha: 0.05),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return null; // Allow empty (optional field)
                  }
                  final parsed = double.tryParse(value);
                  if (parsed == null) {
                    return 'Please enter a valid number';
                  }
                  if (parsed <= 0) {
                    return 'Head circumference must be positive';
                  }
                  if (_lengthUnit == StringLiterals.unitCentimeters && parsed > ValidationLimits.maxHeadCircumferenceCm) {
                    return 'Head circumference seems unusually large';
                  }
                  if (_lengthUnit == StringLiterals.unitInches && parsed > ValidationLimits.maxHeadCircumferenceIn) {
                    return 'Head circumference seems unusually large';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 32),
              Container(
                decoration: BoxDecoration(
                  gradient: AppColors.accentGradient,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(color: AppColors.accentPrimary.withValues(alpha: 0.3), blurRadius: 12, offset: const Offset(0, 4)),
                  ],
                ),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    foregroundColor: AppColors.textLightPrimary,
                  ),
                  onPressed: () {
                    if (!_formKey.currentState!.validate()) {
                      return;
                    }
                    double? weight = double.tryParse(_weightController.text);
                    double? height = double.tryParse(_heightController.text);
                    double? headCircumference = double.tryParse(_headCircumferenceController.text);

                    if (weight != null && _weightUnit == StringLiterals.unitPounds) {
                      weight = weight * ConversionFactors.poundsToKilograms;
                    }
                    if (height != null && _lengthUnit == StringLiterals.unitInches) {
                      height = height * ConversionFactors.inchesToCentimeters;
                    }
                    if (headCircumference != null && _lengthUnit == StringLiterals.unitInches) {
                      headCircumference = headCircumference * ConversionFactors.inchesToCentimeters;
                    }

                    if (widget.existingLog != null) {
                      final updatedLog = widget.existingLog!.copyWith(
                        startTime: _startTime,
                        endTime: Value(_endTime),
                        weight: Value(weight),
                        height: Value(height),
                        headCircumference: Value(headCircumference),
                      );
                      context.read<LoggingBloc>().add(UpdateGrowthLogEvent(updatedLog));
                    } else {
                      context.read<LoggingBloc>().add(
                        SaveGrowthLogEvent(
                          babyId: widget.babyId,
                          startTime: _startTime,
                          endTime: null,
                          weight: weight,
                          height: height,
                          headCircumference: headCircumference,
                        ),
                      );
                    }
                    Navigator.pop(context);
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: Text(widget.existingLog != null ? 'Update Metrics' : 'Save Metrics', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  ),

                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
