part of 'address_cubit.dart';

abstract class AddressState extends Equatable {
  @override
  List get props => [];
}

class AddressLoading extends AddressState {}

class AddressSucces extends AddressState {
  final List<Address> addresses;
  AddressSucces(this.addresses);
}

class AddressInitial extends AddressState {}
