import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:verker_prof/blocs/company_register_bloc/company_register_bloc.dart';
import 'package:verker_prof/theme/components/standard_input_form.dart';
import 'package:verker_prof/theme/constants/textstyle.dart';
import 'package:verker_prof/widgets/input.dart';

class StartScreen extends StatelessWidget {
  StartScreen({Key? key}) : super(key: key);

  bool showComplianceError = false;

  bool termsAccept = false;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CompanyRegisterBloc, CompanyRegisterState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Før vi kan komme videre skal du tilknyttes, en virksomhed. Tryk på knappen nederst for at oprette din virksomhed',
                style: kMediumRegular,
              ),
            ],
          ),
        );
      },
    );
  }

  Row textRow({required String before, required String after}) {
    return Row(
      children: [
        Text(
          '$before: ',
          style: kSmallBold,
        ),
        Text(after)
      ],
    );
  }
}
