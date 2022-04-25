part of 'register_bloc.dart';

enum RegisterStatus { initial, loading, failed, succes }

class RegisterState extends Equatable {
  final RegisterStatus registerStatus;
  final RegistrationModel registrationModel;

  const RegisterState({
    this.registrationModel = const RegistrationModel(),
    this.registerStatus = RegisterStatus.initial,
  });

  RegisterState copyWith({
    RegistrationModel? registrationModel,
    RegisterStatus? registerStatus,
  }) {
    return RegisterState(
      registerStatus: registerStatus ?? this.registerStatus,
      registrationModel: registrationModel ?? this.registrationModel,
    );
  }

  @override
  List get props => [registerStatus, registrationModel];
}
