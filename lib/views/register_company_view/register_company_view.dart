import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:verker_prof/blocs/company_register_bloc/company_register_bloc.dart';
import 'package:verker_prof/repositories/authRepo.dart';
import 'package:verker_prof/screens/company_registration_screen/subscreens/formscreen_one.dart';
import 'package:verker_prof/screens/company_registration_screen/subscreens/selectBusinessType.dart';
import 'package:verker_prof/theme/components/step_form.dart';
import 'package:verker_prof/views/register_company_view/subscreens/initial_company_registration_view.dart';

class CompanyRegistrationView extends StatefulWidget {
  CompanyRegistrationView({Key? key}) : super(key: key);

  static String name = "RegisterScreen";

  @override
  State<CompanyRegistrationView> createState() =>
      _CompanyRegistrationViewState();
}

class _CompanyRegistrationViewState extends State<CompanyRegistrationView> {
  final _formKey = GlobalKey<FormState>();
  int currentStep = 0;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          CompanyRegisterBloc(context.read<AuthenticationRepository>()),
      child: BlocBuilder<CompanyRegisterBloc, CompanyRegisterState>(
        builder: (context, state) {
          if (state.registerStatus == CompanyRegisterStatus.loading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state.registerStatus == CompanyRegisterStatus.succes) {
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
                currentStep = currentStep + 1;
                setState(() {});
              }
            },
            onSubmit: () {
              context.read<CompanyRegisterBloc>().add(RegisterCompany());
            },
            formKey: _formKey,
            steps: [
              InitialCompanyRegistrationView(),
              CompanyFormScreenTwo(),
              SelectBusinessType(),
            ],
          );
        },
      ),
    );
  }
}
