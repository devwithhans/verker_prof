import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';
import 'package:verker_prof/blocs/auth_bloc/auth_bloc.dart';
import 'package:verker_prof/blocs/login_bloc/login_bloc.dart';
import 'package:verker_prof/blocs/projects_bloc/projects_cubit.dart';
import 'package:verker_prof/repositories/authRepo.dart';
import 'package:verker_prof/repositories/chatRepo.dart';
import 'package:verker_prof/screens/login_screens/login.dart';
import 'package:verker_prof/screens/login_screens/register.dart';
import 'package:verker_prof/wrapper.dart';

void main() async {
  runApp(App());
}

/// App is the topwidget responisble for initializing global BLoC, repositories and
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
          BlocProvider<AuthBloc>(
            create: (BuildContext context) => AuthBloc(
              authenticationRepository:
                  context.read<AuthenticationRepository>(),
            ),
          ),
          BlocProvider<LoginBloc>(
            create: (BuildContext context) => LoginBloc(
              authenticationRepository:
                  context.read<AuthenticationRepository>(),
            ),
          ),
          BlocProvider<ProjectsCubit>(
            create: (BuildContext context) => ProjectsCubit(_streamChatClient),
          )
        ],
        child: MaterialApp(
          builder: (context, child) => StreamChat(
            child: child,
            client: _streamChatClient,
          ),
          routes: {
            '/': (context) => Wrapper(),
            RegisterScreen.name: (context) => RegisterScreen(),
            LoginScreen.name: (context) => LoginScreen(),
          },
          title: 'Verker',
          theme: ThemeData(
            appBarTheme: const AppBarTheme(
              backgroundColor: Colors.transparent,
              elevation: 0,
              iconTheme: IconThemeData(color: Colors.black),
            ),
            primarySwatch: Colors.blue,
          ),
        ),
      ),
    );
  }
}
