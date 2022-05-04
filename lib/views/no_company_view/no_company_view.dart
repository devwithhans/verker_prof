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
      padding: EdgeInsets.all(20),
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
              SizedBox(height: 10),
              Text(
                'Er du klar til at oprette din virksomhed?',
                textAlign: TextAlign.center,
                style: kLargeBold,
              ),
              SizedBox(height: 20),
              StandardButton(
                text: 'Opret virksomhed',
                onPressed: () {
                  Navigator.pop(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CompanyRegistrationView(),
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
