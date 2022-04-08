part of 'offerbuble_cubit.dart';

enum OfferBubleStatus { loading, succes, failed }

abstract class OfferbubleState extends Equatable {
  const OfferbubleState();

  @override
  List<Object> get props => [];
}

class OfferbubleInitial extends OfferbubleState {}

class OfferbubleLoading extends OfferbubleState {}

class OfferbubleSucces extends OfferbubleState {
  final Offer offer;
  OfferbubleSucces(this.offer);
}

class OfferbubleFailed extends OfferbubleState {}
