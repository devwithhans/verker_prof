import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:verker_prof/features/authentication/bloc/firebase_signin_bloc/firebase_signin_bloc.dart';
import 'package:verker_prof/features/authentication/views/login_view/sections.dart/verify_sms.dart';
import 'package:verker_prof/utils/theme/constants/colors.dart';
import 'package:verker_prof/utils/theme/widgets/buttons.dart';
import 'package:verker_prof/utils/theme/widgets/verker_input_form.dart';

class SendSmsWidget extends StatelessWidget {
  const SendSmsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String phoneNumber = '';

    final _formKey = GlobalKey<FormState>();

    final _mobileFormatter = MaskTextInputFormatter(
      mask: '## ## ## ##',
      filter: {
        "#": RegExp(r'[0-9]'),
      },
    );
    return BlocBuilder<FirebaseSigninBloc, FirebaseSigninState>(
      builder: (context, state) {
        if (state is CodeSent) {
          print('ookay');
          myCallback(
            () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (c) => BlocProvider.value(
                    value: context.read<FirebaseSigninBloc>(),
                    child: VerifySms(
                      verificationId: state.verificationId,
                    ),
                  ),
                ),
              );
            },
          );
        }
        return Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(),
              Column(
                children: [
                  const Text(
                    'Indtast dit nummer',
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
                  ),
                  VerkerInputForm(
                    prefixIcon: const Center(
                      child: Text(
                        ' +45',
                        style: TextStyle(
                            color: Colors.black, fontSize: 16, height: 1),
                      ),
                    ),
                    keyboardType: TextInputType.phone,
                    initialValue: '',
                    inputFormatters: [_mobileFormatter],
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Feltet må ikke være tomt';
                      }
                      if (value.length != 11) {
                        return 'Angiv venligst et rigtigt telefonnummer';
                      }
                      return null;
                    },
                    textCapitalization: TextCapitalization.words,
                    onChanged: (v) {
                      phoneNumber = v;

                      print(phoneNumber);
                    },
                    // title: 'Telefonnummer.',
                    hintText: 'Dit telefonnummer',
                  ),
                  SizedBox(height: 10),
                  const Text(
                    'Vi sender dig en SMS for at verificere dit telefonnummer',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 15, color: kGreyText),
                  ),
                ],
              ),
              SizedBox(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  StandardButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        phoneNumber = phoneNumber.replaceAll(RegExp(" "), "");
                        phoneNumber = '+45' + phoneNumber;
                        context
                            .read<FirebaseSigninBloc>()
                            .add(SendSms(phoneNumber));
                      }
                    },
                    text: 'Fortsæt',
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Ved at fortsætte acceptere du Verker’s Vilkår og Betingelser og Privatlivspolitik',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 13, color: kGreyText),
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }

  void myCallback(Function callback) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      callback();
    });
  }
}
