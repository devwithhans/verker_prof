import 'package:flutter/material.dart';

const kTextSmallBold =
    TextStyle(color: Colors.black, fontWeight: FontWeight.bold);

const kTextSmallNormal = TextStyle(color: Colors.black);

const kTextMediumBold =
    TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20);

const kMessageSideRadiusRight = BorderRadius.only(
  topLeft: Radius.circular(7),
  topRight: Radius.circular(7),
  bottomLeft: Radius.circular(7),
);

const kMessageSideRadiusLeft = BorderRadius.only(
    topRight: Radius.circular(7),
    topLeft: Radius.circular(7),
    bottomRight: Radius.circular(7));
