import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:verker_prof/blocs/register_bloc/register_bloc.dart';
import 'package:verker_prof/theme/widgets/input.dart';
import 'package:verker_prof/theme/widgets/standard_input_form.dart';

class FormScreenOne extends StatelessWidget {
  FormScreenOne({Key? key}) : super(key: key);

  bool showComplianceError = false;

  bool termsAccept = false;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterBloc, RegisterState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
              StandardInputForm(
                initialValue: state.registrationModel.firstName ?? '',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Feltet må ikke være tomt';
                  }
                  return null;
                },
                textCapitalization: TextCapitalization.words,
                onChanged: (v) {
                  context.read<RegisterBloc>().add(
                        AddValues(firstName: v),
                      );
                },
                title: 'Fornavn.',
                hintText: 'Dit fornavn',
              ),
              StandardInputForm(
                initialValue: state.registrationModel.lastName ?? '',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Feltet må ikke være tomt';
                  }
                  return null;
                },
                textCapitalization: TextCapitalization.words,
                onChanged: (v) {
                  context.read<RegisterBloc>().add(
                        AddValues(lastName: v),
                      );
                },
                title: 'Efternavn.',
                hintText: 'Dit efternavn',
              ),
              StandardInputForm(
                keyboardType: TextInputType.phone,
                initialValue: state.registrationModel.phone ?? '',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Feltet må ikke være tomt';
                  }
                  if (value.length != 8) {
                    return 'Angiv venligst et rigtigt telefonnummer';
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
              // SizedBox(
              //   height: 20,
              // ),
              Compliance(
                validator: (v) {
                  if (v != null && !v) {
                    print('not validated');
                    return 'Du skal godkende vores vilkår';
                  }
                },
                showError: showComplianceError,
                errorText: 'Du skal godkende vores vilkår',
                initialValue: state.registrationModel.termsAcceptet ?? false,
                text: 'Accepterer du vores vilkår?',
                onChange: (v) {
                  context.read<RegisterBloc>().add(
                        AddValues(termsAcceptet: v),
                      );
                },
              )
            ],
          ),
        );
      },
    );
  }
}
