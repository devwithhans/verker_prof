import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:pinput/pinput.dart';
import 'package:verker_prof/features/authentication/bloc/firebase_signin_bloc/firebase_signin_bloc.dart';

class VerifySms extends StatelessWidget {
  const VerifySms({Key? key, required this.verificationId}) : super(key: key);

  final String verificationId;

  @override
  Widget build(BuildContext context) {
    final _mobileFormatter = MaskTextInputFormatter(
      mask: '## ## ## ##',
      filter: {
        "#": RegExp(r'[0-9]'),
      },
    );
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(),
          Column(
            // ignore: prefer_const_literals_to_create_immutables
            children: [
              Text(
                'Indtast den kode vi har sendt dig',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700),
              ),
              SizedBox(height: 20),
              Pinput(
                autofocus: true,
                length: 6,
                defaultPinTheme: PinTheme(
                  width: 56,
                  height: 56,
                  textStyle: TextStyle(
                      fontSize: 20,
                      color: Color.fromRGBO(30, 60, 87, 1),
                      fontWeight: FontWeight.w600),
                  decoration: BoxDecoration(
                    border:
                        Border.all(color: Color.fromARGB(255, 120, 120, 120)),
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                crossAxisAlignment: CrossAxisAlignment.center,
                validator: (s) {
                  // return s == '2222' ? null : 'Pin is incorrect';
                },
                pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                showCursor: true,
                onCompleted: (pin) {
                  BlocProvider.of<FirebaseSigninBloc>(context)
                      .add(VerifyCode(pin, verificationId));
                },
              ),
              SizedBox(height: 10),
              const Text(
                'Har du ikke modtaget en SMS?',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 15),
              ),
            ],
          ),
          SizedBox(),
          SizedBox(),
        ],
      ),
    );
  }
}
