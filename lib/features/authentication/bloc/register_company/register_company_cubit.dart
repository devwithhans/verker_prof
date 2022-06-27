import 'dart:io';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:graphql/client.dart';
import 'package:verker_prof/features/address/models/address.dart';

import 'package:verker_prof/utils/services/verker_backend/errors.dart';
import 'package:verker_prof/utils/services/file_uploader.dart';
import 'package:verker_prof/utils/services/verker_backend/auth/auth_backend.dart';

part 'register_company_state.dart';

class RegisterCompanyBloc extends Cubit<RegisterCompanyState> {
  RegisterCompanyBloc() : super(const RegisterCompanyState());

  void registerCompany() async {
    emit(state.copyWith(registerStatus: RegisterStatus.loading));
    if (state.uploadedLogoImage == null) {
      print('uploading image');
      List image = await FileUploader.uploadFile([File(state.logoImage!)]);
      emit(state.copyWith(uploadedLogoImage: image.first));
    }

    if (state.uploadedLogoImage!.isNotEmpty) {
      QueryResult result = await VerkerAuth.createCompany(state: state);
      if (result.hasException) {
        print(result.exception);
        ErrorMessage? errorMessage = ErrorMessage.getErrorMessage(result);
        emit(state.copyWith(
            registerStatus: RegisterStatus.failed, errorMessage: errorMessage));
      } else {
        // By reloading the user, we get the authbloc to update, and sign us in with the newly created user.
        FirebaseAuth.instance.currentUser!.getIdTokenResult(true);
        FirebaseAuth.instance.currentUser!.reload();
      }
    }
  }

  void addValue({
    String? phone,
    String? email,
    String? logoImage,
    String? cvr,
    String? companyName,
    String? description,
    String? established,
    Address? address,
    String? employees,
  }) {
    emit(state.copyWith(
      established: established,
      address: address,
      employees: employees,
      phone: phone,
      email: email,
      logoImage: logoImage,
      cvr: cvr,
      companyName: companyName,
      description: description,
    ));
  }

  void addService(value) {
    List<String> newServices = [];
    newServices.addAll(state.services);

    if (state.services.contains(value)) {
      newServices.remove(value);
    } else {
      newServices.add(value);
    }
    emit(state.copyWith(services: newServices));
  }

  void addLogo(value) {
    emit(state.copyWith(logoImage: value));
  }

  void addAddress(value) {
    emit(state.copyWith(address: value));
  }

  void clearAddress() {
    emit(state.removeAddress());
  }

  void incrementCurrentStep() {
    emit(state.copyWith(currentStep: state.currentStep + 1));
  }

  void decrementCurrentStep() {
    emit(state.copyWith(currentStep: state.currentStep - 1));
  }
}
