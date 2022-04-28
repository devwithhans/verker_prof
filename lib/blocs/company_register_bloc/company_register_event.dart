part of 'company_register_bloc.dart';

abstract class CompanyRegisterEvent {
  const CompanyRegisterEvent();

  List<Object> get props => [];
}

class CompanyRegister extends CompanyRegisterEvent {
  String email;
  String password;

  CompanyRegister({required this.email, required this.password});
}

class ChooseScreen extends CompanyRegisterEvent {
  int screen;

  ChooseScreen(this.screen);
}

class GoToStep extends CompanyRegisterEvent {
  int step;
  GoToStep(this.step);
}

class AddValues extends CompanyRegisterEvent {
  final String? name;
  final String? type;
  final String? description;
  final String? email;
  final String? cvr;
  final String? phone;
  final String? employees;
  final String? established;
  final String? address;
  final String? zip;
  final List<double>? coordinates;
  final String? logo;

  const AddValues({
    this.zip,
    this.type,
    this.name,
    this.description,
    this.email,
    this.cvr,
    this.phone,
    this.address,
    this.coordinates,
    this.employees,
    this.established,
    this.logo,
  });
}

class RegisterCompany extends CompanyRegisterEvent {}

class SearchCompanyByName extends CompanyRegisterEvent {}
