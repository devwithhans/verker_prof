import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:verker_prof/features/authentication/bloc/firebase_signin_bloc/firebase_signin_bloc.dart';
import 'package:verker_prof/features/authentication/views/login_view/sections.dart/send_sms.dart';

class LoginView extends StatelessWidget {
  const LoginView({Key? key}) : super(key: key);
  static String name = '/loginscreen';

  @override
  Widget build(BuildContext context) {
    return BlocProvider<FirebaseSigninBloc>(
      create: (BuildContext context) => FirebaseSigninBloc(),
      child: Scaffold(
        appBar: AppBar(systemOverlayStyle: SystemUiOverlayStyle.dark),
        body: const Padding(
          padding: EdgeInsets.all(20),
          child: SendSmsWidget(),
        ),
      ),
    );
  }
}
