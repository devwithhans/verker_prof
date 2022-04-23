import 'package:verker_prof/models/address.dart';

class RegistrationModel {
  final bool? termsAcceptet;
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? password;
  final String? phone;
  final String? profileImage;
  final Address? address;

  const RegistrationModel({
    this.termsAcceptet,
    this.firstName,
    this.lastName,
    this.email,
    this.password,
    this.phone,
    this.profileImage,
    this.address,
  });

  RegistrationModel copyWith({
    bool? termsAcceptet,
    String? firstName,
    String? lastName,
    String? email,
    String? password,
    String? phone,
    String? profileImage,
    Address? address,
    int? screen,
  }) {
    return RegistrationModel(
      termsAcceptet: termsAcceptet ?? this.termsAcceptet,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      password: password ?? this.password,
      phone: phone ?? this.phone,
      profileImage: profileImage ?? this.profileImage,
      address: address ?? this.address,
    );
  }
}
