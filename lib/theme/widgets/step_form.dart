import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:verker_prof/theme/constants/textstyle.dart';
import 'package:verker_prof/theme/widgets/navigation_buttons.dart';

class StepForm extends StatelessWidget {
  StepForm({
    Key? key,
    required this.title,
    required this.currentStep,
    required this.formKey,
    required this.steps,
    this.startText = 'Start',
    this.backText = 'Tilbage',
    this.nextText = 'Næste',
    this.submitText = 'Submit',
    required this.onNext,
    required this.onPrevius,
    required this.onSubmit,
  }) : super(key: key);

  final List<Widget> steps;
  final formKey;
  final int currentStep;

  final void Function() onNext;
  final void Function() onPrevius;
  final void Function() onSubmit;

  final String title;
  final String nextText;
  final String startText;
  final String submitText;
  final String backText;

  @override
  Widget build(BuildContext context) {
    bool atEnd = currentStep == steps.length - 1;
    bool atStart = currentStep == 0;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle.dark,
      ),
      body: Stack(
        children: [
          ListView(
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                child: Text(
                  title,
                  style: kLargeBold,
                ),
              ),
              SizedBox(height: 20),
              Form(
                key: formKey,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 100),
                  child: Column(
                    children: steps.map(
                      (e) {
                        return Visibility(
                          maintainState: false,
                          visible: currentStep == steps.indexOf(e),
                          child: e,
                        );
                      },
                    ).toList(),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: NavigationButtons(
                startText: 'Fortsæt',
                atEnd: atEnd,
                atStart: atStart,
                submitText: submitText,
                nextText: nextText,
                backText: backText,
                onPrevius: () {
                  onPrevius();
                },
                onNext: () {
                  onNext();
                },
                onSubmit: onSubmit),
          ),
        ],
      ),
    );
  }
}
