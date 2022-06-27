import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:verker_prof/features/authentication/bloc/register_user/register_user_cubit.dart';
import 'package:verker_prof/features/authentication/views/register_user/widgets/select_profile_image.dart';
import 'package:verker_prof/features/authentication/views/register_user/widgets/stepWidget.dart';

class ProfileImage extends StatelessWidget {
  const ProfileImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StepWidget(
      title: 'Sæt ansigt på dig selv',
      description:
          'Personliggør din profil med et profilbillede. Det forbedre også dine chancer for at vinde et tilbud!',
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(height: 90),
          BlocBuilder<RegisterUserBloc, RegisterUserState>(
            builder: (context, state) {
              return SelectProfileImage(
                validator: ((value) {
                  if (state.profileImage == null) {
                    return 'Du skal vælge et profil billede';
                  }
                }),
                profileImageUrl: state.profileImage,
                onPressed: () async {
                  XFile? file = await ImagePicker()
                      .pickImage(source: ImageSource.gallery);

                  if (file != null) {
                    final croppedFile = await ImageCropper().cropImage(
                      sourcePath: file.path,
                      compressFormat: ImageCompressFormat.jpg,
                      compressQuality: 100,
                      aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
                      uiSettings: [
                        AndroidUiSettings(
                            hideBottomControls: true,
                            toolbarTitle: 'Cropper',
                            toolbarColor: Colors.deepOrange,
                            toolbarWidgetColor: Colors.white,
                            initAspectRatio: CropAspectRatioPreset.original,
                            lockAspectRatio: false),
                        IOSUiSettings(
                          title: 'Beskær dit profilbillede',
                          rotateClockwiseButtonHidden: true,
                          rotateButtonsHidden: true,
                          aspectRatioPickerButtonHidden: true,
                          doneButtonTitle: 'Gem',
                          cancelButtonTitle: 'Annuler',
                        ),
                      ],
                    );
                    context
                        .read<RegisterUserBloc>()
                        .addProfileImage(croppedFile!.path);
                  }
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
