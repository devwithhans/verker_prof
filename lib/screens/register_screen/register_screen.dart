import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:verker_prof/blocs/register_bloc/register_bloc.dart';
import 'package:verker_prof/screens/register_screen/subscreens/formscreen_one.dart';
import 'package:verker_prof/screens/register_screen/subscreens/formscreen_two.dart';
import 'package:verker_prof/theme/components/verker_button.dart';
import 'package:verker_prof/widgets/buttons.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({Key? key}) : super(key: key);

  static String name = "RegisterScreen";
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    List<Widget> steps = [
      FormScreenOne(formKey: _formKey),
      FormScreenTwo(formKey: _formKey)
    ];

    return BlocProvider<RegisterBloc>(
      create: (context) => RegisterBloc(),
      child: Scaffold(
        appBar: AppBar(),
        body:
            BlocBuilder<RegisterBloc, RegisterState>(builder: (context, state) {
          bool validForm = true;
          RegisterBloc registerBloc = context.read<RegisterBloc>();
          bool atStart = state.screen == 0;
          bool atEnd = state.screen == steps.length - 1;

          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Opret dig.',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                        )),
                    const SizedBox(
                      height: 20,
                    ),
                    steps[state.screen],
                  ],
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 20, 20, 30),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        atEnd
                            ? StandardButton(
                                onPressed: () {},
                                text: "Sign Up",
                              )
                            : SizedBox(),
                        SizedBox(height: 20),
                        Row(
                          children: [
                            !atStart
                                ? Expanded(
                                    child: VerkerButton(
                                      active: true,
                                      onPressed: () {
                                        registerBloc
                                            .add(GoToStep(state.screen - 1));
                                      },
                                      text: 'Tilbage',
                                    ),
                                  )
                                : SizedBox(),
                            SizedBox(width: !atStart ? 10 : 0),
                            !atEnd
                                ? Expanded(
                                    child: VerkerButton(
                                      active: validForm,
                                      onPressed: () {
                                        if (_formKey.currentState!.validate()) {
                                          registerBloc
                                              .add(GoToStep(state.screen + 1));
                                        }
                                      },
                                      text: 'Næste',
                                    ),
                                  )
                                : SizedBox(),
                          ],
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          );
        }),
      ),
    );
  }
}
