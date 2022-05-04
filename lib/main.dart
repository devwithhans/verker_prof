import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';
import 'package:verker_prof/blocs/auth_bloc/auth_bloc.dart';
import 'package:verker_prof/blocs/login_bloc/login_bloc.dart';
import 'package:verker_prof/blocs/projects_bloc/projects_cubit.dart';
import 'package:verker_prof/blocs/projects_bloc/projects_event.dart';
import 'package:verker_prof/repositories/authRepo.dart';
import 'package:verker_prof/repositories/chatRepo.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:verker_prof/views/login_view/login_view.dart';
import 'package:verker_prof/views/register_view/register_view.dart';
import 'package:verker_prof/wrapper.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(App());
}
// void main() async {
//   runApp(App());
// }

/// App is the topwidget responisble for initializing global BLoC, repositories and,
/// other dependisies.

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
              '/': (context) => Wrapper(),
              RegisterView.name: (context) => RegisterView(),
              LoginView.name: (context) => LoginView(),
            },
            title: 'Verker',
            theme: ThemeData(
              sliderTheme: SliderThemeData(
                trackHeight: 1.5,
                overlayShape: SliderComponentShape.noOverlay,
                thumbShape: RoundSliderThumbShape(elevation: 4),
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
