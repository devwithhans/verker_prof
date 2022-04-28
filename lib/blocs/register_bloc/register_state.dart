part of 'register_bloc.dart';

enum RegisterStatus { initial, loading, failed, succes }

class RegisterState extends Equatable {
  final RegisterStatus registerStatus;
  final RegistrationModel registrationModel;
  final String? errorMessage;

  const RegisterState({
    this.errorMessage,
    this.registrationModel = const RegistrationModel(),
    this.registerStatus = RegisterStatus.initial,
  });

  RegisterState copyWith({
    RegistrationModel? registrationModel,
    String? errorMessage,
    RegisterStatus? registerStatus,
  }) {
    return RegisterState(
      errorMessage: errorMessage ?? this.errorMessage,
      registerStatus: registerStatus ?? this.registerStatus,
      registrationModel: registrationModel ?? this.registrationModel,
    );
  }

  @override
  List get props => [registerStatus, registrationModel];
}
