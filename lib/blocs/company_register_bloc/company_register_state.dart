part of 'company_register_bloc.dart';

enum CompanyRegisterStatus { initial, loading, failed, succes }
enum CvrSearchStatus { initial, loading, failed, succes }

class CompanyRegisterState extends Equatable {
  final CompanyRegisterStatus registerStatus;
  final CompanyRegistrationModel companyModel;
  final CvrSearchStatus cvrSearchStatus;
  // ignore: prefer_typing_uninitialized_variables
  final searchResult;
  const CompanyRegisterState({
    this.cvrSearchStatus = CvrSearchStatus.initial,
    this.searchResult,
    this.companyModel = const CompanyRegistrationModel(),
    this.registerStatus = CompanyRegisterStatus.initial,
  });

  CompanyRegisterState copyWith({
    var searchResult,
    CompanyRegisterStatus? registerStatus,
    CvrSearchStatus? cvrSearchStatus,
    CompanyRegistrationModel? companyModel,
  }) {
    return CompanyRegisterState(
      cvrSearchStatus: cvrSearchStatus ?? this.cvrSearchStatus,
      searchResult: searchResult ?? this.searchResult,
      registerStatus: registerStatus ?? this.registerStatus,
      companyModel: companyModel ?? this.companyModel,
    );
  }

  @override
  List get props => [
        registerStatus,
        cvrSearchStatus,
        companyModel,
      ];
}
