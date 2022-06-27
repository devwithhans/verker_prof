import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:verker_prof/utils/services/verker_backend/errors.dart';
import 'package:verker_prof/utils/theme/constants/colors.dart';
import 'package:verker_prof/utils/theme/widgets/navigation_buttons.dart';

List<String> items = ['1', '2', '3', '4'];

class StepForm extends StatelessWidget {
  const StepForm({
    Key? key,
    required this.stepTitles,
    this.validIndexes = const [],
    this.errorMessage,
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
  final GlobalKey formKey;
  final int currentStep;
  final List<String> stepTitles;

  final void Function() onNext;
  final void Function() onPrevius;
  final void Function() onSubmit;
  final List<int> validIndexes;
  final ErrorMessage? errorMessage;
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
      appBar: AppBar(
        toolbarHeight: 0,
        automaticallyImplyLeading: false,
      ),
      body: Stack(
        children: [
          ListView(
            children: [
              SizedBox(height: 10),
              Container(
                constraints: BoxConstraints(
                    minHeight: MediaQuery.of(context).size.height - 140),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Column(
                        children: [
                          Text(stepTitles[currentStep]),
                          SizedBox(height: 10),
                          LinearProgressIndicator(
                            value: currentStep / steps.length,
                            color: Colors.black,
                            backgroundColor: kGreyColor,
                          ),
                        ],
                      ),
                    ),

                    // StepIndicator(
                    //   validIndexes: validIndexes,
                    //   steps: steps.length,
                    //   currentStep: currentStep,
                    //   titles: stepTitles,
                    // ),
                    const SizedBox(height: 10),
                    Form(
                      key: formKey,
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
                    Text(
                      errorMessage != null ? errorMessage!.frontendMessage : '',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.red),
                    ),
                    SizedBox(height: 100),
                  ],
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: NavigationButtons(
                nextText: nextText,
                startText: startText,
                backText: backText,
                submitText: submitText,
                atEnd: atEnd,
                atStart: atStart,
                onNext: onNext,
                onPrevius: onPrevius,
                onSubmit: onSubmit),
          )
        ],
      ),
    );
  }
}

class StepIndicator extends StatelessWidget {
  final bool visible;
  final int currentStep;
  final int steps;
  final List<int> validIndexes;
  final List<String> titles;
  const StepIndicator({
    required this.validIndexes,
    required this.titles,
    this.visible = true,
    required this.steps,
    required this.currentStep,
    Key? key,
  }) : super(key: key);

  List<Widget> getSteps() {
    List<Widget> widgets = [];
    int count = 1;
    while (count <= steps) {
      bool done = currentStep >= count - 1;
      bool valid = validIndexes.contains(count - 1);
      bool isCurrentStep = currentStep == count - 1;
      widgets.add(
        Container(
          width: 100,
          child: Column(
            children: [
              Text(
                titles[count - 1],
                style: TextStyle(
                  color: isCurrentStep
                      ? Colors.black
                      : done || valid
                          ? kGreenColor
                          : kGreyColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 8),
              Container(
                width: 90,
                height: 4,
                decoration: BoxDecoration(
                    color: isCurrentStep
                        ? Colors.black
                        : done || valid
                            ? kGreenColor
                            : kGreyColor,
                    borderRadius: BorderRadius.all(Radius.circular(100))),
              )
            ],
          ),
        ),
      );

      count = count + 1;
    }

    return widgets;
  }

  @override
  Widget build(BuildContext context) {
    return LinearProgressIndicator(
      value: 0.5,
    );
    // SizedBox(
    //   width: double.infinity,
    //   height: 50,
    //   child: ListView(
    //     padding: EdgeInsets.only(left: 5, right: 5),
    //     scrollDirection: Axis.horizontal,
    //     children: getSteps(),
    //   ),
    // );
  }
}




// Container(
//       decoration: BoxDecoration(
//         shape: BoxShape.circle,
//         color: !visible
//             ? Colors.transparent
//             : currentStep
//                 ? Colors.black
//                 : Colors.grey,
//       ),
//       width: 40,
//       height: 40,
//       child: Center(
//           child: Text(step.toString(),
//               style: !visible
//                   ? TextStyle(color: Colors.transparent)
//                   : kSmallBoldWhite)),
//     );
