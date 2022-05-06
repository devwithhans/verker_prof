part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  final UserData user = UserData();
  @override
  List<Object> get props => [user];
}

class LoadingAuthState extends AuthState {}

class Authorised extends AuthState {
  Authorised({required user}) : super();
}

enum UnAuthorisedReason { notVerker, userNotExisting, unknown }

class UnAuthorised extends AuthState {
  final UnAuthorisedReason unAuthorisedReason;

  UnAuthorised({this.unAuthorisedReason = UnAuthorisedReason.unknown});
}

enum ErrorType { networkError, missingLicence, undefined, notVerker }

class ErrorAccured extends AuthState {
  final ErrorType errorType;

  ErrorAccured(this.errorType);
}

class NoCompany extends AuthState {
  NoCompany({required user}) : super();
}

class AuthLoading extends AuthState {}
