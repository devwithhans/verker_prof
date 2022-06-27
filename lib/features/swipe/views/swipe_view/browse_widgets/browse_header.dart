import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:verker_prof/features/swipe/bloc/swipe_bloc/swipe_bloc.dart';
import 'package:verker_prof/utils/theme/fonts/icons.dart';
import 'package:verker_prof/views/swipe_view/browse_widgets/swipe_filter.dart';

class BrowseHeader extends StatelessWidget {
  const BrowseHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                showModalBottomSheet(
                    isScrollControlled: true,
                    context: context,
                    backgroundColor: Colors.transparent,
                    builder: (_) {
                      return BlocProvider.value(
                          value: BlocProvider.of<SwipeBloc>(context),
                          child: const Filter());
                    });
              },
              icon: const Icon(VerkerIcons.slider))
        ],
      ),
    );
  }
}
