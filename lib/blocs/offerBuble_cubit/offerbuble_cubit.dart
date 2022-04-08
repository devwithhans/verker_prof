import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:graphql/client.dart';
import 'package:verker_prof/models/offer.dart';
import 'package:verker_prof/services/graphql/GrapgQLService.dart';
import 'package:verker_prof/services/graphql/queries/offer.dart';

part 'offerbuble_state.dart';

class OfferbubleCubit extends Cubit<OfferbubleState> {
  OfferbubleCubit() : super(OfferbubleInitial());

  void getOfferById(String id) async {
    emit(OfferbubleLoading());
    QueryResult result = await GraphQLService()
        .performQuery(getOffer, variables: {"offerId": id});

    if (result.hasException) {
      print('Exception');

      emit(OfferbubleFailed());
    } else {
      try {
        Offer offer = Offer.convert(result.data!['getOffer']);
        print(offer);
        emit(OfferbubleSucces(offer));
      } catch (e) {
        emit(OfferbubleFailed());
      }
    }
  }
}
