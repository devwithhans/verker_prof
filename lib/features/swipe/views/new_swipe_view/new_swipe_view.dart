import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:verker_prof/features/projects/models/project.dart';
import 'package:verker_prof/features/swipe/bloc/swipe_bloc/swipe_bloc.dart';
import 'package:verker_prof/features/swipe/views/new_swipe_view/swipe_widgets/swipe_card.dart';
import 'package:verker_prof/utils/theme/constants/textstyle.dart';
import 'package:verker_prof/utils/theme/fonts/icons.dart';
import 'package:verker_prof/utils/theme/widgets/components.dart';
import 'package:verker_prof/utils/theme/widgets/loading_indicator.dart';
import 'package:verker_prof/views/swipe_view/browse_widgets/swipe_filter.dart';

import '../../../../utils/theme/widgets/buttons.dart';
import '../swipe_view/browse_widgets/browse_end.dart';

class NewSwipeSceen extends StatelessWidget {
  const NewSwipeSceen({Key? key}) : super(key: key);

  static List<Color> colors = [
    Colors.black,
    Colors.white,
    Colors.yellow,
    Colors.pink
  ];

  @override
  Widget build(BuildContext context) {
    void _showFilter() {
      showModalBottomSheet(
          isScrollControlled: true,
          context: context,
          backgroundColor: Colors.transparent,
          builder: (_) {
            return BlocProvider.value(
                value: BlocProvider.of<SwipeBloc>(context),
                child: const Filter());
          });
    }

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        actions: [
          IconButton(
              splashRadius: 0.1,
              onPressed: () async {
                _showFilter();
              },
              icon: const Icon(
                VerkerIcons.slider,
                color: Colors.white,
              ))
        ],
      ),
      body: BlocBuilder<SwipeBloc, SwipeState>(
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
          if (state.status == ProjectStatus.loading) {
            return const Center(child: LoadingIndicator());
          }
          if (state.projects.isEmpty) {
            return Padding(
              padding: const EdgeInsets.all(40.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'Vi kunne ikke finde nogen projekter desværre, prøv at ændre dine filtre',
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 10),
                  StandardButton(
                    onPressed: () {
                      _showFilter();
                    },
                    text: 'Filtrer',
                  )
                ],
              ),
            );
          }

          return PageView.builder(
            physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics()),
            scrollDirection: Axis.vertical,
            controller: PageController(
              initialPage: state.currentIndex,
            ),
            itemCount: state.projects.length + 1,
            itemBuilder: ((context, index) {
              if (index == state.projects.length) {
                return state.status == ProjectStatus.loading
                    ? const CenterText('LOADING')
                    : const BrowseEnd();
              }
              if (index == state.projects.length - 1 && !state.hasReachedMax) {
                context.read<SwipeBloc>().add(
                      FetchProjects(currentIndex: index),
                    );
              }
              ProjectModel project = state.projects[index];
              return NewSwipeCard(project);
            }),
          );
        },
      ),
    );
  }
}
