import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:verker_prof/theme/constants/textstyle.dart';

class VerkerFormField extends StatelessWidget {
  Function(String) onChanged;
  String? Function(String? value) validator;
  void Function()? onTap;
  Widget? customFormfield;
  String hintText;
  String title;
  bool price;
  bool number;
  bool multiline;
  bool focused;
  String? initialValue;
  TextEditingController? controller;

  VerkerFormField({
    this.controller,
    this.focused = true,
    this.onTap,
    this.initialValue,
    required this.onChanged,
    required this.validator,
    this.customFormfield,
    this.hintText = '',
    this.multiline = false,
    this.number = false,
    this.price = false,
    this.title = '',
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        title.isEmpty ? SizedBox() : SizedBox(height: 20),
        title.isEmpty
            ? SizedBox()
            : Text(
                title,
                style: kTextSmallBold,
              ),
        TextFormField(
          controller: controller,
          onTap: onTap,
          initialValue: initialValue,
          autofocus: focused,
          keyboardType: price || number
              ? const TextInputType.numberWithOptions(decimal: true)
              : multiline
                  ? TextInputType.multiline
                  : onTap != null
                      ? TextInputType.none
                      : TextInputType.text,
          textCapitalization: TextCapitalization.sentences,
          maxLines: null,
          onChanged: onChanged,
          validator: validator,
          showCursor: onTap == null,
          cursorColor: Colors.black,
          style: const TextStyle(fontSize: 18),
          decoration: InputDecoration(
            suffix: price ? const Text('DKK') : null,
            enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.black),
            ),
            focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.black),
            ),
            hintMaxLines: 20,
            hintText: hintText,
          ),
        ),
        SizedBox(height: 20),
      ],
    );
  }
}
