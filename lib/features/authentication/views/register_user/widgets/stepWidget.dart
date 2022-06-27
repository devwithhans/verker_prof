import 'package:flutter/material.dart';
import 'package:verker_prof/utils/theme/constants/colors.dart';
import 'package:verker_prof/utils/theme/constants/textstyle.dart';

class StepWidget extends StatelessWidget {
  const StepWidget({
    required this.child,
    required this.description,
    required this.title,
    this.childPadding,
    Key? key,
  }) : super(key: key);

  final String title;
  final String description;
  final Widget child;
  final EdgeInsetsGeometry? childPadding;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        Padding(
          padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: kMediumBold,
              ),
              SizedBox(height: 4),
              Text(
                description,
                style: TextStyle(color: kGreyText, fontSize: 15),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        Padding(
          padding: childPadding ?? EdgeInsets.fromLTRB(20, 0, 20, 0),
          child: child,
        )
      ],
    );
  }
}
