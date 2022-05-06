part of 'login_bloc.dart';

abstract class LoginState extends Equatable {
  final int screen;
  const LoginState({this.screen = 0});

  @override
  List<Object> get props => [];
}

class ScreenChanged extends LoginState {}

class LoginInitial extends LoginState {}

class Succes extends LoginState {}

class Loading extends LoginState {}

class EmailFailed extends LoginState {
  final String errorMessage;

  const EmailFailed(this.errorMessage);
}

class PasswordFailed extends LoginState {
  final String errorMessage;

  const PasswordFailed(this.errorMessage);
}
