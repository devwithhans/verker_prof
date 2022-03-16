import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:verker_prof/blocs/auth_bloc/auth_bloc.dart';
import 'package:verker_prof/screens/login_screens/welcome.dart';
import 'package:verker_prof/screens/navigation_screens/navigationroot.dart';

// This screen navigates the user to the right screen depending on their auth status

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        print(state);
        if (state is UnAuthorised) {
          return WelcomeScreen();
        }
        if (state is Authorised) {
          return NavScreenDeligator();
        }
        if (state is ErrorAccured) {
          // return ErrorScreen();
          return NavScreenDeligator();
        }
        return const Scaffold(
          body: Center(),
        );
      },
    );
  }
}
