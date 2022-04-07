import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:verker_prof/models/material.dart';

part 'offer_event.dart';
part 'offer_state.dart';

class OfferBloc extends Bloc<OfferEvent, OfferState> {
  OfferBloc() : super(const OfferState()) {
    on<AddMaterialToBloc>(_addMaterial);
    on<TypeDescription>(_typeDescription);
    on<GoToStep>(_goToStep);
    on<DeleteMaterial>(_deleteMaterial);
    on<TypeHours>(_typeHours);
    on<StartDate>(_startDate);
    on<OfferExpires>(_offerExpires);
    on<SaveOfferAsDraft>(_safeOfferAsDraft);
  }

  void _safeOfferAsDraft(SaveOfferAsDraft event, Emitter emit) async {
    emit(state.copyWith(status: OfferStatus.loading));
    await Future.delayed(Duration(milliseconds: 500));
    emit(state.copyWith(status: OfferStatus.succes));
  }

  void _offerExpires(OfferExpires event, Emitter emit) {
    emit(state.copyWith(
      offerExpires: event.date,
    ));
    emit(state.copyWith(
        finishedSteps: _validator(
            logic: state.offerExpires != null && state.startDate != null)));
  }

  void _startDate(StartDate event, Emitter emit) {
    emit(state.copyWith(startDate: event.date));
    emit(state.copyWith(
        finishedSteps: _validator(
            logic: state.offerExpires != null && state.startDate != null)));
  }

  void _typeHours(TypeHours event, Emitter emit) {
    emit(state.copyWith(hourlyRate: event.hourlyRate, hours: event.hours));

    emit(state.copyWith(
      finishedSteps:
          _validator(logic: state.hourlyRate != null && state.hours != null),
    ));
  }

  void _goToStep(GoToStep event, Emitter emit) {
    if (event.step != state.currentPage) {
      emit(state.copyWith(currentPage: event.step));
    }
  }

  void _typeDescription(TypeDescription event, Emitter emit) {
    emit(state.copyWith(
      offerDescription: event.text,
      finishedSteps: _validator(logic: event.text.isNotEmpty),
    ));
  }

  void _deleteMaterial(DeleteMaterial event, Emitter emit) {
    List<VerkerMaterial> material = [];
    material.addAll(state.materials);

    material.removeAt(state.materials.indexOf(event.verkerMaterial));

    emit(state.copyWith(materials: material));
  }

  void _addMaterial(AddMaterialToBloc event, Emitter emit) {
    List<VerkerMaterial> material = [];
    material.addAll(state.materials);

    material.add(event.verkerMaterial);

    emit(state.copyWith(materials: material));
  }

  List<int> _validator({
    required bool logic,
  }) {
    List<int> finishedSteps = [];
    finishedSteps.addAll(state.finishedSteps);
    if (logic) {
      !finishedSteps.contains(state.currentPage)
          ? finishedSteps.add(state.currentPage)
          : null;
    } else {
      finishedSteps.removeWhere((element) => element == state.currentPage);
    }
    return finishedSteps;
  }
}
