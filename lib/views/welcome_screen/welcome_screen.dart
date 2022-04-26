import 'package:flutter/material.dart';
import 'package:verker_prof/screens/login_screens/sections.dart/login.dart';
import 'package:verker_prof/screens/register_screen/register_screen.dart';
import 'package:verker_prof/widgets/buttons.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/verkerbg.jpg"),
                  fit: BoxFit.cover,
                ),
              ),
              child: null),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Image(
                  image: AssetImage('assets/VerkerLogoBig.png'),
                  height: 60,
                ),
                const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30.0),
                    child: Text(
                      'Lad os opfylde renovations drømmende, strygt og effektivt',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                      textAlign: TextAlign.center,
                    )),
                SizedBox(
                  height: 40,
                ),
                ContinueButton(
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      RegisterScreen.name,
                    );
                  },
                  nextIcon: true,
                  text: 'Opret bruger',
                ),
                SizedBox(height: 20),
                ContinueButton(
                  textColor: Colors.white,
                  backgroundColor: Colors.black,
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      LoginScreen.name,
                    );
                  },
                  nextIcon: true,
                  text: 'Log ind',
                ),
                SizedBox(
                  height: 60,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
