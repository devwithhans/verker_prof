import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:verker_prof/blocs/swipe_bloc/swipe_bloc.dart';
import 'package:verker_prof/theme/constants/textstyle.dart';
import 'package:verker_prof/theme/fonts/icons.dart';
import 'package:verker_prof/theme/widgets/buttons.dart';
import 'package:verker_prof/theme/widgets/components.dart';
import 'package:verker_prof/theme/widgets/loading_indicator.dart';
import 'package:verker_prof/views/new_swipe_view/swipe_widgets/swipe_card.dart';
import 'package:verker_prof/views/swipe_view/browse_widgets/swipe_filter.dart';

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
    final controller = PageController(
      initialPage: 0,
    );

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
        return Builder(builder: (context) {
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
            body: PageView.builder(
              physics: const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics()),
              scrollDirection: Axis.vertical,
              controller: controller,
              itemCount: colors.length,
              itemBuilder: ((context, index) {
                return NewSwipeCard(state.projects[index]);
              }),
            ),
          );
        });
      },
    );
  }
}
