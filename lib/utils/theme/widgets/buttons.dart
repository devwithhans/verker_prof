import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:verker_prof/utils/theme/constants/colors.dart';
import 'package:verker_prof/utils/theme/fonts/icons.dart';

class ContinueButton extends StatelessWidget {
  final void Function()? onPressed;
  final String text;

  final Color? backgroundColor;
  final Color? textColor;
  final bool nextIcon;

  const ContinueButton({
    Key? key,
    this.nextIcon = false,
    required this.onPressed,
    this.backgroundColor = Colors.white,
    this.text = 'button',
    this.textColor = Colors.black,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
      onPressed: onPressed,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      fillColor: backgroundColor,
      child: Row(
        mainAxisAlignment: nextIcon
            ? MainAxisAlignment.spaceBetween
            : MainAxisAlignment.center,
        children: [
          Text(text,
              style: TextStyle(
                  fontSize: 18, fontWeight: FontWeight.bold, color: textColor)),
          Visibility(
            visible: nextIcon,
            child: RotatedBox(
              quarterTurns: 1,
              child: SvgPicture.asset(
                "assets/icons/up-arrow.svg",
                color: textColor,
                semanticsLabel: 'Acme Logo',
                width: 40,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class StandardButton extends StatelessWidget {
  final void Function()? onPressed;
  final String text;
  final bool disabled;
  final Color? backgroundColor;
  final Color? textColor;
  final bool secondary;

  const StandardButton({
    Key? key,
    this.secondary = false,
    required this.onPressed,
    this.disabled = false,
    this.backgroundColor = Colors.white,
    this.text = 'button',
    this.textColor = Colors.black,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      key: key,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      onPressed: disabled ? () {} : onPressed,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      fillColor: disabled
          ? Colors.grey
          : secondary
              ? kColorSecondary
              : kColorPrimary,
      child: Text(
        text,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w500,
          color: secondary ? kColorPrimary : kColorSecondary,
        ),
      ),
    );
  }
}

class KIconButton extends StatelessWidget {
  final void Function()? onPressed;
  final String text;
  final Color? backgroundColor;
  final Color? textColor;
  final IconData? icon;

  const KIconButton({
    Key? key,
    required this.onPressed,
    this.icon = VerkerIcons.camera,
    this.backgroundColor = Colors.white,
    this.text = 'Tag ny video eller foto',
    this.textColor = Colors.black,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: RawMaterialButton(
        elevation: 0,
        splashColor: null,
        highlightColor: null,
        focusColor: null,
        hoverColor: null,
        focusElevation: 0,
        highlightElevation: 0,
        shape: RoundedRectangleBorder(
          side: BorderSide(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(7),
        ),
        onPressed: onPressed,
        // padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
        fillColor: Colors.transparent,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon),
            const SizedBox(
              width: 10,
            ),
            Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: textColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class HorizontalNavigationButtons extends StatelessWidget {
  final int index;
  final int length;
  final String nextText;
  final String backText;
  final String startText;
  final String submitText;

  final void Function()? onNext;
  final void Function()? onSubmit;
  final void Function()? onBack;

  const HorizontalNavigationButtons({
    Key? key,
    required this.index,
    required this.length,
    this.backText = 'Forrige',
    this.nextText = 'Fortsæt',
    this.startText = 'Fortsæt',
    this.submitText = 'Registrer',
    this.onNext,
    this.onSubmit,
    this.onBack,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (index == 0) {
      return Row(
        children: [
          Expanded(
            child: StandardButton(
              text: startText,
              backgroundColor: Colors.black,
              textColor: Colors.white,
              onPressed: onNext,
            ),
          ),
        ],
      );
    }
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: StandardButton(
            text: backText,
            backgroundColor: Colors.grey.shade600,
            textColor: Colors.white,
            onPressed: onBack,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          flex: 3,
          child: StandardButton(
            text: index == length ? submitText : nextText,
            backgroundColor: Colors.black,
            textColor: Colors.white,
            onPressed: index == length ? onSubmit : onNext,
          ),
        ),
      ],
    );
  }
}

class LinkTekst extends StatelessWidget {
  final void Function() onPressed;
  final String beforeText;
  final String linkText;
  final double fontSize;

  const LinkTekst(
      {Key? key,
      required this.onPressed,
      this.beforeText = '',
      this.linkText = '',
      this.fontSize = 16})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(beforeText,
            style: TextStyle(
              fontSize: fontSize,
            )),
        GestureDetector(
          onTap: onPressed,
          child: Container(
            color: Colors.transparent,
            padding: const EdgeInsets.all(3),
            child: Text(linkText,
                style: TextStyle(
                  decoration: TextDecoration.underline,
                  fontSize: fontSize,
                )),
          ),
        )
      ],
    );
  }
}
