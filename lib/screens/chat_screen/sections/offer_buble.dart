import 'package:flutter/material.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';
import 'package:verker_prof/models/material.dart';
import 'package:verker_prof/screens/make_offer_screen/materials/components/formats.dart';
import 'package:verker_prof/theme/constants/textstyle.dart';

class OfferBuble extends StatelessWidget {
  const OfferBuble({
    required this.message,
    Key? key,
  }) : super(key: key);

  final Message message;

  @override
  Widget build(BuildContext context) {
    return Text("fuck");
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
          style: TextStyle(fontSize: 16),
        ),
        SizedBox(height: 20)
      ],
    );
  }
}

class MaterialTile extends StatelessWidget {
  const MaterialTile({
    required this.material,
    Key? key,
  }) : super(key: key);

  final VerkerMaterial material;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.all(Radius.circular(5)),
      ),
      child: Row(
        children: [
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 4,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        material.name,
                        style: kTextSmallBold,
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Enheder: ${kFormatQuantity.format(material.quantity)}",
                    ),
                    Text(
                      "Pris: ${kFormatCurrency.format(material.price * material.quantity)}",
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


// Padding(
//       padding: EdgeInsets.fromLTRB(10, 2, 10, 2),
//       child: Container(
//         decoration: BoxDecoration(
//           color: Colors.white,
//           boxShadow: [
//             BoxShadow(
//               color: Colors.grey.withOpacity(0.5),
//               spreadRadius: 3,
//               blurRadius: 5,
//               offset: Offset(0, 3), // changes position of shadow
//             ),
//           ],
//           borderRadius: BorderRadius.all(Radius.circular(15)),
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             Container(
//               padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
//               decoration: BoxDecoration(
//                 color: Colors.greenAccent,
//                 borderRadius: const BorderRadius.only(
//                     topLeft: Radius.circular(15),
//                     topRight: Radius.circular(15)),
//               ),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   const Text(
//                     'Her er dit tilbud',
//                     style: TextStyle(
//                         fontWeight: FontWeight.bold,
//                         fontSize: 20,
//                         color: Colors.white),
//                   ),
//                   // Text(
//                   //   'Sendt: ${Jiffy(offer.offerSent).format('dd-MM-yyyy')}',
//                   //   style: TextStyle(fontSize: 15, color: Colors.white),
//                   // ),
//                 ],
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.fromLTRB(15, 15, 15, 15),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   titleBodyPair('Beskrivelse: ',
//                       "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd"),
//                   // titleBodyPair('Mulig opstart: ',
//                   //     Jiffy(offer.startDate!).format('dd-MM-yyyy')),
//                   Text(
//                     'Pris:',
//                     style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
//                   ),
//                   Row(
//                     children: [
//                       Text(
//                         'Beskrivelse',
//                         style: TextStyle(fontWeight: FontWeight.bold),
//                       ),
//                       SizedBox(width: 30),
//                       Text(
//                         'Pris',
//                         style: TextStyle(fontWeight: FontWeight.bold),
//                       ),
//                     ],
//                   )
//                   // Text(
//                   //   'Materialer:',
//                   //   style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
//                   // ),
//                   // SizedBox(height: 5),
//                   // Column(
//                   //   children: offer.materials
//                   //       .map(
//                   //         (e) => MaterialTile(
//                   //           material: e,
//                   //         ),
//                   //       )
//                   //       .toList(),
//                   // ),
//                 ],
//               ),
//             )
//           ],
//         ),
//       ),
//     );