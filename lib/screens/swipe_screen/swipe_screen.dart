import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:verker_prof/blocs/auth_bloc/auth_bloc.dart';
import 'package:verker_prof/blocs/swipe_bloc/swipe_bloc.dart';
import 'package:verker_prof/models/filter.dart';
import 'package:verker_prof/screens/swipe_screen/sections/browse_header.dart';
import 'package:verker_prof/screens/swipe_screen/sections/swipe_carousel.dart';

class BrowseProjects extends StatelessWidget {
  const BrowseProjects({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var user = BlocProvider.of<AuthBloc>(context).state.user;

    return BlocProvider<SwipeBloc>(
      create: (context) => SwipeBloc()
        ..add(
          FetchProjects(
            projectSearchFilter: ProjectSearchFilter(
              position: const [55.617616, 11.641377],
              type: 'Tømrer',
              maxDistance: 500000,
            ),
          ),
        ),
      child: Scaffold(
          body: SafeArea(
        child: Column(
          children: const [
            BrowseHeader(),
            Expanded(
              child: SwipeSection(),
            ),
          ],
        ),
      )),
    );
  }
}
