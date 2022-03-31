part of 'login_bloc.dart';

abstract class LoginEvent {
  const LoginEvent();

  List<Object> get props => [];
}

class Login extends LoginEvent {
  String email;
  String password;

  Login({required this.email, required this.password});
}

class ChooseScreen extends LoginEvent {
  int screen;

  ChooseScreen(this.screen);
}
