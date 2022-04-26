import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:verker_prof/blocs/login_bloc/login_bloc.dart';
import 'package:verker_prof/blocs/register_bloc/register_bloc.dart';
import 'package:verker_prof/screens/register_screen/sections/navigation_buttons.dart';
import 'package:verker_prof/screens/register_screen/subscreens/formscreen_one.dart';
import 'package:verker_prof/screens/register_screen/subscreens/formscreen_two.dart';
import 'package:verker_prof/theme/components/step_form.dart';

class RegisterScreen extends StatefulWidget {
  RegisterScreen({Key? key}) : super(key: key);

  static String name = "RegisterScreen";

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
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
          return StepForm(
            title: 'Registrer bruger',
            currentStep: currentStep,
            onPrevius: () {
              currentStep--;
              setState(() {});
            },
            onNext: () {
              if (_formKey.currentState!.validate()) {
                currentStep = currentStep + 1;
                setState(() {});
              }
            },
            onSubmit: () {
              if (_formKey.currentState!.validate()) {
                context.read<RegisterBloc>().add(SignUpUser());
              }
            },
            formKey: _formKey,
            steps: [
              FormScreenOne(),
              FormScreenTwo(),
            ],
          );
        },
      ),
    );
  }
}
