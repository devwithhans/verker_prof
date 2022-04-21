part of 'query_cubit.dart';

abstract class QueryState extends Equatable {
  const QueryState();

  @override
  List<Object> get props => [];
}

class QueryLoadedOffer extends QueryState {
  Offer offer;
  QueryLoadedOffer(this.offer);
}

class QueryLoading extends QueryState {}

class QueryInitial extends QueryState {}

class QueryFailed extends QueryState {}
