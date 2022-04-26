import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';
import 'package:verker_prof/blocs/auth_bloc/auth_bloc.dart';
import 'package:verker_prof/blocs/auth_bloc/auth_event.dart';
import 'package:verker_prof/screens/home_screen/home_screen.dart';
import 'package:verker_prof/screens/projects_screen/projects_navigation.dart';
import 'package:verker_prof/screens/swipe_screen/swipe_screen.dart';
import 'package:verker_prof/theme/fonts/icons.dart';
import 'package:verker_prof/widgets/buttons.dart';

import 'package:verker_prof/widgets/components.dart';

class NavScreenDeligator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final List<Widget> _widgetOptions = <Widget>[
      HomeScreen(),
      BrowseProjects(),
      ProjectTab(),
      Center(
        child: StandardButton(
          onPressed: () {
            BlocProvider.of<AuthBloc>(context).add(LoggedOut());
            // RepositoryProvider.of<AuthenticationRepository>(context)
            //     .refreshJWT();
          },
          text: "SignOut",
        ),
      )
    ];
    return NavScreen(_widgetOptions);
  }
}

class NavScreen extends StatefulWidget {
  final List<Widget> screens;

  NavScreen(this.screens);

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _currentIndex, children: widget.screens),

      // _widgetOptions.elementAt(_currentIndex),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              blurRadius: 20,
              color: Colors.black.withOpacity(.1),
            )
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
                text: 'Home',
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
                text: 'Profile',
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
