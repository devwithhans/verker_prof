import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:graphql/client.dart';
import 'package:verker_prof/utils/services/verker_backend/errors.dart';
import 'package:verker_prof/utils/services/file_uploader.dart';
import 'package:verker_prof/utils/services/verker_backend/auth/auth_backend.dart';

part 'register_user_state.dart';

class RegisterUserBloc extends Cubit<RegisterUserState> {
  RegisterUserBloc() : super(const RegisterUserState());

  void signUpUser() async {
    emit(state.copyWith(registerStatus: RegisterStatus.loading));
    if (state.uploadedProfileImage == null) {
      print('uploading image');
      List image = await FileUploader.uploadFile([File(state.profileImage!)]);
      emit(state.copyWith(uploadedProfileImage: image.first));
    }

    if (state.uploadedProfileImage!.isNotEmpty) {
      QueryResult result = await VerkerAuth.createUser(
        firstName: state.firstName,
        lastName: state.lastName,
        email: state.email,
        profileImageUrl: state.uploadedProfileImage!,
      );
      if (result.hasException) {
        ErrorMessage? errorMessage = ErrorMessage.getErrorMessage(result);
        emit(state.copyWith(
            registerStatus: RegisterStatus.failed, errorMessage: errorMessage));
      } else {
        // By reloading the user, we get the authbloc to update, and sign us in with the newly created user.
        FirebaseAuth.instance.currentUser!.reload();
      }
    }
  }

  void addFirstName(String value) {
    emit(state.copyWith(firstName: value));
  }

  void addLastName(String value) {
    emit(state.copyWith(lastName: value));
  }

  void addEmail(String value) {
    emit(state.copyWith(email: value));
  }

  void addProfileImage(String value) {
    emit(state.copyWith(profileImage: value));
  }

  void incrementCurrentStep() {
    emit(state.copyWith(currentStep: state.currentStep + 1));
  }

  void decrementCurrentStep() {
    emit(state.copyWith(currentStep: state.currentStep - 1));
  }

  void addNewsLetterAccept(bool value) {
    emit(state.copyWith(acceptNewLetter: value));
  }
}
