import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pond_care/src/core/dependency_injection.dart';
import 'package:pond_care/src/feature/pond/models/decoration.dart';
import 'package:pond_care/src/feature/pond/models/fish.dart';
import 'package:pond_care/src/feature/pond/models/plant.dart';
import 'package:pond_care/src/feature/pond/models/pond.dart';
import 'package:pond_care/src/feature/pond/repository/repository.dart';

part 'pond_event.dart';
part 'pond_state.dart';

class PondBloc extends Bloc<PondEvent, PondState> {
  final PondRepository _repository = locator<PondRepository>();

  PondBloc() : super(PondInitial()) {
    on<LoadPond>(_onLoadPonds);
    on<UpdatePond>(_onUpdatePond);
    on<SavePond>(_onSavePond);
    on<RemovePond>(_onRemovePond);
  }

  Future<void> _onLoadPonds(
    LoadPond event,
    Emitter<PondState> emit,
  ) async {
    emit(PondLoading());
    try {
      final pond = await _repository.load();
      final fish = await _repository.loadFish();
      final plants = await _repository.loadPlants();
      final decorations = await _repository.loadDecorations();
      emit(PondLoaded(pond, fish, plants, decorations));
    } catch (e) {
      emit(const PondError('Failed to load pond'));
    }
  }

  Future<void> _onUpdatePond(
    UpdatePond event,
    Emitter<PondState> emit,
  ) async {
    try {
      await _repository.update(event.pond);
      add(LoadPond());
    } catch (e) {
      emit(const PondError('Failed to update pond'));
    }
  }

  Future<void> _onSavePond(
    SavePond event,
    Emitter<PondState> emit,
  ) async {
    try {
      await _repository.save(event.pond);
      add(LoadPond());
    } catch (e) {
      emit(const PondError('Failed to save pond'));
    }
  }

  Future<void> _onRemovePond(
    RemovePond event,
    Emitter<PondState> emit,
  ) async {
    try {
      await _repository.remove(event.pond);
      add(LoadPond());
    } catch (e) {
      emit(const PondError('Failed to remove transaction'));
    }
  }
}
