part of 'register_bloc.dart';

abstract class RegisterEvent {
  const RegisterEvent();

  List<Object> get props => [];
}

class Register extends RegisterEvent {
  String email;
  String password;

  Register({required this.email, required this.password});
}

class ChooseScreen extends RegisterEvent {
  int screen;

  ChooseScreen(this.screen);
}

class GoToStep extends RegisterEvent {
  int step;
  GoToStep(this.step);
}

class AddValues extends RegisterEvent {
  final bool? termsAcceptet;
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? password;
  final String? phone;
  final String? profileImage;
  final Address? address;

  const AddValues({
    this.termsAcceptet,
    this.firstName,
    this.lastName,
    this.email,
    this.password,
    this.phone,
    this.profileImage,
    this.address,
  });
}
