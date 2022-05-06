import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:verker_prof/blocs/auth_bloc/auth_bloc.dart';
import 'package:verker_prof/theme/constants/textstyle.dart';
import 'package:verker_prof/theme/widgets/buttons.dart';
import 'package:verker_prof/views/register_company_view/register_company_view.dart';

class NoCompanyView extends StatelessWidget {
  const NoCompanyView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(20),
      child: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Velkommen til verker ${state.user.firstName} 🥳',
                textAlign: TextAlign.center,
                style: kMediumBold,
              ),
              const SizedBox(height: 10),
              const Text(
                'Er du klar til at oprette din virksomhed?',
                textAlign: TextAlign.center,
                style: kLargeBold,
              ),
              const SizedBox(height: 20),
              StandardButton(
                text: 'Opret virksomhed',
                onPressed: () {
                  Navigator.pop(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const CompanyRegistrationView(),
                    ),
                  );
                },
              )
            ],
          );
        },
      ),
    ));
  }
}
