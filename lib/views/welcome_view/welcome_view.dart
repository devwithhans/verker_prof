import 'package:flutter/material.dart';
import 'package:verker_prof/theme/widgets/buttons.dart';
import 'package:verker_prof/views/login_view/login_view.dart';
import 'package:verker_prof/views/register_view/register_view.dart';

class WelcomeView extends StatelessWidget {
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
                      RegisterView.name,
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
                      LoginView.name,
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
