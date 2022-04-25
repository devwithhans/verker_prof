part of 'company_register_bloc.dart';

enum CompanyRegisterStatus { initial, loading, failed, succes }

class CompanyRegisterState extends Equatable {
  final CompanyRegisterStatus registerStatus;
  final CompanyRegistrationModel companyModel;
  const CompanyRegisterState({
    this.companyModel = const CompanyRegistrationModel(),
    this.registerStatus = CompanyRegisterStatus.initial,
  });

  CompanyRegisterState copyWith({
    CompanyRegisterStatus? registerStatus,
    CompanyRegistrationModel? companyModel,
  }) {
    return CompanyRegisterState(
      registerStatus: registerStatus ?? this.registerStatus,
      companyModel: companyModel ?? this.companyModel,
    );
  }

  @override
  List get props => [
        registerStatus,
      ];
}
