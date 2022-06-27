part of 'firebase_signin_bloc.dart';

abstract class FirebaseSigninState extends Equatable {
  const FirebaseSigninState();

  @override
  List<Object> get props => [];
}

class FirebaseSigninInitial extends FirebaseSigninState {}

class FirebaseSigninLoading extends FirebaseSigninState {}

class VerificationCompleted extends FirebaseSigninState {
  PhoneAuthCredential credential;
  VerificationCompleted(this.credential);
}

class VerificationFailed extends FirebaseSigninState {
  FirebaseAuthException e;
  VerificationFailed(this.e);
}

class CodeSent extends FirebaseSigninState {
  String verificationId;
  int? resendToken;
  CodeSent(this.verificationId, this.resendToken);
}

class CodeAutoRetrievalTimeout extends FirebaseSigninState {
  String verificationId;
  CodeAutoRetrievalTimeout(this.verificationId);
}
