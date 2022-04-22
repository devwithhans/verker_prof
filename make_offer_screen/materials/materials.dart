import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:verker_prof/blocs/offer_bloc/offer_bloc.dart';
import 'package:verker_prof/screens/make_offer_screen/materials/components/material_card.dart';
import 'package:verker_prof/screens/make_offer_screen/materials/components/new_material.dart';

class NewMaterial extends StatelessWidget {
  NewMaterial({
    Key? key,
  }) : super(key: key);

  final _formKey = GlobalKey<FormState>();

  String name = '';
  late int quantity;
  late double price;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      children: [
        const Text(
          'Materialeliste:',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 20),
        BlocBuilder<OfferBloc, OfferState>(builder: ((context, state) {
          return Column(
            children: state.materials
                .map((e) => MaterialCard(e: e))
                .toList(growable: true),
          );
        })),
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => BlocProvider.value(
                  value: BlocProvider.of<OfferBloc>(context),
                  child: AddMaterial(),
                ),
              ),
            );
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(5)),
              border: Border.all(),
            ),
            child: Row(
              children: const [
                Icon(
                  Icons.add_circle_outline_rounded,
                  size: 25,
                ),
                SizedBox(width: 10),
                Text(
                  'Tilføj materiale',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
