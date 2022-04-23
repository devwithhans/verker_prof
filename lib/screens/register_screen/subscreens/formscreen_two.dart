import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:verker_prof/blocs/register_bloc/register_bloc.dart';
import 'package:verker_prof/theme/components/standard_input_form.dart';
import 'package:verker_prof/widgets/input.dart';

class FormScreenTwo extends StatelessWidget {
  FormScreenTwo({Key? key}) : super(key: key);

  bool showComplianceError = false;

  bool termsAccept = false;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterBloc, RegisterState>(
      builder: (context, state) {
        return Column(
          children: [
            StandardInputForm(
              keyboardType: TextInputType.phone,
              initialValue: state.registrationModel.phone ?? '',
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
              textCapitalization: TextCapitalization.words,
              onChanged: (v) {
                context.read<RegisterBloc>().add(
                      AddValues(phone: v),
                    );
              },
              title: 'Telefonnummer.',
              hintText: 'Dit telefonnummer',
            ),
            StandardInputForm(
              initialValue: state.registrationModel.email ?? '',
              onChanged: (v) {
                context.read<RegisterBloc>().add(AddValues(email: v));
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
          ],
        );
      },
    );
  }
}
