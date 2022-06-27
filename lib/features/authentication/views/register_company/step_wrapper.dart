import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:verker_prof/features/authentication/bloc/register_company/register_company_cubit.dart';
import 'package:verker_prof/features/authentication/views/register_company/steps/company_address.dart';

import 'package:verker_prof/features/authentication/views/register_company/steps/company_details.dart';
import 'package:verker_prof/features/authentication/views/register_company/steps/company_logo.dart';
import 'package:verker_prof/features/authentication/views/register_company/steps/company_services.dart';

import 'package:verker_prof/utils/theme/widgets/loading_indicator.dart';
import 'package:verker_prof/utils/theme/widgets/step_form.dart';

class RegisterCompanyStepWrapper extends StatelessWidget {
  RegisterCompanyStepWrapper({Key? key}) : super(key: key);
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterCompanyBloc(),
      child: BlocBuilder<RegisterCompanyBloc, RegisterCompanyState>(
        builder: (context, state) {
          return state.registerStatus == RegisterStatus.loading
              ? Center(
                  child: LoadingScreen(),
                )
              : StepForm(
                  stepTitles: const [
                    '1/4: Opret din virksomhed',
                    '2/4: Informationer',
                    '3/4: Informationer',
                    '4/4: Informationer',
                  ],
                  title: 'title',
                  nextText: 'Næste',
                  startText: 'Næste',
                  errorMessage: state.errorMessage,
                  currentStep: state.currentStep,
                  formKey: _formKey,
                  submitText: 'Opret profil',
                  steps: const [
                    CompanyServices(),
                    CompanyLogo(),
                    CompanyAddress(),
                    CompanyDetails(),
                  ],
                  onNext: () {
                    if (_formKey.currentState!.validate()) {
                      context
                          .read<RegisterCompanyBloc>()
                          .incrementCurrentStep();
                    }
                  },
                  onPrevius: () {
                    context.read<RegisterCompanyBloc>().decrementCurrentStep();
                  },
                  onSubmit: () {
                    if (_formKey.currentState!.validate()) {
                      context.read<RegisterCompanyBloc>().registerCompany();
                    }
                  },
                );
        },
      ),
    );
  }
}

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: LoadingIndicator()),
    );
  }
}
