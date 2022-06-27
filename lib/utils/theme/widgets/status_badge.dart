import 'package:flutter/material.dart';
import 'package:verker_prof/utils/theme/constants/textstyle.dart';

class StatusBadge extends StatelessWidget {
  const StatusBadge({Key? key, required this.text, required this.color})
      : super(key: key);

  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 10),
      padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(100)),
        color: color,
      ),
      child: Text(
        text,
        style: kSmallBold,
      ),
    );
  }
}
