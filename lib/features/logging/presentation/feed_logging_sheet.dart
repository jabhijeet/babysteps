import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:drift/drift.dart' show Value;
import '../../../core/database/app_database.dart';
import '../../../core/theme/colors.dart';
import '../bloc/logging_bloc.dart';

class FeedLoggingSheet extends StatefulWidget {
  const FeedLoggingSheet({super.key, required this.babyId, this.existingLog});

  final int babyId;
  final FeedingLog? existingLog;

  @override
  State<FeedLoggingSheet> createState() => _FeedLoggingSheetState();
}

class _FeedLoggingSheetState extends State<FeedLoggingSheet> {
  String _feedType = 'Breast';
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _brandController = TextEditingController();
  final TextEditingController _foodTypeController = TextEditingController();
  final TextEditingController _tempController = TextEditingController();
  String _reaction = 'Neutral';
  String _volumeUnit = 'ml';
  String _breastSide = 'Both';

  XFile? _reactionPhoto;
  final ImagePicker _picker = ImagePicker();

  DateTime _startTime = DateTime.now().subtract(const Duration(minutes: 15));
  DateTime _endTime = DateTime.now();

  @override
  void initState() {
    super.initState();
    if (widget.existingLog != null) {
      final log = widget.existingLog!;
      _feedType = log.type[0].toUpperCase() + log.type.substring(1);
      _startTime = log.startTime;
      _endTime = log.endTime ?? DateTime.now();
      _amountController.text = log.volumeAmount?.toString() ?? '';
      _brandController.text = log.formulaBrand ?? '';
      _tempController.text = log.formulaTemp?.toString() ?? '';
      _reaction = log.solidFoodReaction ?? 'Neutral';
      _volumeUnit = log.volumeUnit ?? 'ml';
      _breastSide = log.breastSide ?? 'Both';
      if (log.notes != null && log.notes!.startsWith('Food: ')) {
        _foodTypeController.text = log.notes!.replaceFirst('Food: ', '');
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
          _endTime = _startTime.add(const Duration(minutes: 15));
        }
      } else {
        _endTime = finalDateTime;
      }
    });
  }

  @override
  void dispose() {
    _amountController.dispose();
    _brandController.dispose();
    _foodTypeController.dispose();
    _tempController.dispose();
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
            Text('Log Feeding', style: Theme.of(context).textTheme.displaySmall?.copyWith(fontSize: 24, color: Theme.of(context).colorScheme.onSurface), textAlign: TextAlign.center),
            const SizedBox(height: 24),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: SegmentedButton<String>(
                segments: [
                  ButtonSegment(
                    value: 'Breast', 
                    label: const Text('Breast', style: TextStyle(fontSize: 12)), 
                    icon: Icon(Icons.favorite, size: 16, color: _feedType == 'Breast' ? AppColors.accentBreast : null)
                  ),
                  ButtonSegment(
                    value: 'Formula', 
                    label: const Text('Formula', style: TextStyle(fontSize: 12)), 
                    icon: Icon(Icons.medication, size: 16, color: _feedType == 'Formula' ? AppColors.accentFormula : null)
                  ),
                  ButtonSegment(
                    value: 'Expressed', 
                    label: const Text('Expressed', style: TextStyle(fontSize: 12)), 
                    icon: Icon(Icons.water_drop, size: 16, color: _feedType == 'Expressed' ? AppColors.accentExpressed : null)
                  ),
                  ButtonSegment(
                    value: 'Pumping', 
                    label: const Text('Pumping', style: TextStyle(fontSize: 12)), 
                    icon: Icon(Icons.local_drink, size: 16, color: _feedType == 'Pumping' ? AppColors.accentPumping : null)
                  ),
                  ButtonSegment(
                    value: 'Solid', 
                    label: const Text('Solid', style: TextStyle(fontSize: 12)), 
                    icon: Icon(Icons.restaurant, size: 16, color: _feedType == 'Solid' ? AppColors.accentSolid : null)
                  ),
                ],
                selected: {_feedType},
                onSelectionChanged: (Set<String> newSelection) {
                  setState(() {
                    _feedType = newSelection.first;
                  });
                },
              ),
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
            const SizedBox(height: 24),
            
            if (_feedType == 'Breast') ...[
              _buildBreastfeedingInputs(),
              const SizedBox(height: 16),
              _buildVolumeInput(),
            ],
            if (_feedType == 'Formula' || _feedType == 'Expressed' || _feedType == 'Pumping') _buildVolumeInput(),
            if (_feedType == 'Solid') _buildSolidFoodInput(),
            const SizedBox(height: 32),
            Container(
              decoration: BoxDecoration(
                gradient: AppColors.getFeedingGradient(_feedType),
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.getFeedingColor(_feedType).withValues(alpha: 0.3), 
                    blurRadius: 12, 
                    offset: const Offset(0, 4)
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
                  final double? amount = double.tryParse(_amountController.text);
                  final double? temp = double.tryParse(_tempController.text);
                  final String? brand = _feedType == 'Formula' && _brandController.text.isNotEmpty ? _brandController.text : null;
                  final String? reaction = _feedType == 'Solid' ? _reaction : null;
                  final String? foodType = _foodTypeController.text.isNotEmpty ? _foodTypeController.text : null;
                  final String notes = foodType != null ? 'Food: $foodType' : '';

                  String? breastSide;
                  if (_feedType == 'Breast') {
                    breastSide = _breastSide;
                  }

                  if (widget.existingLog != null) {
                    final updatedLog = widget.existingLog!.copyWith(
                      type: _feedType.toLowerCase(),
                      startTime: _startTime,
                      endTime: Value(_endTime),
                      volumeAmount: Value(amount),
                      volumeUnit: Value(amount != null ? _volumeUnit : null),
                      breastSide: Value(breastSide),
                      formulaBrand: Value(brand),
                      formulaTemp: Value(temp),
                      solidFoodReaction: Value(reaction),
                      solidFoodReactionPhotoPath: Value(_reactionPhoto?.path ?? widget.existingLog!.solidFoodReactionPhotoPath),
                      notes: Value(notes.isNotEmpty ? notes : null),
                    );
                    context.read<LoggingBloc>().add(UpdateFeedLogEvent(updatedLog));
                  } else {
                    context.read<LoggingBloc>().add(
                      SaveFeedLogEvent(
                        babyId: widget.babyId,
                        type: _feedType.toLowerCase(),
                        startTime: _startTime,
                        endTime: _endTime,
                        volumeAmount: amount,
                        volumeUnit: amount != null ? _volumeUnit : null,
                        breastSide: breastSide,
                        formulaBrand: brand,
                        formulaTemp: temp,
                        solidFoodReaction: reaction,
                        solidFoodReactionPhotoPath: _reactionPhoto?.path,
                        notes: notes.isNotEmpty ? notes : null,
                      ),
                    );
                  }
                  Navigator.pop(context);
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: Text(widget.existingLog != null ? 'Update Feeding Log' : 'Save Feeding Log', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                ),

              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBreastfeedingInputs() {
    return Column(
      children: [
        DropdownButtonFormField<String>(
          initialValue: _breastSide,
          decoration: InputDecoration(
            labelText: 'Breast Side',
            prefixIcon: const Icon(Icons.favorite_border),
            filled: true,
            fillColor: Colors.grey.withValues(alpha: 0.05),
          ),
          items: ['Left', 'Right', 'Both'].map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          onChanged: (String? val) {
            if (val != null) setState(() => _breastSide = val);
          },
        ),
      ],
    );
  }

  Widget _buildVolumeInput() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: _amountController,
                decoration: InputDecoration(
                  labelText: 'Amount',
                  prefixIcon: const Icon(Icons.opacity),
                  filled: true,
                  fillColor: Colors.grey.withValues(alpha: 0.05),
                ),
                keyboardType: TextInputType.number,
              ),
            ),
            const SizedBox(width: 16),
            ToggleButtons(
              constraints: const BoxConstraints(minWidth: 50, minHeight: 48),
              borderRadius: BorderRadius.circular(12),
              isSelected: [_volumeUnit == 'ml', _volumeUnit == 'oz'],
              onPressed: (index) {
                setState(() {
                  _volumeUnit = index == 0 ? 'ml' : 'oz';
                });
              },
              children: const [Text('ml'), Text('oz')],
            ),
          ],
        ),
        const SizedBox(height: 16),
        if (_feedType == 'Formula') ...[
          TextField(
            controller: _brandController,
            decoration: InputDecoration(
              labelText: 'Formula Brand (Optional)',
              prefixIcon: const Icon(Icons.branding_watermark),
              filled: true,
              fillColor: Colors.grey.withValues(alpha: 0.05),
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _tempController,
            decoration: InputDecoration(
              labelText: 'Temperature (e.g., 37.0)',
              prefixIcon: const Icon(Icons.thermostat),
              filled: true,
              fillColor: Colors.grey.withValues(alpha: 0.05),
            ),
            keyboardType: TextInputType.number,
          ),
        ],
      ],
    );
  }

  Widget _buildSolidFoodInput() {
    return Column(
      children: [
        TextField(
          controller: _foodTypeController,
          decoration: InputDecoration(
            labelText: 'Food Type (e.g., Puree, Apple)',
            prefixIcon: const Icon(Icons.restaurant_menu),
            filled: true,
            fillColor: Colors.grey.withValues(alpha: 0.05),
          ),
        ),
        const SizedBox(height: 16),
        DropdownButtonFormField<String>(
          initialValue: _reaction,
          decoration: InputDecoration(
            labelText: 'Baby\'s Reaction',
            prefixIcon: const Icon(Icons.face),
            filled: true,
            fillColor: Colors.grey.withValues(alpha: 0.05),
          ),
          items: ['Neutral', 'Dislike', 'Allergy'].map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          onChanged: (String? val) {
            if (val != null) setState(() => _reaction = val);
          },
        ),
        const SizedBox(height: 16),
        OutlinedButton.icon(
          onPressed: () async {
            final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
            if (image != null) {
              setState(() {
                _reactionPhoto = image;
              });
            }
          },
          icon: const Icon(Icons.camera_alt),
          label: const Text('Add Reaction Photo'),
        ),
        if (_reactionPhoto != null) ...[
          const SizedBox(height: 16),
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: kIsWeb 
                ? Image.network(_reactionPhoto!.path, height: 100, width: 100, fit: BoxFit.cover)
                : Image.network(_reactionPhoto!.path, height: 100, width: 100, fit: BoxFit.cover),
          ),
        ],
      ],
    );
  }
}
