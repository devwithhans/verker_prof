import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:verker_prof/blocs/company_register_bloc/company_register_bloc.dart';
import 'package:verker_prof/blocs/register_bloc/register_bloc.dart';
import 'package:verker_prof/screens/company_registration_screen/subscreens/formscreen_one.dart';
import 'package:verker_prof/screens/company_registration_screen/subscreens/register_step_one.dart';
import 'package:verker_prof/screens/company_registration_screen/subscreens/selectBusinessType.dart';
import 'package:verker_prof/screens/company_registration_screen/subscreens/startScreen.dart';
import 'package:verker_prof/theme/components/step_form.dart';

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
      create: (context) => CompanyRegisterBloc(),
      child: BlocBuilder<CompanyRegisterBloc, CompanyRegisterState>(
        builder: (context, state) {
          if (state.registerStatus == RegisterStatus.loading) {
            return Center(child: CircularProgressIndicator());
          }
          if (state.registerStatus == RegisterStatus.succes) {
            Navigator.pop(context);
          }
          return StepForm(
            title: 'Opret virksomhed.',
            currentStep: currentStep,
            submitText: 'Opret',
            onPrevius: () {
              currentStep--;
              setState(() {});
            },
            onNext: () {
              if (_formKey.currentState!.validate()) {
                // if (currentStep == 0) {
                //   context
                //       .read<CompanyRegisterBloc>()
                //       .add(SearchCompanyByName());
                // }
                currentStep = currentStep + 1;
                setState(() {});
              }
            },
            onSubmit: () {},
            formKey: _formKey,
            steps: [
              StartScreen(),
              CompanyFormScreenTwo(),
              SelectBusinessType(),
            ],
          );
        },
      ),
    );
  }
}
