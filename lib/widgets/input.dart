import 'package:flutter/material.dart';

class Compliance extends StatelessWidget {
  final bool value;
  Function() onChange;
  final String text;
  String errorText;
  bool showError;

  Compliance({
    this.errorText = '',
    this.value = false,
    required this.onChange,
    this.text = '',
    this.showError = false,
  });

  void _onChange(v) {
    onChange();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onChange,
      child: Container(
        color: Colors.transparent,
        width: double.infinity,
        height: 60,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                Transform.scale(
                  scale: 1.3,
                  child: SizedBox(
                    height: 24.0,
                    width: 24.0,
                    child: Checkbox(
                      activeColor: Colors.black,
                      side: BorderSide(width: 1),
                      value: value,
                      splashRadius: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(4),
                        ),
                      ),
                      onChanged: _onChange,
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  text,
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                ),
              ],
            ),
            Visibility(
              visible: showError,
              child: Padding(
                padding: const EdgeInsets.only(top: 5),
                child: Text(
                  errorText,
                  style: TextStyle(color: Colors.red.shade700, fontSize: 13),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
