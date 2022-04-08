import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';
import 'package:verker_prof/blocs/offerBuble_cubit/offerbuble_cubit.dart';
import 'package:verker_prof/models/offer.dart';
import 'package:verker_prof/screens/chat_screen/sections/offer_buble.dart';
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
    return Padding(
      padding: recieved
          ? EdgeInsets.fromLTRB(30, 2, 10, 2)
          : EdgeInsets.fromLTRB(10, 2, 30, 2),
      child: Column(
        crossAxisAlignment:
            recieved ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Material(
            borderRadius:
                recieved ? kMessageSideRadiusRight : kMessageSideRadiusLeft,
            color: recieved ? Colors.lightBlueAccent : Colors.grey[200],
            child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Column(
                  children: [
                    Text(item.text!,
                        style: TextStyle(
                            color: recieved ? Colors.white : Colors.black,
                            fontSize: 15)),
                  ],
                )),
          ),
        ],
      ),
    );
  }
}
