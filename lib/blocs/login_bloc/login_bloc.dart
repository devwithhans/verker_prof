import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:verker_prof/repositories/authRepo.dart';
import 'package:verker_prof/services/error/errors.dart';

part 'login_event.dart';
part 'login_state.dart';

/// This BloC manages the login and registration logic. It uses values to send,
/// a get request to the backend, to se if the user can be registered or logged in.
/// It also manages the screen to be viewed in the UI

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  // We uses the authenticationRepository to communicate with the database.
  final AuthenticationRepository _authenticationRepository;
  LoginBloc({
    required AuthenticationRepository authenticationRepository,
  })  : _authenticationRepository = authenticationRepository,
        super(LoginInitial()) {
    on<Login>(_onLogin);
  }

  void selectScreen(screen) {
    LoginInitial newState = LoginInitial();
    newState.screen = screen;
    emit(ScreenChanged());
    emit(newState);
  }

  Future<void> _onLogin(Login event, emit) async {
    emit(Loading());
    try {
      dynamic result = await _authenticationRepository.logIn(
          email: event.email, password: event.password);
      if (result is ErrorMessage) {
        if (result.errorName == 'PASSWORD_IS_INCORRECT') {
          emit(PasswordFailed(result.frontendMessage));
        } else if (result.errorName == 'EMAIL_NOT_FOUND') {
          emit(EmailFailed(result.frontendMessage));
        }
      } else {
        emit(Succes());
      }
    } catch (e) {
      print(e);
      emit(EmailFailed(ErrorMessage.getErrorMessage('UNKNOWN')));
    }
  }
}
