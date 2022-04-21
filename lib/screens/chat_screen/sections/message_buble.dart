import 'package:flutter/material.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';
import 'package:verker_prof/models/offer.dart';
import 'package:verker_prof/screens/view_offer_screen/view_offer_screen.dart';
import 'package:verker_prof/theme/constants/textstyle.dart';

class VerkerMessageBuble extends StatelessWidget {
  final bool recieved;

  const VerkerMessageBuble({
    required this.recieved,
    Key? key,
    required this.item,
  }) : super(key: key);

  final Message item;

  @override
  Widget build(BuildContext context) {
    ShortOffer shortOffer;

    bool offer = item.extraData['offerId'] != null;

    Widget messageContent() {
      if (offer) {
        return Column(
          children: [
            Text(
              'Du har sendt et tilbud 📄',
              style: TextStyle(
                decoration: TextDecoration.underline,
                color: recieved ? Colors.white : Colors.black,
                fontSize: 15,
              ),
            ),
          ],
        );
      } else {
        return Column(
          children: [
            Text(item.text!,
                style: TextStyle(
                    color: recieved ? Colors.white : Colors.black,
                    fontSize: 15)),
          ],
        );
      }
    }

    return Padding(
      padding: recieved
          ? EdgeInsets.fromLTRB(30, 2, 10, 2)
          : EdgeInsets.fromLTRB(10, 2, 30, 2),
      child: Column(
        crossAxisAlignment:
            recieved ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: () {
              if (offer) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ViewOffer(
                            offerId: item.extraData['offerId'] as String)));
              }
            },
            child: Material(
              borderRadius:
                  recieved ? kMessageSideRadiusRight : kMessageSideRadiusLeft,
              color: offer
                  ? Colors.grey
                  : recieved
                      ? Colors.lightBlueAccent
                      : Colors.grey[200],
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: messageContent(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
