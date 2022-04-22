import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:verker_prof/blocs/offer_bloc/offer_bloc.dart';
import 'package:verker_prof/models/material.dart';
import 'package:verker_prof/theme/components/verker_formfield.dart';
import 'package:verker_prof/widgets/buttons.dart';

class AddMaterial extends StatelessWidget {
  const AddMaterial({Key? key, this.verkerMaterial}) : super(key: key);

  final VerkerMaterial? verkerMaterial;

  @override
  Widget build(BuildContext context) {
    bool edit = verkerMaterial != null;
    String _name = edit ? verkerMaterial!.name : '';
    double? _quantity = edit ? verkerMaterial!.quantity : null;
    double? _price = edit ? verkerMaterial!.price : null;

    final _formKey = GlobalKey<FormState>();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 2,
        titleSpacing: 5,
        title: Text(
          'Tilføj materialer',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
          children: [
            VerkerFormField(
              initialValue: _name,
              onChanged: (v) {
                _name = v;
              },
              validator: (v) {
                if (_name.isEmpty) {
                  return 'Dette felt mangler';
                }
              },
              title: 'Materiale navn',
              hintText: 'F.eks. Mursten',
            ),
            VerkerFormField(
              initialValue: _price == null ? null : _price.toString(),
              onChanged: (v) {
                final double price = double.tryParse(
                      v.replaceAll(",", '.'),
                    ) ??
                    0.0;

                _price = price;
              },
              price: true,
              validator: (v) {
                if (v!.isEmpty) {
                  return 'Angiv en pris';
                }
              },
              title: 'Styk pris',
              hintText: 'F.eks. 299.95',
            ),
            VerkerFormField(
              initialValue: _quantity == null ? null : _quantity.toString(),
              onChanged: (v) {
                final double qt = double.tryParse(
                      v.replaceAll(",", '.'),
                    ) ??
                    0.0;

                _quantity = qt;
              },
              number: true,
              validator: (v) {
                if (v!.isEmpty) {
                  return 'Angiv antal';
                }
              },
              title: 'Antal',
              hintText: 'F.eks. 200',
            ),
            NavigationButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  if (verkerMaterial != null) {
                    context
                        .read<OfferBloc>()
                        .add(DeleteMaterial(verkerMaterial: verkerMaterial!));
                  }

                  context.read<OfferBloc>().add(
                        AddMaterialToBloc(
                          verkerMaterial: VerkerMaterial(
                            name: _name,
                            price: _price!,
                            quantity: _quantity!,
                          ),
                        ),
                      );
                  Navigator.pop(context);
                }
              },
              text: 'Tilføj',
              textColor: Colors.white,
              backgroundColor: Colors.black,
            )
          ],
        ),
      ),
    );
  }
}
