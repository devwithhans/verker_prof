import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:slide_to_confirm/slide_to_confirm.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';
import 'package:verker_prof/blocs/offer_bloc/offer_bloc.dart';
import 'package:verker_prof/models/project.dart';
import 'package:verker_prof/screens/make_offer_screen/materials/components/formats.dart';
import 'package:verker_prof/screens/make_offer_screen/swipe_to_confirm.dart';

class Preview extends StatelessWidget {
  final ProjectModel project;
  const Preview({Key? key, required this.project}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OfferBloc, OfferState>(
      builder: (context, state) {
        double price = state.materials
            .fold(0, (sum, item) => sum + (item.price + item.quantity));
        double hourPrice = state.hourlyRate! * state.hours!;
        return ListView(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
          children: [
            Text(
              'Tjek dit tilbud til ${project.title!}',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            titleBodyPair('Din tilbudsbeskrivelse: ', state.offerDescription),
            titleBodyPair(
                'Mulig opstart: ', Jiffy(state.startDate).format('dd-MM-yyyy')),
            titleBodyPair('Tilbuddet gælder til: ',
                Jiffy(state.offerExpires).format('dd-MM-yyyy')),
            titleBodyPair(
                'Total materialepris: ',
                price == 0
                    ? 'Ingen materialer'
                    : kFormatCurrency.format(price)),
            titleBodyPair(
                'Total timepris: ', kFormatCurrency.format(hourPrice)),
          ],
        );
      },
    );
  }

  Column titleBodyPair(String title, String body) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        ),
        Text(
          body,
          style: TextStyle(fontSize: 20),
        ),
        SizedBox(height: 20)
      ],
    );
  }
}
