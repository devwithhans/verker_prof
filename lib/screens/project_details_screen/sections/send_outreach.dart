import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:verker_prof/blocs/outreach_bloc/outreach_bloc.dart';
import 'package:verker_prof/theme/components/verker_formfield.dart';

import 'package:verker_prof/theme/constants/textstyle.dart';
import 'package:verker_prof/widgets/buttons.dart';

class SendOutreachSheet extends StatefulWidget {
  SendOutreachSheet({required this.projectId, Key? key}) : super(key: key);
  String projectId;

  @override
  State<SendOutreachSheet> createState() => _SendOutreachSheetState();
}

class _SendOutreachSheetState extends State<SendOutreachSheet> {
  final _formKey = GlobalKey<FormState>();

  String _message = '';

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          const Text(
            'Send et overslag',
            style: kTextMediumBold,
          ),
          SizedBox(height: 20),
          const Divider(
            height: 0,
          ),
          StandardInputForm(
            multiline: true,
            title: 'Skriv en besked',
            hintText:
                'Forklar hvorfor netop du er den bedste til dette projekt',
            onChanged: (v) {
              _message = v;
            },
            validator: ((value) {
              if (_message.isEmpty) {
                return 'Husk denne besked';
              }
            }),
          ),
          Row(
            children: [
              Expanded(
                child: NavigationButton(
                  textColor: Colors.white,
                  backgroundColor: Colors.black,
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      BlocProvider.of<OutreachBloc>(context).add(
                        SendOutreach(
                          message: _message,
                          projectId: widget.projectId,
                        ),
                      );
                    }
                  },
                  text: 'SEND',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
