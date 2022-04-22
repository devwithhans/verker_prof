import 'package:verker_prof/models/address.dart';

class RegistrationModel {
  final String? name;
  final String? email;
  final String? password;
  final String? phone;
  final String? profileImage;
  final Address? address;

  const RegistrationModel({
    this.name,
    this.email,
    this.password,
    this.phone,
    this.profileImage,
    this.address,
  });

  RegistrationModel copyWith({
    String? name,
    String? email,
    String? password,
    String? phone,
    String? profileImage,
    Address? address,
    int? screen,
  }) {
    return RegistrationModel(
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      phone: phone ?? this.phone,
      profileImage: profileImage ?? this.profileImage,
      address: address ?? this.address,
    );
  }
}
