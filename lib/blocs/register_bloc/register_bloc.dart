import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:graphql/client.dart';
import 'package:verker_prof/models/address.dart';
import 'package:verker_prof/models/registration.dart';
import 'package:verker_prof/services/error/errors.dart';
import 'package:verker_prof/services/graphql/graphql_service.dart';
import 'package:verker_prof/services/graphql/queries/create_user.dart';

part 'register_event.dart';
part 'register_state.dart';

/// This BloC manages the login and registration logic. It uses values to send,
/// a get request to the backend, to se if the user can be registered or logged in.
/// It also manages the screen to be viewed in the UI

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  // We uses the authenticationRepository to communicate with the database.

  RegisterBloc() : super(const RegisterState()) {
    on<AddValues>(_addValues);
    on<SignUpUser>(_signUpUser);
  }

  Future<void> _signUpUser(SignUpUser event, Emitter emit) async {
    emit(state.copyWith(registerStatus: RegisterStatus.loading));

    RegistrationModel userValues = state.registrationModel;

    QueryResult result =
        await GraphQLService().performMutation(createUser, variables: {
      "firstName": userValues.firstName,
      "lastName": userValues.lastName,
      "phone": userValues.phone,
      "email": userValues.email,
      "password": userValues.password,
    });
    if (result.hasException) {
      String errorMessage =
          ErrorMessage.getErrorMessage(result)!.frontendMessage;
      return emit(
        state.copyWith(
          registerStatus: RegisterStatus.failed,
          errorMessage: errorMessage,
        ),
      );
    }

    return emit(state.copyWith(registerStatus: RegisterStatus.succes));
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
