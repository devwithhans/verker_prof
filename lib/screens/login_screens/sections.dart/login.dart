import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:verker_prof/blocs/login_bloc/login_bloc.dart';
import 'package:verker_prof/screens/login_screens/sections.dart/register.dart';
import 'package:verker_prof/theme/components/standard_input_form.dart';
import 'package:verker_prof/widgets/buttons.dart';

class LoginScreen extends StatefulWidget {
  static String name = '/loginscreen';

  @override
  State<LoginScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<LoginScreen> {
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
          padding: const EdgeInsets.fromLTRB(25, 40, 25, 25),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Log Ind.',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    _nameAndEmailTab(),
                  ],
                ),
                Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: BlocBuilder<LoginBloc, LoginState>(
                              builder: (context, state) {
                            if (state is Loading) {
                              CircularProgressIndicator();
                            }
                            if (state is Succes) {
                              context.read<LoginBloc>().emit(LoginInitial());
                            }

                            return NavigationButton(
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
                                  Navigator.pop(context);
                                }
                              },
                            );
                          }),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    LinkTekst(
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.pushNamed(context, RegisterScreen.name);
                      },
                      beforeText: 'Har du ikke en konto? ',
                      linkText: 'Registrer her',
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                  ],
                ),
              ],
            ),
          )),
    );
  }

  Widget _nameAndEmailTab() {
    return Column(
      children: [
        StandardInputForm(
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
        const SizedBox(
          height: 40,
        ),
        StandardInputForm(
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
  }
}
