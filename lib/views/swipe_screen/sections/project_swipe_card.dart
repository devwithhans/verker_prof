import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:verker_prof/blocs/projects_bloc/projects_cubit.dart';
import 'package:verker_prof/blocs/swipe_bloc/swipe_bloc.dart';
import 'package:verker_prof/models/project.dart';

import 'package:verker_prof/screens/project_details_screen/project_details_screen.dart';
import 'package:verker_prof/services/variables.dart';
import 'package:verker_prof/theme/constants/textstyle.dart';

class ProjectSwipeCard extends StatefulWidget {
  final ProjectModel project;
  final void Function() onButtonPress;

  ProjectSwipeCard({
    required this.project,
    required this.onButtonPress,
  });

  @override
  State<ProjectSwipeCard> createState() => _ProjectSwipeCardState();
}

class _ProjectSwipeCardState extends State<ProjectSwipeCard> {
  int _currentImage = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 2,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(7),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 5), // changes position of shadow
          ),
        ],
        color: Colors.white,
      ),
      margin: EdgeInsets.all(14),
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 30,
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      end: Alignment(0.0, 0.4),
                      begin: Alignment(0.0, -1),
                      colors: <Color>[Color(0x8A000000), Colors.black],
                    ),
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(7),
                        topRight: Radius.circular(7)),
                    image: DecorationImage(
                      image: NetworkImage(
                          imageUrl + widget.project.images[_currentImage]),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    height: double.infinity,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        end: Alignment(0.0, -0.1),
                        begin: Alignment(0.0, 1.0),
                        colors: <Color>[
                          Colors.black,
                          Colors.transparent,
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 20,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                    child: SizedBox(
                      width: 300,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(widget.project.title!,
                              maxLines: 1, style: kLargeBoldWhite),
                          Text(
                              '${widget.project.address!['address'] ??= "N/A"} - ${widget.project.distance!.toInt()} km',
                              style: TextStyle(color: Colors.white)),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            widget.project.description!,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          HapticFeedback.mediumImpact();
                          if (_currentImage != 0) {
                            setState(
                              () {
                                _currentImage--;
                              },
                            );
                          }
                        },
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          HapticFeedback.mediumImpact();

                          if (widget.project.images.length - 1 !=
                              _currentImage) {
                            setState(
                              () {
                                _currentImage++;
                              },
                            );
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            flex: 4,
            child: SizedBox(
              height: 100,
              width: double.infinity,
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => BlocProvider.value(
                        value: context.read<SwipeBloc>(),
                        child: BlocProvider.value(
                          value: context.read<ProjectsBloc>(),
                          child: ProjectDetails(
                            project: widget.project,
                          ),
                        ),
                      ),
                    ),
                  );
                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(7),
                        bottomRight: Radius.circular(7)),
                    color: Colors.black,
                  ),
                  child: Center(
                    child: Text(
                      'Se hele projektet',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
