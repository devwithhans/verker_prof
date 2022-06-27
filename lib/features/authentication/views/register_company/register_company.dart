import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:verker_prof/features/authentication/bloc/firebase_auth_bloc/firebase_auth_bloc.dart';
import 'package:verker_prof/features/authentication/views/register_company/step_wrapper.dart';
import 'package:verker_prof/utils/theme/constants/colors.dart';
import 'package:verker_prof/utils/theme/widgets/buttons.dart';
import 'package:verker_prof/utils/theme/widgets/components.dart';

class RegisterCompany extends StatelessWidget {
  const RegisterCompany({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AuthBloc authBloc = BlocProvider.of<AuthBloc>(context);

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Hej ${authBloc.state.user!.firstName}',
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
            ),
            const SizedBox(height: 10),
            const Text(
              'Vi mangler kun lige at oprette din virksomhed. Er du frisk på det?',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 15, color: kGreyText),
            ),
            const SizedBox(height: 20),
            StandardButton(
              text: 'Opret min virksomhed',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => RegisterCompanyStepWrapper(),
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
