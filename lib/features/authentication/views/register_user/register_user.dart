import 'package:flutter/material.dart';
import 'package:verker_prof/features/authentication/views/register_user/step_wrapper.dart';
import 'package:verker_prof/utils/theme/constants/colors.dart';
import 'package:verker_prof/utils/theme/widgets/buttons.dart';

class RegisterUser extends StatelessWidget {
  const RegisterUser({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const String text = '''
Vi har vist ikke mødt hinanden før? 

Jeg er din kommende favorit platform til at finde spændende opgaver og håndtere dine ordrer.

Nu er det din tur til at introducere dig selv, tryk herunder for komme igang:''';
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Velkommen til Verker!',
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
            ),
            const SizedBox(height: 10),
            const Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 15, color: kGreyText),
            ),
            const SizedBox(height: 20),
            StandardButton(
              text: 'Introducer dig selv',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => RegisterUserStepWraper(),
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
