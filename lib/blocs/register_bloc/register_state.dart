part of 'register_bloc.dart';

enum RegisterStatus { initial, loading, failed }

class RegisterState extends Equatable {
  int screen;
  RegisterStatus registerStatus;

  RegistrationModel registrationModel;

  RegisterState({
    this.registrationModel = const RegistrationModel(),
    this.screen = 0,
    this.registerStatus = RegisterStatus.initial,
  });

  RegisterState copyWith({
    RegistrationModel? registrationModel,
    RegisterStatus? registerStatus,
    int? screen,
  }) {
    return RegisterState(
        registerStatus: registerStatus ?? this.registerStatus,
        screen: screen ?? this.screen,
        registrationModel: registrationModel ?? this.registrationModel);
  }

  @override
  List get props => [screen, registerStatus, registrationModel];
}
