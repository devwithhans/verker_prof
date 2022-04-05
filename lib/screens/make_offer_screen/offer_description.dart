import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:verker_prof/blocs/offer_bloc/offer_bloc.dart';
import 'package:verker_prof/theme/components/verker_formfield.dart';

class OfferDesciption extends StatelessWidget {
  const OfferDesciption({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OfferBloc, OfferState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Lav et udførligt tilbud til kunden',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              VerkerFormField(
                multiline: true,
                initialValue: state.offerDescription,
                onChanged: (v) {
                  context.read<OfferBloc>().add(TypeDescription(v));
                },
                validator: (v) {},
                hintText:
                    'Forklar udførligt hvad dit tilbud indeholder, og eventuelt hvad det ikke indeholder',
              ),
            ],
          ),
        );
      },
    );
  }
}
