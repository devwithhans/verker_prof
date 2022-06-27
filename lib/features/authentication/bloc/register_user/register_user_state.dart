part of 'register_user_cubit.dart';

enum RegisterStatus { loading, initial, succes, failed }

class RegisterUserState extends Equatable {
  const RegisterUserState({
    this.registerStatus = RegisterStatus.initial,
    this.uploadedProfileImage,
    this.email = '',
    this.firstName = '',
    this.lastName = '',
    this.profileImage,
    this.currentStep = 0,
    this.acceptNewLetter = false,
    this.errorMessage,
  });
  final String? uploadedProfileImage;
  final bool acceptNewLetter;
  final RegisterStatus registerStatus;
  final ErrorMessage? errorMessage;
  final int currentStep;
  final String firstName;
  final String lastName;
  final String email;
  final String? profileImage;

  RegisterUserState copyWith({
    String? uploadedProfileImage,
    RegisterStatus? registerStatus,
    ErrorMessage? errorMessage,
    bool? acceptNewLetter,
    int? currentStep,
    String? firstName,
    String? lastName,
    String? profileImage,
    String? email,
  }) =>
      RegisterUserState(
        uploadedProfileImage: uploadedProfileImage ?? this.uploadedProfileImage,
        errorMessage: errorMessage ?? this.errorMessage,
        registerStatus: registerStatus ?? this.registerStatus,
        acceptNewLetter: acceptNewLetter ?? this.acceptNewLetter,
        currentStep: currentStep ?? this.currentStep,
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        email: email ?? this.email,
        profileImage: profileImage ?? this.profileImage,
      );

  @override
  List get props => [
        profileImage,
        errorMessage,
        email,
        firstName,
        lastName,
        currentStep,
        uploadedProfileImage
      ];
}
