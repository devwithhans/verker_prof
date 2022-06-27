import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:verker_prof/utils/theme/constants/colors.dart';

class VerkerInputForm extends StatelessWidget {
  const VerkerInputForm({
    this.prefixIcon,
    this.controller,
    this.focusNode,
    this.textCapitalization = TextCapitalization.sentences,
    this.onTap,
    this.validator,
    this.keyboardType,
    this.hintMaxLines = 20,
    this.hintText = '',
    this.title = '',
    this.onSaved,
    this.onEditingComplete,
    this.maxLines,
    this.minLines,
    this.onChanged,
    this.obscureText = false,
    this.initialValue,
    this.inputFormatters,
    Key? key,
  }) : super(key: key);
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final TextCapitalization textCapitalization;
  final FocusNode? focusNode;
  final String? initialValue;
  final String hintText;
  final Widget? prefixIcon;
  final String title;
  final int? maxLines;
  final int? minLines;
  final int hintMaxLines;
  final bool obscureText;
  final void Function(String value)? onChanged;
  final void Function()? onEditingComplete;
  final void Function()? onTap;
  final void Function(String? value)? onSaved;
  final String? Function(String? value)? validator;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 15),
        ),
        SizedBox(height: 10),
        TextFormField(
          obscureText: obscureText,
          inputFormatters: inputFormatters,
          textCapitalization: textCapitalization,
          focusNode: focusNode,
          onTap: onTap,
          validator: validator,
          controller: controller,
          minLines: minLines,
          initialValue: initialValue,
          keyboardType: keyboardType,
          maxLines: maxLines,
          onChanged: onChanged,
          onEditingComplete: onEditingComplete,
          onSaved: onSaved,
          cursorColor: Colors.black,
          decoration: InputDecoration(
            prefixIconConstraints: BoxConstraints(maxHeight: 20, maxWidth: 45),
            prefixIcon: prefixIcon,
            contentPadding: EdgeInsets.all(14),
            // filled: true,
            fillColor: const Color(0xffFCFCFC),
            focusedBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              borderSide: BorderSide(color: kGreyColor, width: 1),
            ),
            enabledBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              borderSide: BorderSide(color: kGreyColor, width: 0.5),
            ),
            errorBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              borderSide: BorderSide(color: Colors.red, width: 0.5),
            ),
            focusedErrorBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              borderSide: BorderSide(color: Colors.red, width: 1),
            ),
            hintMaxLines: hintMaxLines,
            hintText: hintText,
          ),
        ),
      ],
    );
  }
}
