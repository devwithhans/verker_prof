import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:verker_prof/blocs/login_bloc/login_bloc.dart';
import 'package:verker_prof/repositories/authRepo.dart';
import 'package:verker_prof/theme/constants/textstyle.dart';
import 'package:verker_prof/theme/widgets/buttons.dart';
import 'package:verker_prof/theme/widgets/loading_indicator.dart';
import 'package:verker_prof/theme/widgets/standard_input_form.dart';

class LoginView extends StatefulWidget {
  static String name = '/loginscreen';

  @override
  State<LoginView> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<LoginView> {
  bool termsAccept = false; // Cannot continue without this true
  final _formKey = GlobalKey<FormState>(); // To validate the userinput
  String _email = '';
  String _password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset:
          false, // Wont move background if the keyboard is active
      appBar: AppBar(),
      body: Padding(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 30),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Log Ind.',
                      style: kLargeBold,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(height: 20),
                    _nameAndEmailTab()
                  ],
                ),
                BlocBuilder<LoginBloc, LoginState>(
                  builder: (context, state) {
                    if (state is Loading) {
                      CircularProgressIndicator();
                    }
                    if (state is Succes) {
                      myCallback(() {
                        Navigator.pop(context);
                      });
                    }

                    return StandardButton(
                      textColor: Colors.white,
                      backgroundColor: Colors.black,
                      text: 'Log Ind',
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          context.read<LoginBloc>().add(
                                Login(
                                  email: _email.toLowerCase(),
                                  password: _password,
                                ),
                              );
                        }
                      },
                    );
                  },
                ),
              ],
            ),
          )),
    );
  }

  Widget _nameAndEmailTab() {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        print(state);
        return Column(
          children: [
            StandardInputForm(
              textCapitalization: TextCapitalization.none,
              serverError: state is EmailFailed ? state.errorMessage : null,
              controller: TextEditingController(text: _email),
              onChanged: (value) {
                _email = value;
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Indtast venligst en email';
                }
                bool emailValid = RegExp(
                        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                    .hasMatch(value);
                if (!emailValid) {
                  return 'Indtast venligst en gyldig mail';
                }
              },
              keyboardType: TextInputType.emailAddress,
              title: 'Email.',
              hintText: 'Din email',
            ),
            StandardInputForm(
              serverError: state is PasswordFailed ? state.errorMessage : null,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Husk en kode';
                }
                return null;
              },
              controller: TextEditingController(text: _password),
              textCapitalization: TextCapitalization.words,
              onChanged: (v) {
                _password = v;
              },
              obscureText: true,
              title: 'Password.',
              hintText: 'Indtast dit password',
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        );
      },
    );
  }

  void myCallback(Function callback) {
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      callback();
    });
  }
}
