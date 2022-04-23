import 'package:flutter/material.dart';
import 'package:verker_prof/widgets/buttons.dart';

class NavigationButtons extends StatelessWidget {
  const NavigationButtons({
    Key? key,
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

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
        child: Row(
          children: [
            !atStart
                ? Expanded(
                    child: StandardButton(
                      onPressed: onPrevius,
                      text: 'Tilbage',
                    ),
                  )
                : SizedBox(),
            SizedBox(width: !atStart ? 10 : 0),
            !atEnd
                ? Expanded(
                    child: StandardButton(
                      onPressed: onNext,
                      text: 'Næste',
                    ),
                  )
                : Expanded(
                    child: StandardButton(
                      onPressed: onSubmit,
                      text: "Sign Up",
                    ),
                  )
          ],
        ),
      ),
    );
  }
}
