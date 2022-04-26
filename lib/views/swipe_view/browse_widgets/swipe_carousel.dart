import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:verker_prof/blocs/swipe_bloc/swipe_bloc.dart';
import 'package:verker_prof/models/project.dart';
import 'package:verker_prof/services/variables.dart';
import 'package:verker_prof/theme/widgets/components.dart';
import 'package:verker_prof/views/swipe_view/browse_widgets/browse_end.dart';
import 'package:verker_prof/views/swipe_view/browse_widgets/project_swipe_card.dart';

class SwipeSection extends StatelessWidget {
  const SwipeSection({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SwipeBloc, SwipeState>(
      builder: (context, state) {
        if (state.projects.isEmpty) {
          return CenterText('Vi kunne ikke finde nogen projekter desværre');
        }
        if (state.status == ProjectStatus.failed) {}
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
                      ? CenterText('LOADING')
                      : BrowseEnd();
                }
                if (indexOne != state.projects.length - 1) {
                  precacheImages(state.projects[indexOne + 1].images, context);
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
