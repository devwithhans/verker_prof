// This screen navigates the user to the right screen depending on their auth status

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:verker_prof/features/authentication/bloc/firebase_auth_bloc/firebase_auth_bloc.dart';
import 'package:verker_prof/features/authentication/views/navigationroot.dart';
import 'package:verker_prof/features/authentication/views/register_company/register_company.dart';

import 'package:verker_prof/features/authentication/views/register_user/register_user.dart';
import 'package:verker_prof/features/authentication/views/welcome_view/welcome_view.dart';
import 'package:verker_prof/utils/theme/widgets/components.dart';
import 'package:verker_prof/utils/theme/widgets/loading_indicator.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state.authStatus == AuthStatus.loading) {
          const Center(child: LoadingIndicator());
        }
        if (state.authStatus == AuthStatus.unAuthorised) {
          return WelcomeView();
        }
        if (state.authStatus == AuthStatus.authorised) {
          return NavScreenDeligator();
        }
        if (state.authStatus == AuthStatus.errorAccured) {
          // FirebaseAuth.instance.signOut();
          if (state.errorMessage!.errorName == 'USER_DOES_NOT_EXIST') {
            return RegisterUser();
          }
          if (state.errorMessage!.errorName == 'NO_COMPANY_FOUND') {
            return RegisterCompany();
          }

          return Scaffold(
            body: CenterText(
                'Vi stødte på en fejl, ${state.errorMessage!.frontendMessage}'),
          );
        }

        return const Scaffold(
          body: Center(child: LoadingIndicator()),
        );
      },
    );
  }
}
