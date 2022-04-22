import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';
import 'package:verker_prof/blocs/offer_bloc/offer_bloc.dart';
import 'package:verker_prof/theme/components/verker_date_picker.dart';
import 'package:verker_prof/theme/components/verker_formfield.dart';

class Preferences extends StatelessWidget {
  const Preferences({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      child: BlocBuilder<OfferBloc, OfferState>(
        builder: (context, state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Angiv vigtige informationer',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              VerkerDatePicker(
                title: 'Mulig opstart',
                hintText: 'Vælg dato',
                value: state.startDate,
                onSelect: (v) {
                  BlocProvider.of<OfferBloc>(context).add(StartDate(v));
                },
              ),
              VerkerDatePicker(
                title: 'Tilbuddet udløber',
                hintText: 'Vælg dato',
                value: state.offerExpires,
                onSelect: (v) {
                  BlocProvider.of<OfferBloc>(context).add(OfferExpires(v));
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
