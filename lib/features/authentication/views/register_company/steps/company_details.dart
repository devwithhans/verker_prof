import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:verker_prof/features/authentication/bloc/register_company/register_company_cubit.dart';
import 'package:verker_prof/features/authentication/views/register_user/widgets/stepWidget.dart';
import 'package:verker_prof/utils/theme/widgets/verker_input_form.dart';

class CompanyDetails extends StatelessWidget {
  const CompanyDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    RegisterCompanyBloc registerUserBloc = context.read<RegisterCompanyBloc>();
    final _cvrFormatter = MaskTextInputFormatter(
      mask: '########',
      filter: {
        "#": RegExp(r'[0-9]'),
      },
    );
    final _mobileFormatter = MaskTextInputFormatter(
      mask: '## ## ## ##',
      filter: {
        "#": RegExp(r'[0-9]'),
      },
    );
    final _yearFormatter = MaskTextInputFormatter(
      mask: '####',
      filter: {
        "#": RegExp(r'[0-9]'),
      },
    );

    return StepWidget(
      title: 'Basal info om din virksomhed',
      description:
          'Lad os starte stille og roligt ud med det mest basale omkring dig.',
      child: BlocBuilder<RegisterCompanyBloc, RegisterCompanyState>(
        builder: (context, state) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              VerkerInputForm(
                title: 'Virksomhedens navn',
                validator: (v) {
                  if (v == null || v == '') {
                    return 'Du mangler dette felt';
                  }
                },
                maxLines: 1,
                initialValue: state.companyName,
                onChanged: (value) {
                  registerUserBloc.addValue(companyName: value);
                },
                hintText: 'Skriv virksomhedens navn her...',
              ),
              SizedBox(height: 30),
              VerkerInputForm(
                title: 'CVR nummer',
                validator: (v) {
                  if (v == null || v.length < 8) {
                    return 'Skriv et gyldigt CVR nummer';
                  }
                },
                inputFormatters: [_cvrFormatter],
                keyboardType: TextInputType.number,
                maxLines: 1,
                initialValue: state.cvr,
                onChanged: (value) {
                  registerUserBloc.addValue(cvr: value);
                },
                hintText: 'Skriv dit CVR nummer her...',
              ),
              SizedBox(height: 30),
              VerkerInputForm(
                title: 'Virksomhedens email',
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
                  registerUserBloc.addValue(email: value);
                },
                hintText: 'Skriv din email her...',
              ),
              SizedBox(height: 30),
              VerkerInputForm(
                title: 'Virksomhedens telefonnummer',
                prefixIcon: const Center(
                  child: Text(
                    ' +45',
                    style:
                        TextStyle(color: Colors.black, fontSize: 16, height: 1),
                  ),
                ),
                keyboardType: TextInputType.phone,
                initialValue: state.phone,
                inputFormatters: [_mobileFormatter],
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Feltet må ikke være tomt';
                  }
                  if (value.length != 11) {
                    return 'Angiv venligst et rigtigt telefonnummer';
                  }
                  return null;
                },
                textCapitalization: TextCapitalization.words,
                onChanged: (v) {
                  registerUserBloc.addValue(phone: v);
                },
                hintText: 'Dit telefonnummer',
              ),
              SizedBox(height: 30),
              VerkerInputForm(
                title: 'Stiftelses år',
                keyboardType: TextInputType.number,
                initialValue: state.established,
                inputFormatters: [_yearFormatter],
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Feltet må ikke være tomt';
                  }
                  if (value.length != 4) {
                    return 'Angiv venligst et rigtigt årstal';
                  }
                  return null;
                },
                textCapitalization: TextCapitalization.words,
                onChanged: (v) {
                  registerUserBloc.addValue(established: v);
                },
                hintText: 'Skriv året for stiftelse af virksomheden',
              ),
              SizedBox(height: 30),
              VerkerInputForm(
                title: 'Antal ansatte',
                keyboardType: TextInputType.number,
                initialValue: state.employees,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Feltet må ikke være tomt';
                  }
                  return null;
                },
                textCapitalization: TextCapitalization.words,
                onChanged: (v) {
                  registerUserBloc.addValue(employees: v);
                },
                hintText: 'Skriv antal ansatte her...',
              ),
            ],
          );
        },
      ),
    );
  }
}
