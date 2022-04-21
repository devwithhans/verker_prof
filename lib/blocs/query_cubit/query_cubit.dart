import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:graphql/client.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';
import 'package:verker_prof/models/offer.dart';
import 'package:verker_prof/services/graphql/GrapgQLService.dart';
import 'package:verker_prof/services/graphql/queries/offer.dart';

part 'query_state.dart';

class QueryCubit extends Cubit<QueryState> {
  QueryCubit() : super(QueryInitial());

  void getOfferById(String id) async {
    emit(QueryLoading());

    QueryResult result = await GraphQLService()
        .performQuery(getOffer, variables: {"offerId": id});

    if (result.hasException) {
      print('Exception');
      emit(QueryFailed());
    } else {
      try {
        Offer offer = Offer.convert(result.data!['getOffer']);
        emit(QueryLoadedOffer(offer));
      } catch (e) {
        emit(QueryFailed());
      }
    }
  }
}
