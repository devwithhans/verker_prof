import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:verker_prof/features/projects/models/project.dart';
import 'package:verker_prof/features/swipe/bloc/swipe_bloc/swipe_bloc.dart';
import 'package:verker_prof/features/swipe/views/swipe_view/browse_widgets/browse_end.dart';
import 'package:verker_prof/features/swipe/views/swipe_view/browse_widgets/project_swipe_card.dart';
import 'package:verker_prof/utils/config.dart';
import 'package:verker_prof/utils/theme/constants/textstyle.dart';
import 'package:verker_prof/utils/theme/widgets/components.dart';

class SwipeSection extends StatelessWidget {
  const SwipeSection({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SwipeBloc, SwipeState>(
      builder: (context, state) {
        if (state.status == ProjectStatus.failed) {
          return const Padding(
            padding: EdgeInsets.all(8.0),
            child: CenterText(
              'Du har ikke accepteret at dele lokation, og vi kan derfor ikke vise projekter i nærheden af dig.',
              style: kMediumBold,
            ),
          );
        }
        if (state.projects.isEmpty) {
          return Container(
            color: Colors.white,
            child: const CenterText(
                'Vi kunne ikke finde nogen projekter desværre'),
          );
        }
        if (state.projects.isNotEmpty) {
          return CarouselSlider.builder(
              options: CarouselOptions(
                autoPlay: false,
                initialPage: state.currentIndex,
                viewportFraction: 1,
                enableInfiniteScroll: false,
                height: double.infinity,
              ),
              itemCount: state.projects.length + 1,
              itemBuilder: (context, indexOne, indexTwo) {
                if (indexOne == state.projects.length) {
                  return state.status == ProjectStatus.loading
                      ? const CenterText('LOADING')
                      : const BrowseEnd();
                }
                if (indexOne == state.projects.length - 1 &&
                    !state.hasReachedMax) {
                  context
                      .read<SwipeBloc>()
                      .add(FetchProjects(currentIndex: indexOne));
                }
                ProjectModel project = state.projects[indexOne];
                return ProjectSwipeCard(
                  onButtonPress: () async {},
                  project: project,
                );
              });
        }
        return CenterText(state.toString());
      },
    );
  }
}

precacheImages(List images, context) {
  for (var i in images) {
    precacheImage(NetworkImage(imageUrl + i), context);
  }
}
