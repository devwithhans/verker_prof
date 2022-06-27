import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:verker_prof/features/authentication/bloc/register_company/register_company_cubit.dart';
import 'package:verker_prof/features/authentication/views/register_user/widgets/stepWidget.dart';
import 'package:verker_prof/utils/theme/widgets/verker_input_form.dart';

class CompanyDescription extends StatelessWidget {
  const CompanyDescription({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    RegisterCompanyBloc registerUserBloc = context.read<RegisterCompanyBloc>();

    return StepWidget(
      title: 'Beskriv din virksomhed',
      description:
          'Hvorfor skal kunderne vælge jer frem for konkurrenterne? Skriv en sælgende beskrivelse.',
      child: BlocBuilder<RegisterCompanyBloc, RegisterCompanyState>(
        builder: (context, state) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              VerkerInputForm(
                title: 'Virksomheds beskrivelse',
                validator: (v) {
                  if (v == null || v == '') {
                    return 'Du mangler dette felt';
                  }
                },
                maxLines: 10,
                initialValue: state.description,
                onChanged: (value) {
                  registerUserBloc.addValue(description: value);
                },
                hintText: 'Skriv virksomhedens navn her...',
              ),
              SizedBox(height: 30),
            ],
          );
        },
      ),
    );
  }
}
