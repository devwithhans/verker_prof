import 'package:flutter/material.dart';
import 'package:verker_prof/theme/constants/textstyle.dart';

class StandardInputForm extends StatelessWidget {
  final Function(String) onChanged;
  final String? Function(String? value) validator;
  final void Function()? onTap;
  final Widget? customFormfield;
  final String hintText;
  final String title;
  final bool price;
  final bool number;
  final bool multiline;
  final bool focused;
  final String? initialValue;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final bool obscureText;
  final TextCapitalization textCapitalization;
  final String? serverError;

  const StandardInputForm({
    this.serverError,
    this.textCapitalization = TextCapitalization.sentences,
    this.obscureText = false,
    this.keyboardType,
    this.controller,
    this.focused = false,
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
    TextInputType _textInputType() {
      return price || number
          ? const TextInputType.numberWithOptions(decimal: true)
          : multiline
              ? TextInputType.multiline
              : onTap != null
                  ? TextInputType.none
                  : TextInputType.text;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        title.isEmpty ? const SizedBox() : const SizedBox(height: 20),
        title.isEmpty
            ? const SizedBox()
            : Text(
                title,
                style: kSmallBold,
              ),
        TextFormField(
          textCapitalization: textCapitalization,
          obscureText: obscureText,
          controller: controller,
          onTap: onTap,
          initialValue: initialValue,
          autofocus: focused,
          keyboardType: keyboardType ?? _textInputType(),
          onChanged: onChanged,
          validator: validator,
          showCursor: onTap == null,
          cursorColor: Colors.black,
          style: const TextStyle(fontSize: 18),
          decoration: InputDecoration(
            errorText: serverError,
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
        const SizedBox(height: 20),
      ],
    );
  }
}
