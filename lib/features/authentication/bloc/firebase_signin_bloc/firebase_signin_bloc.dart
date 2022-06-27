import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
part 'firebase_signin_event.dart';
part 'firebase_signin_state.dart';

class FirebaseSigninBloc
    extends Bloc<FirebaseSigninEvent, FirebaseSigninState> {
  FirebaseSigninBloc() : super(FirebaseSigninInitial()) {
    on<FirebaseSigninEvent>((event, emit) {});
    on<SendSms>(smsVerification);
    on<VerifyCode>(runVerifCode);
  }

  Future<void> runVerifCode(VerifyCode event, Emitter emit) async {
    emit(FirebaseSigninLoading());
    if (state is CodeSent) {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: event.verificationId, smsCode: event.code);
      await FirebaseAuth.instance.signInWithCredential(credential);
    }
    emit(FirebaseSigninInitial());
  }

  Future<void> smsVerification(SendSms event, Emitter emit) async {
    emit(FirebaseSigninLoading());
    Completer<FirebaseSigninState> c = Completer<FirebaseSigninState>();

    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: event.phone,
      verificationCompleted: (PhoneAuthCredential credential) {
        c.complete(
          VerificationCompleted(credential),
        );
      },
      verificationFailed: (FirebaseAuthException e) {
        c.complete(
          VerificationFailed(e),
        );
      },
      codeSent: (String verificationId, int? resendToken) {
        c.complete(CodeSent(verificationId, resendToken));
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        c.complete(CodeAutoRetrievalTimeout(verificationId));
      },
    );
    var stateToRetern = await c.future;
    emit(stateToRetern);
    emit(FirebaseSigninInitial());
  }
}
