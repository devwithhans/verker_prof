import 'package:flutter/material.dart';
import 'package:verker_prof/utils/theme/constants/colors.dart';

class SlideWidget extends StatelessWidget {
  final String image;
  final String title;
  final String description;
  const SlideWidget({
    required this.description,
    required this.image,
    required this.title,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(image),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
              Text(
                title,
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 30),
              ),
              SizedBox(height: 10),
              Text(
                description,
                style: TextStyle(fontSize: 15, color: kGreyText),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
