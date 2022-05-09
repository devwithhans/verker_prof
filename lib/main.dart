import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:get_it/get_it.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';
import 'package:verker_prof/blocs/auth_bloc/auth_bloc.dart';
import 'package:verker_prof/blocs/login_bloc/login_bloc.dart';
import 'package:verker_prof/blocs/projects_bloc/projects_cubit.dart';
import 'package:verker_prof/blocs/projects_bloc/projects_event.dart';
import 'package:verker_prof/blocs/swipe_bloc/swipe_bloc.dart';
import 'package:verker_prof/models/filter.dart';
import 'package:verker_prof/repositories/auth_repo.dart';
import 'package:verker_prof/repositories/chat_repo.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:verker_prof/views/login_view/login_view.dart';
import 'package:verker_prof/views/register_view/register_view.dart';
import 'package:verker_prof/wrapper.dart';
import 'firebase_options.dart';

GetIt getIt = GetIt.instance;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  getIt.registerSingleton<BaseCacheManager>(CacheManager(Config('cache')),
      signalsReady: true);
  runApp(App());
}

class App extends StatelessWidget {
  final _streamChatClient = StreamChatClient(
    'cm6ynpu8m6f9',
    logLevel: Level.OFF,
  ); // We initialise the streamchat client

  App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<ChatRepository>(
            create: (context) => ChatRepository(_streamChatClient)),
        RepositoryProvider<AuthenticationRepository>(
          create: (context) => AuthenticationRepository(context.read()),
        ),
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
          BlocProvider<LoginBloc>(
            create: (BuildContext context) => LoginBloc(
              authenticationRepository:
                  context.read<AuthenticationRepository>(),
            ),
          ),
          BlocProvider<AuthBloc>(
            create: (BuildContext context) => AuthBloc(
              authenticationRepository:
                  context.read<AuthenticationRepository>(),
            ),
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
          child: MaterialApp(
            localizationsDelegates: GlobalMaterialLocalizations.delegates,
            supportedLocales: const [Locale('da')],
            builder: (context, child) => StreamChat(
              child: child,
              client: _streamChatClient,
            ),
            routes: {
              '/': (context) => const Wrapper(),
              RegisterView.name: (context) => const RegisterView(),
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
    );
  }
}
