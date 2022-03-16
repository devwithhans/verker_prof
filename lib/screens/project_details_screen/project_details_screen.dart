import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:verker_prof/blocs/outreach_bloc/outreach_bloc.dart';
import 'package:verker_prof/blocs/projects_bloc/projects_cubit.dart';
import 'package:verker_prof/blocs/swipe_bloc/swipe_bloc.dart';
import 'package:verker_prof/models/project.dart';
import 'package:verker_prof/screens/project_details_screen/sections/image_inspect.dart';
import 'package:verker_prof/services/variables.dart';
import 'package:verker_prof/theme/constants/textstyle.dart';
import 'package:verker_prof/widgets/buttons.dart';
import 'package:verker_prof/widgets/components.dart';

class ProjectDetails extends StatelessWidget {
  final ProjectModel project;

  ProjectDetails({required this.project, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SwipeBloc swipeBloc = context.read<SwipeBloc>();
    ProjectsCubit projectsCubit = context.read<ProjectsCubit>();
    String _initialMessage = '';

    List media = [];
    media = project.images;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: IconButton(
          color: Colors.black,
          splashRadius: 20,
          focusColor: Colors.black,
          splashColor: Colors.black,
          highlightColor: Colors.black,
          icon: Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(
                color: Colors.black, borderRadius: BorderRadius.circular(20)),
            child: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Stack(
        children: [
          ListView(
            padding: EdgeInsets.symmetric(horizontal: 0),
            children: [
              SizedBox(
                  height: 500,
                  child: CarouselSlider.builder(
                      options: carouselOptions,
                      itemCount: media.length,
                      itemBuilder: (context, indexOne, indexTwo) {
                        return InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ImageInspect(
                                  image: imageUrl + project.images[indexOne],
                                ),
                              ),
                            );
                          },
                          child: Container(
                            height: 200,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage(
                                    imageUrl + project.images[indexOne]),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        );
                      })),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      project.title!,
                      maxLines: 1,
                      overflow: TextOverflow.clip,
                      style: kTextMediumBold,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      '${project.address!['zip']} ( ${project.distance!.toInt()} Km )',
                    ),
                    const Divider(
                      thickness: 1,
                    ),
                    Text(
                      project.description!,
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Positioned(
            bottom: 40,
            left: 20,
            right: 20,
            child: ContinueButton(
              onPressed: () async {
                showModalBottomSheet(
                  isScrollControlled: true,
                  backgroundColor: Colors.transparent,
                  context: context,
                  builder: (context) => BlocProvider<OutreachBloc>(
                    create: (context) => OutreachBloc(swipeBloc, projectsCubit),
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.8,
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(15),
                              topLeft: Radius.circular(15))),
                      child: Padding(
                        padding: EdgeInsets.all(20),
                        child: BlocBuilder<OutreachBloc, OutreachState>(
                          builder: (context, state) {
                            if (state.status == OutreachStatus.succes) {
                              Future.delayed(Duration.zero, () {
                                Navigator.of(context)
                                    .popUntil(ModalRoute.withName('/'));
                              });
                            }
                            if (state.status == OutreachStatus.failed) {
                              return CenterText(
                                  'Vi kunne ikke sende din besked, prøv igen senere');
                            }
                            if (state.status == OutreachStatus.initial) {
                              return Column(
                                children: [
                                  const Text(
                                    'Send et overslag',
                                    style: kTextMediumBold,
                                  ),
                                  SizedBox(height: 20),
                                  const Divider(
                                    height: 0,
                                  ),
                                  Expanded(
                                    child: ListView(
                                      children: [
                                        const SizedBox(height: 20),
                                        const Text(
                                          'Skriv en besked',
                                          style: kTextSmallBold,
                                        ),
                                        TextFormField(
                                          keyboardType: TextInputType.multiline,
                                          textCapitalization:
                                              TextCapitalization.sentences,
                                          maxLines: null,
                                          onChanged: (value) {
                                            _initialMessage = value;
                                          },
                                          cursorColor: Colors.black,
                                          style: TextStyle(fontSize: 18),
                                          decoration: const InputDecoration(
                                            enabledBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.black),
                                            ),
                                            focusedBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.black),
                                            ),
                                            hintMaxLines: 20,
                                            hintText:
                                                'Forklar hvad dit projekt går ud på. Skriv f.eks. hvis du har nogle konkrete mål som f.eks. 20 km2 skal males.',
                                          ),
                                        ),
                                        SizedBox(height: 20),
                                        NavigationButton(
                                          onPressed: () async {
                                            context.read<OutreachBloc>().add(
                                                  SendOutreach(
                                                      message: _initialMessage,
                                                      projectId: project.id!),
                                                );
                                          },
                                          text: 'SEND',
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              );
                            }

                            return CircularProgressIndicator();
                          },
                        ),
                      ),
                    ),
                  ),
                );
              },
              backgroundColor: Colors.black,
              textColor: Colors.white,
              text: 'Giv et bud',
            ),
          )
        ],
      ),
    );
  }

  CarouselOptions carouselOptions = CarouselOptions(
    autoPlay: false,
    viewportFraction: 1,
    enableInfiniteScroll: false,
    height: double.infinity,
    enlargeCenterPage: true,
    enlargeStrategy: CenterPageEnlargeStrategy.height,
  );
}

class ThousandsSeparatorInputFormatter extends TextInputFormatter {
  static const separator = '.'; // Change this to '.' for other locales

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    // Short-circuit if the new value is empty
    if (newValue.text.length == 0) {
      return newValue.copyWith(text: '');
    }

    // Handle "deletion" of separator character
    String oldValueText = oldValue.text.replaceAll(separator, '');
    String newValueText = newValue.text.replaceAll(separator, '');

    if (oldValue.text.endsWith(separator) &&
        oldValue.text.length == newValue.text.length + 1) {
      newValueText = newValueText.substring(0, newValueText.length - 1);
    }

    // Only process if the old value and new value are different
    if (oldValueText != newValueText) {
      int selectionIndex =
          newValue.text.length - newValue.selection.extentOffset;
      final chars = newValueText.split('');

      String newString = '';
      for (int i = chars.length - 1; i >= 0; i--) {
        if ((chars.length - 1 - i) % 3 == 0 && i != chars.length - 1)
          newString = separator + newString;
        newString = chars[i] + newString;
      }

      return TextEditingValue(
        text: newString.toString(),
        selection: TextSelection.collapsed(
          offset: newString.length - selectionIndex,
        ),
      );
    }

    // If the new value and old value are the same, just return as-is
    return newValue;
  }
}
