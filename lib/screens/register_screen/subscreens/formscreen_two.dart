import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:verker_prof/blocs/register_bloc/register_bloc.dart';
import 'package:verker_prof/theme/components/standard_input_form.dart';
import 'package:verker_prof/widgets/input.dart';

class FormScreenTwo extends StatelessWidget {
  const FormScreenTwo({Key? key, required this.formKey}) : super(key: key);

  final formKey;

  @override
  Widget build(BuildContext context) {
    bool showComplianceError = false;
    bool termsAccept = false;

    return Form(
        key: formKey,
        child: BlocBuilder<RegisterBloc, RegisterState>(
          builder: (context, state) {
            RegisterBloc registerBloc = context.read<RegisterBloc>();
            final _controller = TextEditingController()
              ..text = state.registrationModel.profileImage ?? ''
              ..selection = TextSelection.collapsed(
                  offset: (state.registrationModel.profileImage ?? 'd').length);
            return Column(
              children: [
                StandardInputForm(
                  controller: _controller,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                  textCapitalization: TextCapitalization.words,
                  onChanged: (v) {
                    registerBloc.add(
                      AddValues(
                        state.registrationModel.copyWith(
                          profileImage: v,
                        ),
                      ),
                    );
                  },
                  title: 'prifl.',
                  hintText: 'Dit fornavn og efternavn',
                ),
                // StandardInputForm(
                //   initialValue: state.registrationModel.email ?? '',
                //   onChanged: (v) {
                //     registerBloc.add(
                //         AddValues(state.registrationModel.copyWith(email: v)));
                //   },
                //   validator: (value) {
                //     if (value == null || value.isEmpty) {
                //       return 'Indtast venligst et navn';
                //     }
                //     bool emailValid = RegExp(
                //             r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                //         .hasMatch(value);
                //     if (!emailValid) {
                //       return 'Indtast venligst en gyldig mail';
                //     }
                //   },
                //   keyboardType: TextInputType.emailAddress,
                //   title: 'Email.',
                //   hintText: 'Din email',
                // ),
                // SizedBox(
                //   height: 20,
                // ),
                Compliance(
                  showError: showComplianceError,
                  errorText: 'Du skal godkende vores vilkår',
                  value: termsAccept,
                  text: 'Accepterer du vores vilkår?',
                  onChange: () {
                    termsAccept = !termsAccept;
                    // setState(() {});
                  },
                )
              ],
            );
          },
        ));
  }
}
