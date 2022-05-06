import 'package:flutter/material.dart';
import 'package:verker_prof/theme/widgets/buttons.dart';

class NavigationButtons extends StatelessWidget {
  const NavigationButtons({
    Key? key,
    this.startText = 'Start',
    this.backText = 'Tilbage',
    this.nextText = 'Næste',
    this.submitText = 'Submit',
    required this.atEnd,
    required this.atStart,
    required this.onNext,
    required this.onPrevius,
    required this.onSubmit,
  }) : super(key: key);

  final bool atEnd;
  final bool atStart;
  final void Function() onNext;
  final void Function() onPrevius;
  final void Function() onSubmit;

  final String nextText;
  final String startText;
  final String submitText;
  final String backText;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
        child: Row(
          children: [
            !atStart
                ? Expanded(
                    child: StandardButton(
                      onPressed: onPrevius,
                      text: backText,
                    ),
                  )
                : const SizedBox(),
            SizedBox(width: !atStart ? 10 : 0),
            !atEnd
                ? Expanded(
                    child: StandardButton(
                      onPressed: onNext,
                      text: atStart ? startText : nextText,
                    ),
                  )
                : Expanded(
                    child: StandardButton(
                      onPressed: onSubmit,
                      text: submitText,
                    ),
                  )
          ],
        ),
      ),
    );
  }
}
