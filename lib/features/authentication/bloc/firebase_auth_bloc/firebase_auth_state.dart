part of 'firebase_auth_bloc.dart';

enum AuthStatus { authorised, unAuthorised, errorAccured, noCompany, loading }

class AuthState extends Equatable {
  final UserData? user;
  final AuthStatus authStatus;
  final ErrorMessage? errorMessage;

  AuthState(
      {this.user,
      this.authStatus = AuthStatus.unAuthorised,
      this.errorMessage});

  AuthState copyWith({
    UserData? user,
    AuthStatus? authStatus,
    ErrorMessage? errorMessage,
  }) {
    return AuthState(
      user: user ?? this.user,
      authStatus: authStatus ?? this.authStatus,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List get props => [user, authStatus, errorMessage];
}
