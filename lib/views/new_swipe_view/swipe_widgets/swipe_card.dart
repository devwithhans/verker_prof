import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:verker_prof/models/project.dart';
import 'package:verker_prof/theme/constants/textstyle.dart';
import 'package:verker_prof/theme/widgets/components.dart';
import 'package:verker_prof/theme/widgets/status_badge.dart';
import 'package:verker_prof/views/new_swipe_view/new_swipe_view.dart';
import 'package:verker_prof/views/project_details_view/project_details_screen.dart';

class NewSwipeCard extends StatefulWidget {
  final ProjectModel project;

  const NewSwipeCard(this.project, {Key? key}) : super(key: key);

  @override
  State<NewSwipeCard> createState() => _NewSwipeCardState();
}

class _NewSwipeCardState extends State<NewSwipeCard> {
  int _currentImage = 0;

  void _navigateToDetails() {
    Navigator.of(context).push(
      MaterialPageRoute(
          builder: (context) => ProjectDetailsView(
                project: widget.project,
              )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragUpdate: (details) {
        if (details.primaryDelta! < 1.0) {
          _navigateToDetails();
        }
      },
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: CachedNetworkImageProvider(
                    widget.project.images[_currentImage]),
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
                  end: Alignment(0.0, 0.5),
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
              padding: const EdgeInsets.fromLTRB(15, 10, 15, 0),
              child: SizedBox(
                width: MediaQuery.of(context).size.width - 30,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Text(widget.project.title!,
                    //     maxLines: 1, style: kLargeBoldWhite),

                    Wrap(
                      children: [
                        StatusBadge(
                            text: widget.project.projectType!,
                            color: Colors.amberAccent),
                        StatusBadge(
                            text: 'Materialer haves',
                            color: Colors.amberAccent),
                      ],
                    ),
                    SizedBox(height: 5),
                    Text(
                      widget.project.description!,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 3,
                      style: const TextStyle(color: Colors.white, fontSize: 16),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                        '${widget.project.address!['address'] ??= "N/A"} - ${widget.project.distance!.toInt()} km',
                        style: kSmallBoldWhite),
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

                    if (widget.project.images.length - 1 != _currentImage) {
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
    );
  }
}
