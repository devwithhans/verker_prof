import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:verker_prof/features/authentication/bloc/register_company/register_company_cubit.dart';
import 'package:verker_prof/features/authentication/views/register_user/widgets/stepWidget.dart';
import 'package:verker_prof/utils/theme/widgets/select_option_label.dart';
import 'package:verker_prof/utils/theme/widgets/verker_search_field.dart';

const List<String> services = [
  'Tømrer',
  'Elektriker',
  'Murer',
  'Maler',
  'Gulv'
      'Anlægsgartner',
  'Glarmester',
  'Isolering',
  'Tag',
  'Kloak',
  'Smed',
  'Brolægger',
  'Rengøring',
  'Nedrivning',
  'VVS',
  'Handyman',
  'Jord og betonarbejde',
  'Rådgivning',
  'Gulvsliber',
  'Varmepumpeinstallatør',
  'Kølefirma',
  'Tækkermand',
  'Tagmaler',
  'Vinduespudser',
  'Mekaniker',
  'Bilklargøring',
  'Bådklargøring',
  'Snedker',
];

class CompanyServices extends StatefulWidget {
  const CompanyServices({Key? key}) : super(key: key);

  @override
  State<CompanyServices> createState() => _CompanyServicesState();
}

List<String> searchResult = services;

class _CompanyServicesState extends State<CompanyServices> {
  @override
  Widget build(BuildContext context) {
    RegisterCompanyBloc registerCompanyBloc =
        context.read<RegisterCompanyBloc>();

    return StepWidget(
      title: 'Vælg dine brancher',
      description: 'Lad kunderne se hvilken slags arbejde du udføre.',
      child: BlocBuilder<RegisterCompanyBloc, RegisterCompanyState>(
        builder: (context, state) {
          return FormField(validator: (value) {
            if (state.services.isEmpty) {
              return 'Vælg mindst en branche';
            }
          }, builder: (form) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                VerkerSearchField(
                  hintText: 'Søg efter faglighed',
                  onSearch: (value) {
                    searchResult = services
                        .where((element) =>
                            element.toLowerCase().contains(value.toLowerCase()))
                        .toList();
                    setState(() {});
                  },
                ),
                form.hasError
                    ? Padding(
                        padding: const EdgeInsets.only(top: 8.0, left: 8.0),
                        child: Text(
                          form.errorText ?? '',
                          style: TextStyle(
                            color: Colors.red,
                          ),
                        ),
                      )
                    : SizedBox(),
                SizedBox(height: 20),
                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: searchResult
                      .map(
                        (e) => OptionSelect(
                          onPressed: () {
                            HapticFeedback.heavyImpact();
                            registerCompanyBloc.addService(e);
                          },
                          option: e,
                          selectedOptions: state.services,
                        ),
                      )
                      .toList(),
                ),
                SizedBox(height: 30),
              ],
            );
          });
        },
      ),
    );
  }
}
