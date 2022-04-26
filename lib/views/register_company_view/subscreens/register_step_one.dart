import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:verker_prof/blocs/company_register_bloc/company_register_bloc.dart';
import 'package:verker_prof/theme/components/standard_input_form.dart';

class CompanyFormScreenOne extends StatelessWidget {
  CompanyFormScreenOne({Key? key}) : super(key: key);

  bool showComplianceError = false;

  bool termsAccept = false;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CompanyRegisterBloc, CompanyRegisterState>(
      builder: (context, state) {
        return Column(
          children: [
            StandardInputForm(
              initialValue: state.companyModel.name ?? '',
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Feltet må ikke være tomt';
                }
                return null;
              },
              textCapitalization: TextCapitalization.words,
              onChanged: (v) {
                context.read<CompanyRegisterBloc>().add(
                      AddValues(name: v),
                    );
              },
              title: 'Virksomhedens navn.',
              hintText: 'Virksomhedens navn.',
            ),
          ],
        );
      },
    );
  }
}
