part of 'firebase_signin_bloc.dart';

abstract class FirebaseSigninEvent extends Equatable {
  const FirebaseSigninEvent();

  @override
  List<Object> get props => [];
}

class SendSms extends FirebaseSigninEvent {
  String phone;
  SendSms(this.phone);
}

class VerifyCode extends FirebaseSigninEvent {
  String code;
  String verificationId;
  VerifyCode(this.code, this.verificationId);
}
