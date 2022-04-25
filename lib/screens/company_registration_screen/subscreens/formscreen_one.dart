import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:verker_prof/blocs/company_register_bloc/company_register_bloc.dart';
import 'package:verker_prof/models/address.dart';
import 'package:verker_prof/theme/components/standard_input_form.dart';
import 'package:verker_prof/theme/constants/textstyle.dart';
import 'package:verker_prof/widgets/input.dart';

class CompanyFormScreenTwo extends StatelessWidget {
  CompanyFormScreenTwo({Key? key}) : super(key: key);

  bool showComplianceError = false;

  bool termsAccept = false;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CompanyRegisterBloc, CompanyRegisterState>(
      builder: (context, state) {
        if (state.cvrSearchStatus == CvrSearchStatus.loading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        return Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              StandardInputForm(
                initialValue: state.companyModel.name ?? '',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Feltet må ikke være tomt';
                  }
                  return null;
                },
                textCapitalization: TextCapitalization.sentences,
                onChanged: (v) {
                  context.read<CompanyRegisterBloc>().add(
                        AddValues(name: v),
                      );
                },
                title: 'Virksomhedens navn.',
                hintText: 'Virksomhedens navn',
              ),
              StandardInputForm(
                initialValue: state.companyModel.cvr ?? '',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Feltet må ikke være tomt';
                  }
                  if (value.length != 8) {
                    return 'Skriv et gyldigt CVR nummer';
                  }
                  return null;
                },
                number: true,
                textCapitalization: TextCapitalization.sentences,
                onChanged: (v) {
                  context.read<CompanyRegisterBloc>().add(
                        AddValues(cvr: v),
                      );
                },
                title: 'CVR-nummer.',
                hintText: 'CVR-nummer',
                keyboardType: TextInputType.phone,
              ),
              StandardInputForm(
                initialValue: state.companyModel.phone ?? '',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Feltet må ikke være tomt';
                  }
                  if (value.length != 8) {
                    return 'Skriv et gyldigt Telefon nummer';
                  }
                  return null;
                },
                keyboardType: TextInputType.phone,
                textCapitalization: TextCapitalization.sentences,
                onChanged: (v) {
                  context.read<CompanyRegisterBloc>().add(
                        AddValues(phone: v),
                      );
                },
                title: 'Telefon.',
                hintText: 'Telefon',
              ),
              StandardInputForm(
                initialValue: state.companyModel.email ?? '',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Feltet må ikke være tomt';
                  }
                  bool emailValid = RegExp(
                          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                      .hasMatch(value);
                  if (!emailValid) {
                    return 'Indtast venligst en gyldig mail';
                  }
                  return null;
                },
                keyboardType: TextInputType.emailAddress,
                textCapitalization: TextCapitalization.sentences,
                onChanged: (v) {
                  context.read<CompanyRegisterBloc>().add(
                        AddValues(email: v),
                      );
                },
                title: 'Email.',
                hintText: 'Email',
              ),
              StandardInputForm(
                initialValue: state.companyModel.address ?? '',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Feltet må ikke være tomt';
                  }
                  return null;
                },
                keyboardType: TextInputType.streetAddress,
                textCapitalization: TextCapitalization.sentences,
                onChanged: (v) {
                  context.read<CompanyRegisterBloc>().add(
                        AddValues(address: v),
                      );
                },
                title: 'Adresse.',
                hintText: 'Adresse',
              ),
              StandardInputForm(
                initialValue: state.companyModel.zip ?? '',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Feltet må ikke være tomt';
                  }
                  return null;
                },
                keyboardType: TextInputType.number,
                textCapitalization: TextCapitalization.sentences,
                onChanged: (v) {
                  context.read<CompanyRegisterBloc>().add(AddValues(zip: v));
                },
                title: 'Postnummer.',
                hintText: 'Postnummer',
              ),
            ],
          ),
        );
      },
    );
  }

  Row textRow({required String before, required String after}) {
    return Row(
      children: [
        Text(
          '$before: ',
          style: kSmallBold,
        ),
        Text(after)
      ],
    );
  }
}
