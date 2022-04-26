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
              SizedBox(height: 10),
              Text(
                'Vi kan ikke beskrive hvor meget vi sætter pris på din hjælp. Vi har en drøm om at bygge en platform sammen med vores brugere, og du er derfor altid velkommen til at kontakte os. Hvad syntes du f.eks. der skal være synligt på hjem skærmen?',
              ),
              SizedBox(height: 20),
              Text(
                'Med Venlig hilsen.',
              ),
              SizedBox(height: 5),
              Text(
                'Gustav Brun og Hans-Christian Bøge',
              ),
              SizedBox(height: 20),
              Text(
                'Telefon: 53 86 26 03',
              ),
              SizedBox(height: 5),
              Text(
                'Email: gustav@verker.app',
              ),
            ],
          ),
        );
      },
    );
  }
}
