import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:verker_prof/blocs/auth_bloc/auth_bloc.dart';
import 'package:verker_prof/blocs/register_bloc/register_bloc.dart';
import 'package:verker_prof/models/user.dart';
import 'package:verker_prof/theme/components/standard_input_form.dart';
import 'package:verker_prof/theme/constants/textstyle.dart';
import 'package:verker_prof/widgets/input.dart';

class CompanyFormScreenOne extends StatelessWidget {
  CompanyFormScreenOne({Key? key}) : super(key: key);

  bool showComplianceError = false;

  bool termsAccept = false;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterBloc, RegisterState>(
      builder: (context, state) {
        return BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            return SizedBox(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 70),
                  Text(
                    'Velkommen til verker ${state.user.firstName} 🥳',
                    style: kLargeBold,
                  ),
                  // SizedBox(height: 10),
                  // const Text(
                  //   'Du er endnu ikke tilknyttet en virksomhed, men bare rolig det tager ikke mange minutter at oprette en',
                  //   style: kMediumRegular,
                  // ),
                  SizedBox(height: 10),
                  const Text(
                    'Nu mangler vi bare at oprette din virksomhed. Det tager ikke mange minutter',
                    style: kMediumRegular,
                  )
                ],
              ),
            );
          },
        );
      },
    );
  }
}
