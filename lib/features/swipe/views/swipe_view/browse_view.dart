import 'package:flutter/material.dart';
import 'package:verker_prof/features/swipe/views/swipe_view/browse_widgets/browse_header.dart';
import 'package:verker_prof/features/swipe/views/swipe_view/browse_widgets/swipe_carousel.dart';

class BrowseProjectsView extends StatelessWidget {
  const BrowseProjectsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Column(
        children: const [
          BrowseHeader(),
          Expanded(
            child: SwipeSection(),
          ),
        ],
      ),
    ));
  }
}
