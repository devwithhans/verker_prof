import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:verker_prof/blocs/offer_bloc/offer_bloc.dart';
import 'package:verker_prof/models/material.dart';
import 'package:verker_prof/screens/make_offer_screen/materials/components/new_material.dart';

class MaterialCard extends StatelessWidget {
  const MaterialCard({
    Key? key,
    required this.e,
  }) : super(key: key);

  final VerkerMaterial e;

  @override
  Widget build(BuildContext context) {
    var quantity = NumberFormat("###.##", "de_DK");
    var currency = NumberFormat.currency(
        locale: "de_DK", symbol: "kr.", customPattern: '###,###.00 kr');
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) => BlocProvider.value(
                    value: BlocProvider.of<OfferBloc>(context),
                    child: AddMaterial(
                      verkerMaterial: e,
                    ))));
      },
      child: Container(
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(10)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 5), // changes position of shadow
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  e.name,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                Text(
                  'Styk pris: ' + currency.format(e.price),
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 6),
                Text(
                  'Antal: ' + quantity.format(e.quantity),
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 6),
                Text(
                  'Total pris: ' + currency.format(e.quantity * e.price),
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    context
                        .read<OfferBloc>()
                        .add(DeleteMaterial(verkerMaterial: e));
                  },
                  child: Icon(
                    Icons.delete,
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
