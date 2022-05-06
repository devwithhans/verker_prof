import 'package:flutter/material.dart';

class SendForm extends StatelessWidget {
  final TextEditingController controller;
  final void Function() onSend;

  const SendForm({required this.controller, required this.onSend, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.fromLTRB(20, 15, 20, 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 5,
            child: TextFormField(
              textCapitalization: TextCapitalization.sentences,
              controller: controller,
              maxLines: null,
              keyboardType: TextInputType.multiline,
              obscureText: false,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.fromLTRB(20, 10, 10, 10),
                filled: true,
                fillColor: const Color(0xffF1F5F9),
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(100),
                ),
                hintText: 'Svar Verker',
              ),
            ),
          ),
          Expanded(
            child: IconButton(icon: const Icon(Icons.send), onPressed: onSend),
          )
        ],
      ),
    );
  }
}
