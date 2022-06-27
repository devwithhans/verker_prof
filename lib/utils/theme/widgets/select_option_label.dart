import 'package:flutter/material.dart';

class OptionSelect extends StatelessWidget {
  void Function() onPressed;
  List<String> selectedOptions;
  String option;

  OptionSelect({
    this.selectedOptions = const [],
    required this.option,
    required this.onPressed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool selected = selectedOptions.contains(option);
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.all(Radius.circular(5)),
          color: selected ? Color(0xff000000) : Colors.transparent,
        ),
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Text(
          option,
          style: TextStyle(
            color: selected ? Colors.white : Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
        ),
      ),
    );
  }
}
