import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:verker_prof/blocs/register_bloc/register_bloc.dart';
import 'package:verker_prof/theme/widgets/standard_input_form.dart';

class FormScreenTwo extends StatelessWidget {
  const FormScreenTwo({Key? key}) : super(key: key);

  final bool showComplianceError = false;

  final bool termsAccept = false;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterBloc, RegisterState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
              StandardInputForm(
                obscureText: true,
                keyboardType: TextInputType.visiblePassword,
                initialValue: state.registrationModel.password ?? '',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  if (value.length < 8) {
                    return 'Dit kodeord skal minimum bestå af 8 tegn';
                  }
                  return null;
                },
                textCapitalization: TextCapitalization.none,
                onChanged: (v) {
                  context.read<RegisterBloc>().add(
                        AddValues(password: v),
                      );
                },
                title: 'Password.',
                hintText: 'Skriv et stærk kodeord',
              ),
              StandardInputForm(
                obscureText: true,
                keyboardType: TextInputType.visiblePassword,
                initialValue: state.registrationModel.validationPassword ?? '',
                validator: (value) {
                  if (value != state.registrationModel.password) {
                    return 'Kodeordet macher ikke det første';
                  }
                  return null;
                },
                textCapitalization: TextCapitalization.none,
                onChanged: (v) {
                  context.read<RegisterBloc>().add(
                        AddValues(validationPassword: v),
                      );
                },
                title: 'Gentag password.',
                hintText: 'Gentag kodeord',
              ),
            ],
          ),
        );
      },
    );
  }
}
