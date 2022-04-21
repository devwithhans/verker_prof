import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:verker_prof/blocs/auth_bloc/auth_event.dart';
import 'package:verker_prof/models/user.dart';
import 'package:verker_prof/repositories/authRepo.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthenticationRepository _authenticationRepository;

  late StreamSubscription<AuthState> _authenticationStatusSubscription;

  AuthBloc({required authenticationRepository})
      : _authenticationRepository = authenticationRepository,
        super(Unknown()) {
    on<LoggedOut>(_onLoggedOut);
    _authenticationStatusSubscription =
        _authenticationRepository.status.listen((status) => emit(status));
  }

  @override
  Future<void> close() {
    _authenticationStatusSubscription.cancel();
    _authenticationRepository.dispose();
    return super.close();
  }

  Future<void> _onLoggedOut(event, emit) async {
    _authenticationRepository.logOut();
  }
}
