import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:verker_prof/blocs/register_bloc/register_bloc.dart';
import 'package:verker_prof/screens/register_screen/sections/navigation_buttons.dart';
import 'package:verker_prof/screens/register_screen/subscreens/formscreen_one.dart';
import 'package:verker_prof/screens/register_screen/subscreens/formscreen_two.dart';
import 'package:verker_prof/widgets/components.dart';

class RegisterScreen extends StatefulWidget {
  RegisterScreen({Key? key}) : super(key: key);

  static String name = "RegisterScreen";

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  int currentStep = 0;

  @override
  Widget build(BuildContext context) {
    List<Widget> steps = [
      FormScreenOne(),
      FormScreenTwo(),
    ];
    bool atEnd = currentStep == steps.length - 1;
    bool atStart = currentStep == 0;

    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          leadingWidth: 80,
          leading: IconButton(
            color: Colors.black,
            splashRadius: 20,
            focusColor: Colors.black,
            splashColor: Colors.black,
            highlightColor: Colors.black,
            icon: Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                  color: Colors.black, borderRadius: BorderRadius.circular(20)),
              child: const Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
          child: Stack(
            children: [
              ListView(
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Opret dig.',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                      )),
                  const SizedBox(
                    height: 20,
                  ),
                  Form(
                    key: _formKey,
                    child: BlocProvider(
                      create: (context) => RegisterBloc(),
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 100),
                        child: Column(
                            children: steps.map((e) {
                          return Visibility(
                            maintainState: false,
                            visible: currentStep == steps.indexOf(e),
                            child: e,
                          );
                        }).toList()),
                      ),
                    ),
                  )
                ],
              ),
              NavigationButtons(
                atEnd: atEnd,
                atStart: atStart,
                onPrevius: () {
                  currentStep--;

                  setState(() {});
                },
                onNext: () {
                  if (_formKey.currentState!.validate()) {
                    currentStep = currentStep + 1;
                    setState(() {});
                  }
                },
                onSubmit: () {},
              )
            ],
          ),
        ));
  }
}
