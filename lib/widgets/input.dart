import 'dart:isolate';

import 'package:flutter/material.dart';

class UnderLineInput extends StatelessWidget {
  String label;
  String hintText;
  void Function(String)? onChange;
  String? Function(String?)? validator;
  TextEditingController? controller;
  bool obscureText;
  TextInputType keyboardType;
  TextCapitalization textCapitalization;
  GlobalKey? key;

  UnderLineInput({
    this.keyboardType = TextInputType.text,
    this.textCapitalization = TextCapitalization.none,
    this.obscureText = false,
    required this.label,
    required this.hintText,
    this.controller,
    this.onChange,
    this.validator,
    this.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        TextFormField(
          textCapitalization: TextCapitalization.words,
          keyboardType: keyboardType,
          obscureText: obscureText,
          onChanged: onChange,
          validator: validator,
          controller: controller,
          style: TextStyle(fontSize: 18),
          decoration: InputDecoration(
            hintText: hintText,
            enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.black, width: 2),
            ),
            focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.black, width: 2),
            ),
          ),
        ),
      ],
    );
  }
}

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
