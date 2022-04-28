import 'package:flutter/material.dart';

class ChatNotiButton extends StatelessWidget {
  const ChatNotiButton({
    required this.text,
    required this.onPressed,
    Key? key,
  }) : super(key: key);

  final void Function() onPressed;
  final String text;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: GestureDetector(
              onTap: onPressed,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                color: Colors.black.withOpacity(0.5),
                child: Center(
                  child: Text(
                    text,
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        decoration: TextDecoration.underline),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
