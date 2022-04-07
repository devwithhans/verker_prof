part of 'offer_bloc.dart';

abstract class OfferEvent extends Equatable {
  const OfferEvent();

  @override
  List<Object> get props => [];
}

class AddMaterialToBloc extends OfferEvent {
  VerkerMaterial verkerMaterial;
  AddMaterialToBloc({required this.verkerMaterial});
}

class TypeDescription extends OfferEvent {
  String text;
  TypeDescription(this.text);
}

class GoToStep extends OfferEvent {
  int step;

  GoToStep(this.step);
}

class DeleteMaterial extends OfferEvent {
  VerkerMaterial verkerMaterial;
  DeleteMaterial({required this.verkerMaterial});
}

class TypeHours extends OfferEvent {
  double? hours;
  double? hourlyRate;

  TypeHours({required this.hours, required this.hourlyRate});
}

class StartDate extends OfferEvent {
  DateTime date;
  StartDate(this.date);
}

class OfferExpires extends OfferEvent {
  DateTime date;
  OfferExpires(this.date);
}

class SaveOfferAsDraft extends OfferEvent {}
