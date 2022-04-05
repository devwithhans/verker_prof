part of 'offer_bloc.dart';

enum OfferStatus { initial, succes, loading, failed }

class OfferState extends Equatable {
  final int currentPage;
  final String offerDescription;
  final double? hours;
  final double? hourlyRate;
  final OfferStatus status;
  final List<VerkerMaterial> materials;
  final List<int> finishedSteps;
  final DateTime? startDate;
  final DateTime? offerExpires;

  const OfferState({
    this.offerExpires,
    this.materials = const [],
    this.status = OfferStatus.initial,
    this.currentPage = 0,
    this.hourlyRate,
    this.hours,
    this.startDate,
    this.offerDescription = '',
    this.finishedSteps = const [1],
  });

  OfferState copyWith({
    DateTime? offerExpires,
    DateTime? startDate,
    double? hours,
    double? hourlyRate,
    String? offerDescription,
    int? currentPage,
    OfferStatus? status,
    List<VerkerMaterial>? materials,
    List<int>? finishedSteps,
  }) {
    return OfferState(
      offerExpires: offerExpires ?? this.offerExpires,
      startDate: startDate ?? this.startDate,
      hourlyRate: hourlyRate ?? this.hourlyRate,
      hours: hours ?? this.hours,
      finishedSteps: finishedSteps ?? this.finishedSteps,
      offerDescription: offerDescription ?? this.offerDescription,
      materials: materials ?? this.materials,
      status: status ?? this.status,
      currentPage: currentPage ?? this.currentPage,
    );
  }

  @override
  List get props => [
        status,
        materials,
        offerDescription,
        finishedSteps,
        currentPage,
        hourlyRate,
        hours,
        startDate,
        offerExpires,
      ];
}
