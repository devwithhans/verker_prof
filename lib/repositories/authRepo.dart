import 'dart:async';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:graphql/client.dart';
import 'package:verker_prof/blocs/auth_bloc/auth_bloc.dart';
import 'package:verker_prof/models/user.dart';
import 'package:verker_prof/repositories/chatRepo.dart';
import 'package:verker_prof/services/graphql/GrapgQLService.dart';
import 'package:verker_prof/services/graphql/queries/auth.dart';

// This repo contains all the logic of authentication

class AuthenticationRepository {
  final _controller = StreamController<AuthState>();

  final ChatRepository chatRepository;

  final storage = FlutterSecureStorage();

  late GraphQLService _graphQLService;

  AuthenticationRepository(this.chatRepository) {
    _graphQLService = GraphQLService();
  }

  // We create the stream for connecting to the BLoC's
  Stream<AuthState> get status async* {
    String? jwt = await storage.read(key: 'jwt');
    // await storage.delete(key: 'jwt');
    if (jwt != null) {
      QueryResult result = await _graphQLService.performQuery(getUser);
      if (result.hasException) {
        yield UnAuthorised();
      }
      if (result.data != null) {
        UserData userData = UserData.convert(result.data!['getUser']);
        try {
          dynamic user = await chatRepository.connectUser(userData);
          if (user != null) {
            if (userData.verker) {
              yield Authorised(user: userData);
            }
          } else {
            _controller.add(UnAuthorised());
          }
        } catch (e) {
          yield ErrorAccured(ErrorType.missingLicence);
        }
      }
    } else {
      yield UnAuthorised();
    }
    yield* _controller.stream;
  }

  Future logIn({
    required String email,
    required String password,
  }) async {
    QueryResult result = await _graphQLService.performQuery(signInUser,
        variables: {"email": email, "password": password});

    if (result.data!['signinUser']['jwt'] != null) {
      storage.write(key: 'jwt', value: result.data!['signinUser']['jwt']);
      dynamic userData = UserData.convert(result.data!['signinUser']['user']);
      dynamic user = await chatRepository.connectUser(userData);

      if (user != null) {
        _controller.add(Authorised(user: userData));
      } else {
        _controller.add(UnAuthorised());
      }

      return user;
    } else {
      _controller.add(UnAuthorised());
      return null;
    }
  }

  void logOut() async {
    await storage.delete(key: 'jwt');
    _controller.add(UnAuthorised());
  }

  void dispose() => _controller.close();
}
