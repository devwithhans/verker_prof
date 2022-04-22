part of 'register_bloc.dart';

abstract class RegisterEvent {
  const RegisterEvent();

  List<Object> get props => [];
}

class Register extends RegisterEvent {
  String email;
  String password;

  Register({required this.email, required this.password});
}

class ChooseScreen extends RegisterEvent {
  int screen;

  ChooseScreen(this.screen);
}

class GoToStep extends RegisterEvent {
  int step;
  GoToStep(this.step);
}

class AddValues extends RegisterEvent {
  RegistrationModel registrationModel;
  AddValues(this.registrationModel);
}
