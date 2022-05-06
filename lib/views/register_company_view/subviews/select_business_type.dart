import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:verker_prof/blocs/company_register_bloc/company_register_bloc.dart';
import 'package:verker_prof/theme/constants/textstyle.dart';

List<String> types = [
  'Tømrer',
  'VVS',
  'Murer',
  'Elektriker',
];

class SelectBusinessType extends StatelessWidget {
  const SelectBusinessType({Key? key}) : super(key: key);

  final bool showComplianceError = false;

  final bool termsAccept = false;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CompanyRegisterBloc, CompanyRegisterState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: Text(
                'Vælg din branche:',
                style: kMediumBold,
              ),
            ),
            const SizedBox(height: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: types
                  .map((e) => InkWell(
                        onTap: () {
                          context
                              .read<CompanyRegisterBloc>()
                              .add(AddValues(type: e));
                        },
                        child: Container(
                          color: e == state.companyModel.type
                              ? Colors.grey.withOpacity(0.5)
                              : null,
                          padding: const EdgeInsets.symmetric(
                              vertical: 20, horizontal: 20),
                          child: Text(
                            e,
                            style: kSmallBold,
                          ),
                        ),
                      ))
                  .toList(),
            )
          ],
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
