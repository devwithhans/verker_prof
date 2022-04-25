import 'package:verker_prof/models/address.dart';

class CompanyRegistrationModel {
  final String? name;
  final String? description;
  final String? email;
  final String? cvr;
  final String? phone;
  final int? employees;
  final String? type;
  final String? established;
  final String? address;
  final String? zip;
  final List<double>? coordinates;
  final String? logo;

  const CompanyRegistrationModel({
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

  CompanyRegistrationModel copyWith({
    String? type,
    String? name,
    String? description,
    String? email,
    String? cvr,
    String? phone,
    String? logo,
    String? address,
    String? zip,
    List<double>? coordinates,
    int? employees,
    String? established,
  }) {
    return CompanyRegistrationModel(
      zip: zip ?? this.zip,
      type: type ?? this.type,
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
