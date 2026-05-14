import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/database/repositories/baby_repository.dart';

class BabySelectionCubit extends Cubit<BabySelectionState> {
  BabySelectionCubit(this.babyRepository) : super(const BabySelectionState());

  final BabyRepository babyRepository;

  Future<void> loadBabies() async {
    emit(state.copyWith(isLoading: true));
    try {
      final babies = await babyRepository.getAllBabies();
      if (babies.isEmpty) {
        emit(state.copyWith(babies: [], selectedBabyId: null, isLoading: false));
      } else {
        final currentId = state.selectedBabyId;
        final stillExists = babies.any((b) => b.id == currentId);
        final selectedId = stillExists ? currentId : babies.first.id;
        emit(state.copyWith(babies: babies, selectedBabyId: selectedId, isLoading: false));
      }
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }

  void selectBaby(int babyId) {
    emit(state.copyWith(selectedBabyId: babyId));
  }

  Future<void> addBaby(String name, DateTime dateOfBirth, String? gender) async {
    await babyRepository.addBaby(name, dateOfBirth, gender);
    await loadBabies();
  }

  Future<void> updateBaby(int id, String name, DateTime dateOfBirth, String? gender) async {
    await babyRepository.updateBaby(id, name, dateOfBirth, gender);
    await loadBabies();
  }

  Future<void> deleteBaby(int id) async {
    await babyRepository.deleteBaby(id);
    await loadBabies();
  }
}

class BabySelectionState {
  const BabySelectionState({
    this.babies = const [],
    this.selectedBabyId,
    this.isLoading = true,
    this.error,
  });

  final List<BabyModel> babies;
  final int? selectedBabyId;
  final bool isLoading;
  final String? error;

  BabyModel? get selectedBaby =>
      babies.where((b) => b.id == selectedBabyId).firstOrNull;

  BabySelectionState copyWith({
    List<BabyModel>? babies,
    int? selectedBabyId,
    bool? isLoading,
    String? error,
  }) {
    return BabySelectionState(
      babies: babies ?? this.babies,
      selectedBabyId: selectedBabyId ?? this.selectedBabyId,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}
