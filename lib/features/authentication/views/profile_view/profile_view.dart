import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:verker_prof/features/authentication/bloc/firebase_auth_bloc/firebase_auth_bloc.dart';
import 'package:verker_prof/features/authentication/bloc/firebase_auth_bloc/firebase_auth_event.dart';
import 'package:verker_prof/features/authentication/models/user.dart';
import 'package:verker_prof/utils/config.dart';
import 'package:verker_prof/utils/theme/constants/textstyle.dart';
import 'package:verker_prof/utils/theme/widgets/buttons.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UserData user = BlocProvider.of<AuthBloc>(context).state.user!;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          height: 150,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              image: NetworkImage(imageUrl +
                  BlocProvider.of<AuthBloc>(context).state.user!.profileImage),
              fit: BoxFit.contain,
            ),
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              '${user.firstName} ${user.lastName}',
              style: kMediumBold,
            ),
            Text(
              '${user.companyId}',
              style: kMediumBold,
            ),
          ],
        ),
        StandardButton(
          onPressed: () {
            BlocProvider.of<AuthBloc>(context).add(LoggedOut());
          },
          text: "Log Ud",
        ),
      ],
    );
  }
}
