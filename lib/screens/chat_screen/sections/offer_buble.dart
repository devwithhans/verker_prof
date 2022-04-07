import 'package:flutter/material.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';
import 'package:verker_prof/models/offer.dart';
import 'package:verker_prof/screens/make_offer_screen/materials/components/formats.dart';

class OfferBuble extends StatelessWidget {
  const OfferBuble({
    Key? key,
    required this.offer,
  }) : super(key: key);

  final Offer offer;
  @override
  Widget build(BuildContext context) {
    Color offerColor =
        offer.status == "oldOffer" ? Colors.grey : Color(0xff838D72);

    return Padding(
      padding: EdgeInsets.fromLTRB(10, 2, 10, 2),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 3,
              blurRadius: 5,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
          borderRadius: BorderRadius.all(Radius.circular(15)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
              decoration: BoxDecoration(
                color: offerColor,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Her er dit tilbud',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.white),
                  ),
                  Text(
                    'Sendt: ${Jiffy(offer.offerSent).format('dd-MM-yyyy')}',
                    style: TextStyle(fontSize: 15, color: Colors.white),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 15, 15, 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  titleBodyPair('Beskrivelse: ',
                      "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd"),
                  titleBodyPair('Mulig opstart: ',
                      Jiffy(offer.startDate!).format('dd-MM-yyyy')),
                  Text(
                    'Materialer',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 4,
                        child: Text("Beskrivelse",
                            style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                      Expanded(
                        child: Text("Stykpris",
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        flex: 3,
                      ),
                      Expanded(
                        child: Text("Antal",
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        flex: 3,
                      ),
                      Expanded(
                        child: Text("Pris",
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        flex: 3,
                      ),
                    ],
                  ),
                  Column(
                    children: offer.materials
                        .map((e) => Row(
                              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(e.name),
                                  flex: 4,
                                ),
                                Expanded(
                                    flex: 3,
                                    child:
                                        Text(kFormatCurrency.format(e.price))),
                                Expanded(
                                    flex: 3,
                                    child: Text(
                                        kFormatQuantity.format(e.quantity))),
                                Expanded(
                                    flex: 3,
                                    child: Text(kFormatCurrency
                                        .format(e.price * e.quantity))),
                              ],
                            ))
                        .toList(),
                  )
                ],
              ),
            )
          ],
        ),
      ),
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
          style: TextStyle(fontSize: 16),
        ),
        SizedBox(height: 20)
      ],
    );
  }
}
