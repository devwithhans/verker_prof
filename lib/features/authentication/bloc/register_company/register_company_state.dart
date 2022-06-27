part of 'register_company_cubit.dart';

enum RegisterStatus { loading, initial, succes, failed }

class RegisterCompanyState extends Equatable {
  const RegisterCompanyState({
    this.registerStatus = RegisterStatus.initial,
    this.uploadedLogoImage,
    this.email = '',
    this.phone = '',
    this.companyName = '',
    this.cvr = '',
    this.description = '',
    this.logoImage,
    this.services = const [],
    this.currentStep = 0,
    this.errorMessage,
    this.employees = '',
    this.established = '',
    this.address,
  });
  final int currentStep;
  final RegisterStatus registerStatus;

  final String companyName;
  final String description;
  final String phone;
  final String email;
  final String cvr;
  final List<String> services;
  final String? uploadedLogoImage;
  final String established;
  final Address? address;
  final String employees;

  final String? logoImage;
  final ErrorMessage? errorMessage;

  RegisterCompanyState copyWith({
    List<String>? services,
    RegisterStatus? registerStatus,
    ErrorMessage? errorMessage,
    int? currentStep,
    String? phone,
    String? email,
    String? logoImage,
    String? uploadedLogoImage,
    String? cvr,
    String? companyName,
    String? description,
    String? established,
    Address? address,
    String? employees,
  }) =>
      RegisterCompanyState(
        services: services ?? this.services,
        established: established ?? this.established,
        address: address ?? this.address,
        employees: employees ?? this.employees,
        registerStatus: registerStatus ?? this.registerStatus,
        errorMessage: errorMessage ?? this.errorMessage,
        currentStep: currentStep ?? this.currentStep,
        phone: phone ?? this.phone,
        email: email ?? this.email,
        logoImage: logoImage ?? this.logoImage,
        uploadedLogoImage: uploadedLogoImage ?? this.uploadedLogoImage,
        cvr: cvr ?? this.cvr,
        companyName: companyName ?? this.companyName,
        description: description ?? this.description,
      );

  RegisterCompanyState removeAddress() => RegisterCompanyState(
        services: services,
        established: established,
        address: null,
        employees: employees,
        registerStatus: registerStatus,
        errorMessage: errorMessage,
        currentStep: currentStep,
        phone: phone,
        email: email,
        logoImage: logoImage,
        uploadedLogoImage: uploadedLogoImage,
        cvr: cvr,
        companyName: companyName,
        description: description,
      );

  @override
  List get props => [
        registerStatus,
        errorMessage,
        phone,
        logoImage,
        uploadedLogoImage,
        cvr,
        services,
        description,
        established,
        employees,
        email,
        companyName,
        errorMessage,
        email,
        address,
        currentStep,
      ];
}
