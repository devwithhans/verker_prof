import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:verker_prof/blocs/offer_bloc/offer_bloc.dart';
import 'package:verker_prof/models/project.dart';
import 'package:verker_prof/screens/make_offer_screen/materials/materials.dart';
import 'package:verker_prof/screens/make_offer_screen/offer_description.dart';
import 'package:verker_prof/screens/make_offer_screen/preferences.dart';
import 'package:verker_prof/screens/make_offer_screen/preview.dart';
import 'package:verker_prof/screens/make_offer_screen/salary.dart';
import 'package:verker_prof/screens/make_offer_screen/swipe_to_confirm.dart';

class OfferFormWrap extends StatelessWidget {
  ProjectModel project;
  OfferFormWrap({Key? key, required this.project}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    OfferBloc offerBloc = context.read<OfferBloc>();

    List<Widget> steps = [
      const OfferDesciption(),
      NewMaterial(),
      const Salary(),
      const Preferences(),
      Preview(
        project: project,
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 2,
        titleSpacing: 5,
        title: Text(
          'Lav tilbud',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: BlocBuilder<OfferBloc, OfferState>(
        builder: (context, state) {
          bool validForm = state.finishedSteps.contains(state.currentPage);
          bool atEnd = state.currentPage == steps.length - 1;
          bool atStart = state.currentPage == 0;
          if (state.status == OfferStatus.succes) {
            Navigator.pop(context);
          }
          return state.status == OfferStatus.loading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Stack(
                  children: [
                    steps[state.currentPage],
                    Align(
                        alignment: Alignment.bottomCenter,
                        child: Padding(
                            padding: const EdgeInsets.fromLTRB(20, 20, 20, 30),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                atEnd
                                    ? SwipeToConfirm(
                                        title: Text(
                                          'Send tilbud til kunden',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        icon: Icon(
                                            Icons.arrow_forward_ios_rounded),
                                        onConfirmed: () {
                                          offerBloc.add(SaveOfferAsDraft());
                                        },
                                      )
                                    : SizedBox(),
                                SizedBox(height: 20),
                                Row(
                                  children: [
                                    !atStart
                                        ? Expanded(
                                            child: VerkerButton(
                                              active: true,
                                              onPressed: () {
                                                offerBloc.add(GoToStep(
                                                    state.currentPage - 1));
                                              },
                                              text: 'Tilbage',
                                            ),
                                          )
                                        : SizedBox(),
                                    SizedBox(width: !atStart ? 10 : 0),
                                    !atEnd
                                        ? Expanded(
                                            child: VerkerButton(
                                              active: validForm,
                                              onPressed: () {
                                                offerBloc.add(GoToStep(
                                                    state.currentPage + 1));
                                              },
                                              text: 'Næste',
                                            ),
                                          )
                                        : SizedBox(),
                                  ],
                                ),
                              ],
                            )))
                  ],
                );
        },
      ),
    );
  }
}

class VerkerButton extends StatelessWidget {
  const VerkerButton({
    Key? key,
    required this.text,
    required this.onPressed,
    required this.active,
  }) : super(key: key);

  final void Function() onPressed;
  final bool active;
  final String text;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: active ? onPressed : () {},
      child: Container(
        // margin: EdgeInsets.only(right: 10),
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        color: active ? Colors.black : Colors.grey,
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
