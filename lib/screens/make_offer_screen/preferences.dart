import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';
import 'package:verker_prof/blocs/offer_bloc/offer_bloc.dart';
import 'package:verker_prof/theme/components/verker_formfield.dart';

class Preferences extends StatelessWidget {
  const Preferences({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      child: BlocBuilder<OfferBloc, OfferState>(
        builder: (context, state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Angiv vigtige informationer',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              VerkerDatePicker(
                title: 'Mulig opstart',
                hintText: 'Vælg dato',
                value: state.startDate,
                onSelect: (v) {
                  BlocProvider.of<OfferBloc>(context).add(StartDate(v));
                },
              ),
              VerkerDatePicker(
                title: 'Tilbuddet udløber',
                hintText: 'Vælg dato',
                value: state.offerExpires,
                onSelect: (v) {
                  BlocProvider.of<OfferBloc>(context).add(OfferExpires(v));
                },
              ),
            ],
          );
        },
      ),
    );
  }
}

class VerkerDatePicker extends StatelessWidget {
  final Function(DateTime value) onSelect;
  final DateTime? value;
  final String hintText;
  final String title;

  const VerkerDatePicker({
    required this.hintText,
    required this.title,
    this.value,
    required this.onSelect,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DateTime? _startDate;
    return VerkerFormField(
      controller: TextEditingController(
        text: value == null ? null : Jiffy(value).format('dd-MM-yyyy'),
      ),
      onTap: () async {
        _startDate = await showDatePicker(
          locale: const Locale('da'),
          context: context,
          initialDate: value ?? DateTime.now(),
          builder: (context, child) {
            return Theme(
              data: Theme.of(context).copyWith(
                colorScheme: ColorScheme.light(
                  primary: Colors.black, // header background color
                  onPrimary: Colors.white, // header text color
                  onSurface: Colors.black, // body text color
                ),
                textButtonTheme: TextButtonThemeData(
                  style: TextButton.styleFrom(
                    primary: Colors.black, // button text color
                  ),
                ),
              ),
              child: child!,
            );
          },
          helpText: 'Vælg en dato',
          confirmText: 'VÆLG',
          cancelText: 'ANNULER',
          fieldLabelText: 'Vælg dato',
          firstDate: DateTime.now(),
          lastDate: DateTime(2030),
        );
        if (_startDate != null) {
          onSelect(_startDate!);
        }
      },
      focused: false,
      title: title,
      hintText: hintText,
      onChanged: (v) {},
      validator: (v) {},
    );
  }
}
