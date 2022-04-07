import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:verker_prof/blocs/swipe_bloc/swipe_bloc.dart';
import 'package:verker_prof/models/filter.dart';
import 'package:verker_prof/screens/swipe_screen/sections/swipe_filter.dart';
import 'package:verker_prof/theme/fonts/icons.dart';

class BrowseHeader extends StatelessWidget {
  const BrowseHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SwipeState state = BlocProvider.of<SwipeBloc>(context).state;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Image(
            image: AssetImage('assets/VerkerLogo.png'),
            width: 100,
          ),
          IconButton(
              onPressed: () async {
                ProjectSearchFilter? filter = await showModalBottomSheet(
                    isScrollControlled: true,
                    context: context,
                    backgroundColor: Colors.transparent,
                    builder: (_) {
                      return BlocProvider.value(
                          value: BlocProvider.of<SwipeBloc>(context),
                          child: Filter());
                    });
              },
              icon: const Icon(VerkerIcons.slider))
        ],
      ),
    );
  }
}
