part of 'login_bloc.dart';

abstract class LoginState extends Equatable {
  int screen;
  LoginState({this.screen = 0});

  @override
  List<Object> get props => [];
}

class ScreenChanged extends LoginState {}

class LoginInitial extends LoginState {}

class Succes extends LoginState {}

class Loading extends LoginState {}

class LoginFailed extends LoginState {}
