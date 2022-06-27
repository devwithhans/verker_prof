import 'package:firebase_core/firebase_core.dart';
import 'features/authentication/bloc/firebase_auth_bloc/firebase_auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:get_it/get_it.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';
import 'package:verker_prof/features/swipe/models/filter.dart';
import 'package:verker_prof/features/chat/repositories/chat_repo.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:verker_prof/wrapper.dart';
import 'features/authentication/views/login_view/login_view.dart';
import 'features/projects/bloc/projects_bloc/projects_cubit.dart';
import 'features/projects/bloc/projects_bloc/projects_event.dart';
import 'features/swipe/bloc/swipe_bloc/swipe_bloc.dart';
import 'firebase_options.dart';

GetIt getIt = GetIt.instance;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    name: 'verker_prof',
    options: DefaultFirebaseOptions.currentPlatform,
  );

  getIt.registerSingleton<DefaultCacheManager>(DefaultCacheManager());

  runApp(App());
}

final navigatorKey = GlobalKey<NavigatorState>();

class App extends StatelessWidget {
  final _streamChatClient = StreamChatClient(
    'g55uzxp76u4w',
    logLevel: Level.OFF,
  ); // We initialise the streamchat client

  App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<ChatRepository>(
            create: (context) => ChatRepository(_streamChatClient)),
        // RepositoryProvider<AuthenticationRepository>(
        //   create: (context) => AuthenticationRepository(context.read()),
        // ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<SwipeBloc>(
              create: (context) => SwipeBloc()
                ..add(FetchProjects(
                  projectSearchFilter: ProjectSearchFilter(
                    position: const [55.617616, 11.641377],
                    type: 'Tømrer',
                    maxDistance: 500000,
                  ),
                ))),
          BlocProvider<AuthBloc>(
            create: (BuildContext context) =>
                AuthBloc(RepositoryProvider.of<ChatRepository>(context)),
          ),
          BlocProvider<ProjectsBloc>(
            create: (BuildContext context) =>
                ProjectsBloc(_streamChatClient)..add(FetchMyProjects()),
          )
        ],
        child: GestureDetector(
          onTap: () {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: OverlaySupport.global(
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              navigatorKey: navigatorKey,
              localizationsDelegates: GlobalMaterialLocalizations.delegates,
              supportedLocales: const [Locale('da')],
              builder: (context, child) => StreamChat(
                child: child,
                client: _streamChatClient,
              ),
              routes: {
                '/': (context) => const Wrapper(),
                LoginView.name: (context) => const LoginView(),
              },
              title: 'Verker',
              theme: ThemeData(
                sliderTheme: SliderThemeData(
                  trackHeight: 1.5,
                  overlayShape: SliderComponentShape.noOverlay,
                  thumbShape: const RoundSliderThumbShape(elevation: 4),
                ),
                appBarTheme: const AppBarTheme(
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  iconTheme: IconThemeData(color: Colors.black),
                ),
                primarySwatch: Colors.blue,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
