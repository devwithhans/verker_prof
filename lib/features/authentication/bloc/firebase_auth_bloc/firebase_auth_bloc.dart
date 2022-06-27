import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:verker_prof/features/authentication/bloc/firebase_auth_bloc/firebase_auth_event.dart';
import 'package:verker_prof/features/authentication/models/user.dart';
import 'package:verker_prof/features/chat/repositories/chat_repo.dart';
import 'package:verker_prof/utils/services/verker_backend/errors.dart';
import 'package:verker_prof/main.dart';
import 'package:verker_prof/utils/services/verker_backend/auth/auth_backend.dart';

part 'firebase_auth_state.dart';

// The authbloc wraps the login of all authentication logic. We use the AuthenticationRepository to do all the logic

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  late StreamSubscription<User?> _authenticationStatusSubscription;
  final ChatRepository chatRepository;

  AuthBloc(this.chatRepository) : super(AuthState()) {
    on<LoggedOut>(_onLoggedOut);

    _authenticationStatusSubscription =
        FirebaseAuth.instance.userChanges().listen((User? user) async {
      if (user == null) {
        emit(state.copyWith(authStatus: AuthStatus.unAuthorised));
      } else {
        late UserData user;
        emit(state.copyWith(authStatus: AuthStatus.loading));
        try {
          user = await VerkerAuth.getUser();
        } catch (e) {
          ErrorMessage errorMessage = e as ErrorMessage;
          if (e.errorName == 'USER_DOES_NOT_EXIST') {
            bool canPop = Navigator.canPop(navigatorKey.currentContext!);
            if (canPop) {
              Navigator.popUntil(
                  navigatorKey.currentContext!, ModalRoute.withName('/'));
            }
          }
          emit(state.copyWith(
            authStatus: AuthStatus.errorAccured,
            errorMessage: e,
          ));
          return;
        }

        try {
          UserData chatUser = await chatRepository.connectUser(user);
          emit(
            state.copyWith(
              errorMessage:
                  user.companyId == null ? ErrorMessage.noCompanyFoud : null,
              authStatus: user.companyId == null
                  ? AuthStatus.errorAccured
                  : AuthStatus.authorised,
              user: user,
            ),
          );
          bool canPop = Navigator.canPop(navigatorKey.currentContext!);
          if (canPop) {
            Navigator.pop(navigatorKey.currentContext!);
          }
        } catch (e) {
          emit(state.copyWith(
            authStatus: AuthStatus.errorAccured,
            errorMessage: ErrorMessage.failedToConnectChatClient,
          ));
          return;
        }
      }
    });
  }

  Future<void> _onLoggedOut(event, emit) async {
    FirebaseAuth.instance.signOut();
  }

  @override
  Future<void> close() {
    _authenticationStatusSubscription.cancel();
    return super.close();
  }
}
