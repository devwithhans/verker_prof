import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:verker_prof/blocs/login_bloc/login_bloc.dart';
import 'package:verker_prof/blocs/register_bloc/register_bloc.dart';
import 'package:verker_prof/screens/register_screen/sections/navigation_buttons.dart';
import 'package:verker_prof/screens/register_screen/subscreens/formscreen_one.dart';
import 'package:verker_prof/screens/register_screen/subscreens/formscreen_two.dart';

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
    return BlocProvider(
      create: (context) => RegisterBloc(),
      child: BlocBuilder<RegisterBloc, RegisterState>(
        builder: (context, state) {
          if (state.registerStatus == RegisterStatus.loading) {
            return Center(child: CircularProgressIndicator());
          }
          if (state.registerStatus == RegisterStatus.succes) {
            print(state.registrationModel.email!.toLowerCase());
            print(state.registrationModel.password!);
            context.read<LoginBloc>().add(Login(
                  email: state.registrationModel.email!.toLowerCase(),
                  password: state.registrationModel.password!,
                ));
            Navigator.pop(context);
          }
          return UserRegistrationWrapper(
              formKey: _formKey,
              steps: [
                FormScreenOne(),
                FormScreenTwo(),
              ],
              currentStep: currentStep);
        },
      ),
    );
  }
}

class UserRegistrationWrapper extends StatefulWidget {
  const UserRegistrationWrapper({
    Key? key,
    required GlobalKey<FormState> formKey,
    required this.steps,
    required this.currentStep,
  })  : _formKey = formKey,
        super(key: key);

  final GlobalKey<FormState> _formKey;
  final List<Widget> steps;
  final int currentStep;

  @override
  State<UserRegistrationWrapper> createState() =>
      _UserRegistrationWrapperState();
}

class _UserRegistrationWrapperState extends State<UserRegistrationWrapper> {
  late bool atEnd;
  late bool atStart;
  late int currentStep;

  @override
  void initState() {
    // TODO: implement initState
    currentStep = widget.currentStep;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    atEnd = currentStep == widget.steps.length - 1;
    atStart = currentStep == 0;
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
                  key: widget._formKey,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 100),
                    child: Column(
                      children: widget.steps.map(
                        (e) {
                          return Visibility(
                            maintainState: false,
                            visible: currentStep == widget.steps.indexOf(e),
                            child: e,
                          );
                        },
                      ).toList(),
                    ),
                  ),
                ),
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
                if (widget._formKey.currentState!.validate()) {
                  currentStep = widget.currentStep + 1;
                  setState(() {});
                }
              },
              onSubmit: () {
                if (widget._formKey.currentState!.validate()) {
                  context.read<RegisterBloc>().add(SignUpUser());
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
