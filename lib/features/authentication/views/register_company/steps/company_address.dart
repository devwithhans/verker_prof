import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:verker_prof/features/address/bloc/address_cubit/address_cubit.dart';
import 'package:verker_prof/features/address/models/address.dart';
import 'package:verker_prof/features/authentication/bloc/register_company/register_company_cubit.dart';
import 'package:verker_prof/features/authentication/views/register_company/widgets/address_search_result.dart';
import 'package:verker_prof/features/authentication/views/register_user/widgets/stepWidget.dart';
import 'package:verker_prof/utils/theme/constants/colors.dart';
import 'package:verker_prof/utils/theme/constants/textstyle.dart';
import 'package:verker_prof/utils/theme/widgets/verker_input_form.dart';
import 'package:verker_prof/utils/theme/widgets/verker_search_field.dart';

class CompanyAddress extends StatelessWidget {
  const CompanyAddress({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Address> result = [];

    return StepWidget(
      childPadding: EdgeInsets.zero,
      title: 'Vælg virksomhedens adresse',
      description:
          'Lad os vide hvor din virksomhed holder til, så vi kan vise dig relevante projekter.',
      child: BlocProvider(
        create: (context) => AddressCubit(),
        child: Column(
          children: [
            BlocBuilder<RegisterCompanyBloc, RegisterCompanyState>(
              builder: (context, parentState) {
                if (parentState.address == null) {
                  return BlocBuilder<AddressCubit, AddressState>(
                    builder: (context, state) {
                      if (state is AddressSucces) {
                        result = state.addresses;
                      }
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          FormField(validator: ((value) {
                            if (parentState.address == null) {
                              return 'Du skal vælge en addresse';
                            }
                          }), builder: (field) {
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  VerkerSearchField(
                                    hintText: 'Søg efter din adresse',
                                    onSearch: (value) {
                                      BlocProvider.of<AddressCubit>(context)
                                          .searchAddress(value);
                                    },
                                  ),
                                  field.hasError
                                      ? Padding(
                                          padding: const EdgeInsets.only(
                                              top: 8.0, left: 8.0),
                                          child: Text(
                                            field.errorText ?? '',
                                            style: TextStyle(
                                              color: Colors.red,
                                            ),
                                          ),
                                        )
                                      : SizedBox(),
                                ],
                              ),
                            );
                          }),
                          VerkerSearchResult(
                            onSearchTap: (e) {
                              context.read<RegisterCompanyBloc>().addAddress(e);
                            },
                            result: result,
                            onCurrentLocationTap: () {
                              BlocProvider.of<AddressCubit>(context)
                                  .searchByCoordinates();
                            },
                          ),
                        ],
                      );
                    },
                  );
                } else {
                  return Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: VerkerSelectedValue(
                      onClear: () {
                        context.read<RegisterCompanyBloc>().clearAddress();
                      },
                      location: parentState.address!,
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
