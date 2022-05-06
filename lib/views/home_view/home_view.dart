import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:verker_prof/blocs/auth_bloc/auth_bloc.dart';
import 'package:verker_prof/theme/constants/textstyle.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Kære ${state.user.firstName}',
                style: kMediumBold,
              ),
              const SizedBox(height: 10),
              const Text(
                'Vi kan ikke beskrive hvor meget vi sætter pris på din hjælp. Vi har en drøm om at bygge en platform sammen med vores brugere, og du er derfor altid velkommen til at kontakte os. Hvad syntes du f.eks. der skal være synligt på hjem skærmen?',
              ),
              const SizedBox(height: 20),
              const Text(
                'Med Venlig hilsen.',
              ),
              const SizedBox(height: 5),
              const Text(
                'Gustav Brun og Hans-Christian Bøge',
              ),
              const SizedBox(height: 20),
              const Text(
                'Telefon: 53 86 26 03',
              ),
              const SizedBox(height: 5),
              const Text(
                'Email: gustav@verker.app',
              ),
            ],
          ),
        );
      },
    );
  }
}
