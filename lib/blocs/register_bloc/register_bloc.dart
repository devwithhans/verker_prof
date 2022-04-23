import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:verker_prof/models/address.dart';
import 'package:verker_prof/models/registration.dart';

part 'register_event.dart';
part 'register_state.dart';

/// This BloC manages the login and registration logic. It uses values to send,
/// a get request to the backend, to se if the user can be registered or logged in.
/// It also manages the screen to be viewed in the UI

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  // We uses the authenticationRepository to communicate with the database.

  RegisterBloc() : super(RegisterState()) {
    on<GoToStep>(_goToStep);
    on<AddValues>(_addValues);
  }

  void _goToStep(GoToStep event, Emitter emit) {
    emit(state.copyWith(screen: event.step));
  }

  void _addValues(AddValues event, Emitter emit) {
    emit(
      state.copyWith(
        registrationModel: state.registrationModel.copyWith(
            firstName: event.firstName,
            lastName: event.lastName,
            email: event.email,
            profileImage: event.profileImage,
            address: event.address,
            phone: event.phone,
            termsAcceptet: event.termsAcceptet,
            password: event.password,
            validationPassword: event.validationPassword),
      ),
    );
  }
}
