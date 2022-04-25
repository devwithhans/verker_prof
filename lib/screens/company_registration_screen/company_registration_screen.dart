import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:verker_prof/blocs/login_bloc/login_bloc.dart';
import 'package:verker_prof/blocs/register_bloc/register_bloc.dart';
import 'package:verker_prof/screens/company_registration_screen/subscreens/formscreen_one.dart';
import 'package:verker_prof/screens/company_registration_screen/subscreens/formscreen_two.dart';
import 'package:verker_prof/screens/register_screen/sections/navigation_buttons.dart';

class CompanyRegistrationScreen extends StatefulWidget {
  CompanyRegistrationScreen({Key? key}) : super(key: key);

  static String name = "RegisterScreen";

  @override
  State<CompanyRegistrationScreen> createState() =>
      _CompanyRegistrationScreenState();
}

class _CompanyRegistrationScreenState extends State<CompanyRegistrationScreen> {
  final _formKey = GlobalKey<FormState>();
  int currentStep = 0;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterBloc(),
      child: BlocBuilder<RegisterBloc, RegisterState>(
        builder: (context, state) {
          if (state.registerStatus == RegisterStatus.loading) {
            return Center(child: CircularProgressIndicator());
          }
          if (state.registerStatus == RegisterStatus.succes) {
            print(state.registrationModel.email!.toLowerCase());
            print(state.registrationModel.password!);
            context.read<LoginBloc>().add(Login(
                  email: state.registrationModel.email!.toLowerCase(),
                  password: state.registrationModel.password!,
                ));
            Navigator.pop(context);
          }
          return CompanyRegistrationWrapper(
              formKey: _formKey,
              steps: [
                CompanyFormScreenOne(),
                CompanyFormScreenTwo(),
              ],
              currentStep: currentStep);
        },
      ),
    );
  }
}

class CompanyRegistrationWrapper extends StatefulWidget {
  const CompanyRegistrationWrapper({
    Key? key,
    required GlobalKey<FormState> formKey,
    required this.steps,
    required this.currentStep,
  })  : _formKey = formKey,
        super(key: key);

  final GlobalKey<FormState> _formKey;
  final List<Widget> steps;
  final int currentStep;

  @override
  State<CompanyRegistrationWrapper> createState() =>
      _CompanyRegistrationWrapperState();
}

class _CompanyRegistrationWrapperState
    extends State<CompanyRegistrationWrapper> {
  late bool atEnd;
  late bool atStart;
  late int currentStep;

  @override
  void initState() {
    // TODO: implement initState
    currentStep = widget.currentStep;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    atEnd = currentStep == widget.steps.length - 1;
    atStart = currentStep == 0;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
        child: Stack(
          children: [
            ListView(
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Form(
                  key: widget._formKey,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 100),
                    child: Column(
                      children: widget.steps.map(
                        (e) {
                          return Visibility(
                            maintainState: false,
                            visible: currentStep == widget.steps.indexOf(e),
                            child: e,
                          );
                        },
                      ).toList(),
                    ),
                  ),
                ),
              ],
            ),
            Visibility(
              visible: currentStep != 0,
              child: NavigationButtons(
                startText: 'Opret virksomhed',
                atEnd: atEnd,
                atStart: atStart,
                onPrevius: () {
                  currentStep--;

                  setState(() {});
                },
                onNext: () {
                  if (widget._formKey.currentState!.validate()) {
                    currentStep = widget.currentStep + 1;
                    setState(() {});
                  }
                },
                onSubmit: () {
                  if (widget._formKey.currentState!.validate()) {
                    context.read<RegisterBloc>().add(SignUpUser());
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
