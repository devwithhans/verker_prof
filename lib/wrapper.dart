import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:verker_prof/blocs/auth_bloc/auth_bloc.dart';
import 'package:verker_prof/theme/widgets/components.dart';
import 'package:verker_prof/theme/widgets/loading_indicator.dart';
import 'package:verker_prof/views/navigation_root/navigationroot.dart';
import 'package:verker_prof/views/register_company_view/register_company_view.dart';
import 'package:verker_prof/views/welcome_view/welcome_view.dart';

// This screen navigates the user to the right screen depending on their auth status

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state is AuthLoading) {
          const Center(child: LoadingIndicator());
        }
        if (state is UnAuthorised) {
          return const WelcomeView();
        }
        if (state is Authorised) {
          return const NavScreenDeligator();
        }
        if (state is ErrorAccured) {
          return const Scaffold(
            body: CenterText('Vi stødte på en fejl'),
          );
        }
        if (state is NoCompany) {
          return const CompanyRegistrationView();
        }
        return const Scaffold(
          body: Center(child: LoadingIndicator()),
        );
      },
    );
  }
}
