import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';
import 'package:verker_prof/features/authentication/bloc/firebase_auth_bloc/firebase_auth_bloc.dart';
import 'package:verker_prof/features/authentication/bloc/firebase_auth_bloc/firebase_auth_event.dart';

import 'package:verker_prof/features/authentication/views/home_view/home_view.dart';
import 'package:verker_prof/features/authentication/views/profile_view/profile_view.dart';
import 'package:verker_prof/features/projects/views/projects_view/projects_view.dart';
import 'package:verker_prof/features/swipe/views/new_swipe_view/new_swipe_view.dart';
import 'package:verker_prof/utils/config.dart';
import 'package:verker_prof/utils/theme/fonts/icons.dart';
import 'package:verker_prof/utils/theme/widgets/buttons.dart';
import 'package:verker_prof/utils/theme/widgets/components.dart';

class NavScreenDeligator extends StatelessWidget {
  const NavScreenDeligator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Widget> _widgetOptions = <Widget>[
      const HomeView(),
      // const BrowseProjectsView(),
      const NewSwipeSceen(),
      const ProjectsView(),
      const ProfileView()
    ];
    return NavScreen(_widgetOptions);
  }
}

class NavScreen extends StatefulWidget {
  final List<Widget> screens;

  const NavScreen(this.screens, {Key? key}) : super(key: key);

  @override
  State<NavScreen> createState() => _NavScreenState();
}

class _NavScreenState extends State<NavScreen> {
  var _currentIndex = 0;
  String companyId = "";

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.screens[_currentIndex],

      // IndexedStack(index: _currentIndex, children: widget.screens),

      // _widgetOptions.elementAt(_currentIndex),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              blurRadius: 20,
              color: Colors.black.withOpacity(.1),
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.fromLTRB(
              15, 12, 15, MediaQuery.of(context).padding.bottom),

          // padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
          child: GNav(
            rippleColor: Colors.grey[300]!,
            hoverColor: Colors.grey[100]!,
            gap: 8,
            activeColor: Colors.black,
            iconSize: 24,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            duration: const Duration(milliseconds: 400),
            tabBackgroundColor: Colors.grey[100]!,
            color: Colors.black,
            tabs: [
              const GButton(
                icon: VerkerIcons.company,
                text: 'Hjem',
              ),
              const GButton(
                icon: VerkerIcons.projectSwipe,
                text: 'Swipe',
              ),
              GButton(
                leading: StreamBuilder<int>(
                    stream: StreamChat.of(context)
                        .client
                        .state
                        .totalUnreadCountStream,
                    builder: (context, snapshot) {
                      int unreadCount = 0;
                      if (snapshot.hasData) {
                        unreadCount = snapshot.data as int;
                      }
                      return Badge(
                        number: unreadCount,
                        icon: const Icon(
                          VerkerIcons.project,
                        ),
                      );
                    }),
                icon: VerkerIcons.project,
                text: 'Projekter',
              ),
              const GButton(
                icon: VerkerIcons.profile,
                text: 'Profil',
              ),
            ],
            selectedIndex: _currentIndex,
            onTabChange: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
          ),
        ),
      ),
    );
  }
}
