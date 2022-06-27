import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:verker_prof/features/projects/bloc/projects_bloc/projects_cubit.dart';
import 'package:verker_prof/features/projects/models/project.dart';
import 'package:verker_prof/features/projects/views/project_details_view/project_details_screen.dart';
import 'package:verker_prof/features/swipe/bloc/swipe_bloc/swipe_bloc.dart';
import 'package:verker_prof/features/swipe/views/swipe_view/browse_widgets/swipe_carousel.dart';
import 'package:verker_prof/utils/config.dart';
import 'package:verker_prof/utils/theme/constants/textstyle.dart';

class ProjectSwipeCard extends StatefulWidget {
  final ProjectModel project;
  final void Function() onButtonPress;

  const ProjectSwipeCard({
    Key? key,
    required this.project,
    required this.onButtonPress,
  }) : super(key: key);

  @override
  State<ProjectSwipeCard> createState() => _ProjectSwipeCardState();
}

class _ProjectSwipeCardState extends State<ProjectSwipeCard> {
  int _currentImage = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    precacheImages(widget.project.images, context);
  }

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
            offset: const Offset(0, 5), // changes position of shadow
          ),
        ],
        color: Colors.white,
      ),
      margin: const EdgeInsets.all(14),
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
                    padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                    child: SizedBox(
                      width: 300,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(widget.project.title!,
                              maxLines: 1, style: kLargeBoldWhite),
                          Text(
                              '${widget.project.address!['address'] ??= "N/A"} - ${widget.project.distance!.toInt()} km',
                              style: const TextStyle(color: Colors.white)),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            widget.project.description!,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            style: const TextStyle(color: Colors.white),
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
                          child: ProjectDetailsView(
                            project: widget.project,
                          ),
                        ),
                      ),
                    ),
                  );
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(7),
                        bottomRight: Radius.circular(7)),
                    color: Colors.black,
                  ),
                  child: const Center(
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
