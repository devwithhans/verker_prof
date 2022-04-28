import 'dart:convert';
import 'package:verker_prof/models/address.dart';

class UserData {
  String id;
  String? companyId;
  // bool verker;
  String firstName;
  String lastName;
  String profileImage;
  String? streamToken;
  Address? address;
  String email;
  String phone;

  UserData({
    this.companyId,
    // this.verker = false,
    this.id = '',
    this.firstName = '',
    this.lastName = '',
    this.profileImage = '',
    this.streamToken,
    this.address,
    this.email = '',
    this.phone = '',
  });

  static convert(response) {
    if (response['_id'] == null) {
      return null;
    }
    return UserData(
      id: response['_id'],
      companyId: response['companyId'],
      // verker: response['verker'],
      firstName: response['firstName'],
      lastName: response['lastName'],
      profileImage: response['profileImage'],
      streamToken: response['streamToken'],
      address: response['address'] == null
          ? Address(
              address: response['address']['address'],
              zip: response['address']['zip'])
          : null,
      email: response['email'],
      phone: response['phone'],
    );
  }
}
