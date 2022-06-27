import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:verker_prof/features/authentication/bloc/register_user/register_user_cubit.dart';
import 'package:verker_prof/features/authentication/views/register_user/widgets/select_profile_image.dart';
import 'package:verker_prof/features/authentication/views/register_user/widgets/stepWidget.dart';
import 'package:verker_prof/utils/theme/constants/colors.dart';
import 'package:verker_prof/utils/theme/widgets/input.dart';
import 'package:verker_prof/utils/theme/widgets/verker_input_form.dart';

class ProfileInformation extends StatelessWidget {
  const ProfileInformation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    RegisterUserBloc registerUserBloc = context.read<RegisterUserBloc>();
    return StepWidget(
      title: 'Hvad skal vi kalde dig?',
      description:
          'Lad os starte stille og roligt ud med det mest basale omkring dig.',
      child: BlocBuilder<RegisterUserBloc, RegisterUserState>(
        builder: (context, state) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              VerkerInputForm(
                title: 'Fornavn',
                validator: (v) {
                  if (v == null || v == '') {
                    return 'Du mangler dette felt';
                  }
                },
                maxLines: 1,
                initialValue: state.firstName,
                onChanged: (value) {
                  registerUserBloc.addFirstName(value);
                },
                hintText: 'Skriv dit fornavn her...',
              ),
              SizedBox(height: 30),
              VerkerInputForm(
                title: 'Efternavn',
                validator: (v) {
                  if (v == null || v == '') {
                    return 'Du mangler dette felt';
                  }
                },
                maxLines: 1,
                initialValue: state.lastName,
                onChanged: (value) {
                  registerUserBloc.addLastName(value);
                },
                hintText: 'Skriv dit efternavn her...',
              ),
              SizedBox(height: 30),
              VerkerInputForm(
                title: 'Email',
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
                  return null;
                },
                textCapitalization: TextCapitalization.none,
                keyboardType: TextInputType.emailAddress,
                maxLines: 1,
                initialValue: state.email,
                onChanged: (value) {
                  registerUserBloc.addEmail(value);
                },
                hintText: 'Skriv din email her...',
              ),
              SizedBox(height: 30),
              Text(
                'Vil du være blandt de første til at få se de bedste projekter?',
                style: TextStyle(fontSize: 15),
              ),
              SizedBox(height: 10),
              Compliance(
                validator: (v) {},
                initialValue: state.acceptNewLetter,
                text: 'Ja tilmeld mig nyhedsbrev',
                onChange: (value) {
                  registerUserBloc.addNewsLetterAccept(value);
                },
              )
            ],
          );
        },
      ),
    );
  }
}
