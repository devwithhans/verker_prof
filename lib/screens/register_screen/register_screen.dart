import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:verker_prof/blocs/login_bloc/login_bloc.dart';
import 'package:verker_prof/screens/login_screens/sections.dart/login.dart';
import 'package:verker_prof/theme/components/standard_input_form.dart';
import 'package:verker_prof/widgets/buttons.dart';
import 'package:verker_prof/widgets/input.dart';

// TODO: Create registration in backend, and link it

class RegisterScreen extends StatefulWidget {
  static String name = '/registerScreen';

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool termsAccept = false;
  final _formKey = GlobalKey<FormState>();
  bool showComplianceError = false;
  String _name = '';
  String _email = '';
  String _password = '';
  String _passwordComp = '';

  @override
  Widget build(BuildContext context) {
    List<Widget> initialScreen = [
      _nameAndEmailTab(),
      _passwordTab(),
    ];

    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(25, 40, 25, 25),
          child: BlocBuilder<LoginBloc, LoginState>(
            builder: (context, state) {
              return Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Opret dig.',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 30,
                            )),
                        const SizedBox(
                          height: 40,
                        ),
                        initialScreen[state.screen],
                      ],
                    ),
                    Column(
                      children: [
                        HorizontalNavigationButtons(
                          index: state.screen,
                          length: initialScreen.length - 1,
                          onNext: () {
                            showComplianceError = !termsAccept;
                            setState(() {});
                            if (_formKey.currentState!.validate() &&
                                termsAccept) {
                              context
                                  .read<LoginBloc>()
                                  .selectScreen(state.screen + 1);
                            }
                          },
                          onBack: () {
                            context
                                .read<LoginBloc>()
                                .selectScreen(state.screen - 1);
                          },
                          onSubmit: () {
                            if (_formKey.currentState!.validate()) {
                              // context.read<LoginBloc>().selectScreen(index + 1);
                            }
                          },
                        ),
                        // _navigation(state.screen, initialScreen.length - 1),
                        const SizedBox(
                          height: 15,
                        ),
                        LinkTekst(
                          onPressed: () {
                            Navigator.pop(context);
                            Navigator.pushNamed(context, LoginScreen.name);
                          },
                          beforeText: 'Har du allerede en konto? ',
                          linkText: 'Login her',
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        ));
  }

  Widget _nameAndEmailTab() {
    return Column(
      children: [
        StandardInputForm(
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter some text';
            }
            return null;
          },
          controller: TextEditingController(text: _name),
          textCapitalization: TextCapitalization.words,
          onChanged: (v) {
            _name = v;
          },
          title: 'Navn.',
          hintText: 'Dit fornavn og efternavn',
        ),
        SizedBox(
          height: 40,
        ),
        StandardInputForm(
          controller: TextEditingController(text: _email),
          onChanged: (value) {
            _email = value;
          },
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Indtast venligst et navn';
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
        SizedBox(
          height: 20,
        ),
        Compliance(
          showError: showComplianceError,
          errorText: 'Du skal godkende vores vilkår',
          value: termsAccept,
          text: 'Accepterer du vores vilkår?',
          onChange: () {
            termsAccept = !termsAccept;
            setState(() {});
          },
        )
      ],
    );
  }

  Widget _passwordTab() {
    return Column(
      children: [
        StandardInputForm(
          controller: TextEditingController(text: _password),
          onChanged: (v) {
            _password = v;
          },
          validator: (value) {
            if (value == null || value.length < 6) {
              return 'Din kode skal minimum være 6 tegn';
            }
          },
          obscureText: true,
          title: 'Password.',
          hintText: 'Mininum 6 tal eller bogstaver',
        ),
        SizedBox(
          height: 40,
        ),
        StandardInputForm(
          controller: TextEditingController(text: _passwordComp),
          onChanged: (v) {
            _passwordComp = v;
          },
          validator: (value) {
            if (value != _password) {
              return 'Koderne er ikke ens';
            }
          },
          obscureText: true,
          title: 'Gentag password.',
          hintText: 'De 2 kodeord skal være ens',
        ),
        SizedBox(
          height: 50,
        ),
      ],
    );
  }
}
