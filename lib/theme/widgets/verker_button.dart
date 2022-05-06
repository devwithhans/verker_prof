import 'package:flutter/material.dart';

class VerkerButton extends StatelessWidget {
  const VerkerButton({
    Key? key,
    required this.text,
    required this.onPressed,
    required this.active,
  }) : super(key: key);

  final void Function() onPressed;
  final bool active;
  final String text;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: active ? onPressed : () {},
      child: Container(
        // margin: EdgeInsets.only(right: 10),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        color: active ? Colors.black : Colors.grey,
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
