import 'package:flutter/material.dart';
import 'package:verker_prof/utils/theme/constants/colors.dart';
import 'package:verker_prof/utils/theme/fonts/icons.dart';

class SelectProfileImage extends StatelessWidget {
  const SelectProfileImage({
    required this.onPressed,
    this.validator,
    this.profileImageUrl,
    Key? key,
  }) : super(key: key);

  final void Function() onPressed;
  final String? Function(Object? value)? validator;
  final String? profileImageUrl;

  @override
  Widget build(BuildContext context) {
    return FormField(
      validator: validator,
      builder: (field) => Column(
        children: [
          GestureDetector(
            onTap: onPressed,
            child: Container(
              height: 240,
              width: 240,
              decoration: BoxDecoration(
                image: profileImageUrl == null
                    ? null
                    : DecorationImage(
                        image: AssetImage(profileImageUrl!),
                        fit: BoxFit.fitHeight),
                color: Color(0xffF2F2F2),
                shape: BoxShape.circle,
              ),
              child: profileImageUrl != null
                  ? SizedBox()
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(
                          VerkerIcons.picture,
                          color: kGreyText,
                          size: 40,
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Vælg profilbillede',
                          style: TextStyle(color: kGreyColor),
                        )
                      ],
                    ),
            ),
          ),
          SizedBox(height: 10),
          Text(
            field.errorText ?? '',
            style: TextStyle(color: Colors.red),
          )
        ],
      ),
    );
  }
}
