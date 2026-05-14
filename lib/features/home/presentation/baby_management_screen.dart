import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/theme/theme_cubit.dart';
import 'package:intl/intl.dart';
import '../cubit/baby_selection_cubit.dart';
import '../../../core/database/repositories/baby_repository.dart';
import '../../../core/theme/colors.dart';

class BabyManagementScreen extends StatelessWidget {
  const BabyManagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Manage Babies'),
        centerTitle: true,
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
      body: BlocBuilder<BabySelectionCubit, BabySelectionState>(
        builder: (context, state) {
          if (state.isLoading && state.babies.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state.error != null && state.babies.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, size: 48, color: Colors.red),
                  const SizedBox(height: 16),
                  Text('Error: ${state.error}'),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => context.read<BabySelectionCubit>().loadBabies(),
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }
          final babies = state.babies;
          if (babies.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.child_care, size: 64, color: Colors.grey),
                  const SizedBox(height: 16),
                  const Text('No babies added yet'),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => _showBabyForm(context),
                    child: const Text('Add Your First Baby'),
                  ),
                ],
              ),
            );
          }

          return Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 800),
              child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.all(16),
                      itemCount: babies.length,
                      itemBuilder: (context, index) {
                        final baby = babies[index];
                        final isSelected = state.selectedBabyId == baby.id;
                        return _BabyListItem(
                          baby: baby,
                          isSelected: isSelected,
                          onTap: () => context.read<BabySelectionCubit>().selectBaby(baby.id),
                          onEdit: () => _showBabyForm(context, baby: baby),
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(24),
                    child: ElevatedButton.icon(
                      onPressed: () => _showBabyForm(context),
                      icon: const Icon(Icons.add),
                      label: const Text('Add Another Baby'),
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size.fromHeight(56),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void _showBabyForm(BuildContext context, {BabyModel? baby}) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _BabyFormSheet(baby: baby),
    );
  }
}

class _BabyListItem extends StatelessWidget {
  const _BabyListItem({
    required this.baby,
    required this.isSelected,
    required this.onTap,
    required this.onEdit,
  });

  final BabyModel baby;
  final bool isSelected;
  final VoidCallback onTap;
  final VoidCallback onEdit;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: isSelected
            ? BorderSide(color: Theme.of(context).primaryColor, width: 2)
            : BorderSide.none,
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: _BabyAvatar(baby: baby, isSelected: isSelected),
        title: Text(
          baby.name,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        subtitle: Text(
          'Born ${DateFormat('MMM d, yyyy').format(baby.dateOfBirth)}',
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.edit_outlined),
              onPressed: onEdit,
            ),
            if (isSelected)
              const Icon(Icons.check_circle, color: Colors.green)
            else
              const Icon(Icons.circle_outlined, color: Colors.grey),
          ],
        ),
        onTap: onTap,
      ),
    );
  }
}

class _BabyAvatar extends StatelessWidget {
  const _BabyAvatar({required this.baby, required this.isSelected});

  final BabyModel baby;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    Color avatarColor;
    IconData avatarIcon;

    if (baby.gender?.toLowerCase() == 'boy') {
      avatarColor = AppColors.sleepBlue;
      avatarIcon = Icons.boy;
    } else if (baby.gender?.toLowerCase() == 'girl') {
      avatarColor = const Color(0xFFE91E99);
      avatarIcon = Icons.girl;
    } else {
      avatarColor = AppColors.growthTeal;
      avatarIcon = Icons.child_care;
    }

    return CircleAvatar(
      radius: 28,
      backgroundColor:
          isSelected ? avatarColor : avatarColor.withValues(alpha: 0.6),
      child: Icon(avatarIcon, size: 32, color: Colors.white),
    );
  }
}

// ── Form Sheet ────────────────────────────────────────────────────────────────

class _BabyFormSheet extends StatefulWidget {
  const _BabyFormSheet({this.baby});

  final BabyModel? baby;

  @override
  State<_BabyFormSheet> createState() => _BabyFormSheetState();
}

class _BabyFormSheetState extends State<_BabyFormSheet> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameController;
  DateTime? _selectedDob;
  String? _selectedGender;
  bool _isSaving = false;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.baby?.name ?? '');
    _selectedDob = widget.baby?.dateOfBirth;
    _selectedGender = widget.baby?.gender;
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.baby != null;
    return Padding(
      padding: EdgeInsets.fromLTRB(
          24, 24, 24, MediaQuery.of(context).viewInsets.bottom + 24),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        isEditing ? 'Edit Baby Profile' : 'Add New Baby',
                        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  if (_errorMessage != null)
                    Container(
                      margin: const EdgeInsets.only(bottom: 24),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.red.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.red.withValues(alpha: 0.5)),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.error_outline, color: Colors.red),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              _errorMessage!,
                              style: const TextStyle(color: Colors.red, fontSize: 13),
                            ),
                          ),
                        ],
                      ),
                    ),
                  TextFormField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      labelText: 'Baby\'s Name',
                      prefixIcon: const Icon(Icons.person_outline),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    validator: (value) =>
                        value == null || value.isEmpty ? 'Please enter a name' : null,
                  ),
                  const SizedBox(height: 16),
                  InkWell(
                    onTap: () async {
                      final now = DateTime.now();
                      final date = await showDatePicker(
                        context: context,
                        initialDate: _selectedDob ?? now,
                        firstDate: DateTime(now.year - 5),
                        lastDate: now,
                      );
                      if (date != null) {
                        setState(() => _selectedDob = date);
                      }
                    },
                    child: InputDecorator(
                      decoration: InputDecoration(
                        labelText: 'Date of Birth',
                        prefixIcon: const Icon(Icons.calendar_today_outlined),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        _selectedDob == null
                            ? 'Select Date'
                            : DateFormat('MMM d, yyyy').format(_selectedDob!),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  DropdownButtonFormField<String>(
                    initialValue: _selectedGender,
                    decoration: InputDecoration(
                      labelText: 'Gender',
                      prefixIcon: const Icon(Icons.wc_outlined),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    items: const [
                      DropdownMenuItem(value: 'Boy', child: Text('Boy')),
                      DropdownMenuItem(value: 'Girl', child: Text('Girl')),
                      DropdownMenuItem(value: 'Other', child: Text('Other')),
                    ],
                    onChanged: (val) => setState(() => _selectedGender = val),
                    validator: (val) => val == null ? 'Please select a gender' : null,
                  ),
                  const SizedBox(height: 32),
                  ElevatedButton(
                    onPressed: _isSaving ? null : _saveBaby,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: _isSaving
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : Text(isEditing ? 'Save Changes' : 'Add Baby'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _saveBaby() async {
    if (!_formKey.currentState!.validate() || _selectedDob == null) {
      String message = 'Please correct the errors in the form';
      if (_selectedDob == null) {
        message = 'Please select a date of birth';
      }
      setState(() => _errorMessage = message);
      return;
    }

    setState(() {
      _isSaving = true;
      _errorMessage = null;
    });

    try {
      final babyCubit = context.read<BabySelectionCubit>();
      if (widget.baby != null) {
        await babyCubit.updateBaby(
          widget.baby!.id,
          _nameController.text.trim(),
          _selectedDob!,
          _selectedGender,
        );
      } else {
        await babyCubit.addBaby(
          _nameController.text.trim(),
          _selectedDob!,
          _selectedGender,
        );
      }
      if (mounted) Navigator.pop(context);
    } catch (e) {
      if (mounted) {
        setState(() => _errorMessage = 'Error saving baby: $e');
      }
    } finally {
      if (mounted) setState(() => _isSaving = false);
    }
  }
}
