import 'package:verker_prof/models/address.dart';

class CompanyRegistrationModel {
  final String? name;
  final String? description;
  final String? email;
  final String? cvr;
  final String? phone;
  final int? employees;
  final int? established;
  final Address? address;
  final List<double>? coordinates;
  final String? logo;

  const CompanyRegistrationModel({
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

  CompanyRegistrationModel copyWith({
    String? name,
    String? description,
    String? email,
    String? cvr,
    String? phone,
    String? logo,
    Address? address,
    List<double>? coordinates,
    int? employees,
    int? established,
  }) {
    return CompanyRegistrationModel(
      name: name ?? this.name,
      description: description ?? this.description,
      email: email ?? this.email,
      cvr: cvr ?? this.cvr,
      phone: phone ?? this.phone,
      address: address ?? this.address,
      established: established ?? this.established,
      employees: employees ?? this.employees,
      coordinates: coordinates ?? this.coordinates,
      logo: logo ?? this.logo,
    );
  }
}
