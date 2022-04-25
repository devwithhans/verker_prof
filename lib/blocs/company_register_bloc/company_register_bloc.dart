import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import 'package:verker_prof/models/address.dart';
import 'package:verker_prof/models/company_registration.dart';
import 'package:verker_prof/services/network_helper.dart';

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
    on<SearchCompanyByName>(_searchCompanyByName);
    on<SignUpUser>(_signUpUser);
  }

  void _searchCompanyByName(SearchCompanyByName event, Emitter emit) async {
    emit(state.copyWith(cvrSearchStatus: CvrSearchStatus.loading));
    print(state.companyModel.name);
    var data = await NetworkHelper(
            "https://cvrapi.dk/api?country=dk&search=${state.companyModel.name}")
        .getData();
    if (data['error'] != null) {
      emit(state.copyWith(cvrSearchStatus: CvrSearchStatus.failed));
    } else {
      emit(state.copyWith(
        searchResult: data,
        cvrSearchStatus: CvrSearchStatus.succes,
        companyModel: state.companyModel.copyWith(
          name: data["name"],
          cvr: data["vat"] != null ? data["vat"].toString() : '',
          phone: data["phone"] != null ? data["phone"].toString() : '',
          email: data["email"] ?? '',
          employees: data["employees"],
          established: data["startData"] ?? '',
          address: data["address"] ?? '',
          zip: data["zipcode"] ?? '',
        ),
      ));
    }

    print(data);
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
          zip: event.zip,
          type: event.type,
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
