import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:verker_prof/blocs/offer_bloc/offer_bloc.dart';
import 'package:verker_prof/theme/components/verker_formfield.dart';

class Salary extends StatelessWidget {
  const Salary({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();

    double? _hours;
    double? _hourlyRate;

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      child: Form(
        key: _formKey,
        child: BlocBuilder<OfferBloc, OfferState>(
          builder: (context, state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Vælg din antal timer og timepris',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                VerkerFormField(
                  initialValue: state.hours == null
                      ? ''
                      : NumberFormat("###.##", "de_DK").format(state.hours),
                  title: 'Antal timer',
                  number: true,
                  onChanged: (v) {
                    _hours = double.tryParse(
                          v.replaceAll(",", '.'),
                        ) ??
                        null;

                    BlocProvider.of<OfferBloc>(context)
                        .add(TypeHours(hours: _hours, hourlyRate: _hourlyRate));
                  },
                  validator: (v) {},
                ),
                VerkerFormField(
                  initialValue: state.hourlyRate == null
                      ? ''
                      : NumberFormat("###.##", "de_DK")
                          .format(state.hourlyRate),
                  title: 'Timepris eks. moms',
                  price: true,
                  onChanged: (v) {
                    _hourlyRate = double.tryParse(
                          v.replaceAll(",", '.'),
                        ) ??
                        null;
                    BlocProvider.of<OfferBloc>(context)
                        .add(TypeHours(hours: _hours, hourlyRate: _hourlyRate));
                  },
                  validator: (v) {},
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
