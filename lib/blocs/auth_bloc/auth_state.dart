part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  UserData user = UserData();

  @override
  List<Object> get props => [];
}

class Unknown extends AuthState {}

class Authorised extends AuthState {
  UserData user;

  Authorised({required this.user}) : super();
}

enum UnAuthorisedReason { notVerker, userNotExisting, unknown }

class UnAuthorised extends AuthState {
  UnAuthorisedReason unAuthorisedReason;

  UnAuthorised({this.unAuthorisedReason = UnAuthorisedReason.unknown});
}

enum ErrorType { networkError, missingLicence, undefined, notVerker }

class ErrorAccured extends AuthState {
  ErrorType errorType;

  ErrorAccured(this.errorType);
}

class NoCompany extends AuthState {
  UserData user;

  NoCompany({required this.user}) : super();
}
