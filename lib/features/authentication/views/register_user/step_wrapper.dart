import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:verker_prof/features/authentication/bloc/register_user/register_user_cubit.dart';
import 'package:verker_prof/features/authentication/views/register_user/steps/ProfileInformation.dart';
import 'package:verker_prof/features/authentication/views/register_user/steps/profile_image.dart';
import 'package:verker_prof/utils/theme/widgets/loading_indicator.dart';
import 'package:verker_prof/utils/theme/widgets/step_form.dart';

class RegisterUserStepWraper extends StatelessWidget {
  RegisterUserStepWraper({Key? key}) : super(key: key);
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterUserBloc(),
      child: BlocBuilder<RegisterUserBloc, RegisterUserState>(
        builder: (context, state) {
          return state.registerStatus == RegisterStatus.loading
              ? Center(
                  child: LoadingIndicator(),
                )
              : StepForm(
                  stepTitles: const [
                    '1/2: Profilbillede',
                    '2/2: Informationer',
                  ],
                  title: 'title',
                  errorMessage: state.errorMessage,
                  currentStep: state.currentStep,
                  formKey: _formKey,
                  submitText: 'Opret profil',
                  steps: const [
                    ProfileImage(),
                    ProfileInformation(),
                  ],
                  onNext: () {
                    if (_formKey.currentState!.validate()) {
                      context.read<RegisterUserBloc>().incrementCurrentStep();
                    }
                  },
                  onPrevius: () {
                    context.read<RegisterUserBloc>().decrementCurrentStep();
                  },
                  onSubmit: () {
                    if (_formKey.currentState!.validate()) {
                      context.read<RegisterUserBloc>().signUpUser();
                    }
                  },
                );
        },
      ),
    );
  }
}
