import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:verker_prof/blocs/login_bloc/login_bloc.dart';
import 'package:verker_prof/blocs/register_bloc/register_bloc.dart';
import 'package:verker_prof/theme/widgets/loading_indicator.dart';
import 'package:verker_prof/theme/widgets/step_form.dart';
import 'package:verker_prof/views/register_view/subviews/formscreen_one.dart';
import 'package:verker_prof/views/register_view/subviews/formscreen_two.dart';

class RegisterView extends StatefulWidget {
  RegisterView({Key? key}) : super(key: key);

  static String name = "RegisterScreen";

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final _formKey = GlobalKey<FormState>();
  int currentStep = 0;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterBloc(),
      child: BlocBuilder<RegisterBloc, RegisterState>(
        builder: (context, state) {
          if (state.registerStatus == RegisterStatus.loading) {
            return Center(child: LoadingIndicator());
          }
          if (state.registerStatus == RegisterStatus.succes) {
            context.read<LoginBloc>().add(Login(
                  email: state.registrationModel.email!.toLowerCase(),
                  password: state.registrationModel.password!,
                ));
            myCallback(() {
              Navigator.pop(context);
            });
            // Navigator.pop(context);
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

  void myCallback(Function callback) {
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      callback();
    });
  }
}
