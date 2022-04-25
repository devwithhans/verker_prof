import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:verker_prof/models/address.dart';
import 'package:verker_prof/models/company_registration.dart';

part 'company_register_state.dart';
part 'company_register_event.dart';

/// This BloC manages the login and registration logic. It uses values to send,
/// a get request to the backend, to se if the user can be registered or logged in.
/// It also manages the screen to be viewed in the UI

class CompanyRegisterBloc
    extends Bloc<CompanyRegisterEvent, CompanyRegisterState> {
  // We uses the authenticationRepository to communicate with the database.

  CompanyRegisterBloc() : super(CompanyRegisterState()) {
    on<AddValues>(_addValues);
    on<SignUpUser>(_signUpUser);
  }

  Future<void> _signUpUser(SignUpUser event, Emitter emit) async {
    emit(state.copyWith(registerStatus: CompanyRegisterStatus.loading));

    CompanyRegistrationModel companyData = state.companyModel;

    try {
      // QueryResult result =
      //     await GraphQLService().performMutation(createUser, variables: {
      //   "firstName": userValues.firstName,
      //   "lastName": userValues.lastName,
      //   "phone": userValues.phone,
      //   "email": userValues.email,
      //   "password": userValues.password,
      // });
      // print(result.exception);
    } catch (e) {
      print('e');

      return emit(state.copyWith(registerStatus: CompanyRegisterStatus.failed));
    }

    return emit(state.copyWith(registerStatus: CompanyRegisterStatus.succes));
  }

  void _addValues(AddValues event, Emitter emit) {
    emit(
      state.copyWith(
        companyModel: state.companyModel.copyWith(
          name: event.name,
          description: event.description,
          cvr: event.cvr,
          coordinates: event.coordinates,
          address: event.address,
          phone: event.phone,
          email: event.email,
          employees: event.employees,
          established: event.established,
          logo: event.logo,
        ),
      ),
    );
  }
}
