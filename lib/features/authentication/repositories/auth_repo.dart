// import 'dart:async';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// import 'package:graphql/client.dart';
// import 'package:verker_prof/features/authentication/bloc/auth_bloc/auth_bloc.dart';
// import 'package:verker_prof/features/authentication/models/user.dart';
// import 'package:verker_prof/features/chat/repositories/chat_repo.dart';
// import 'package:verker_prof/features/error/models/errors.dart';
// import 'package:verker_prof/features/authentication/data/quries/auth.dart';
// import 'package:verker_prof/utils/services/graphql_service.dart';

// // This repo contains all the logic of authentication

// class AuthenticationRepository {
//   final _controller = StreamController<AuthState>();

//   final ChatRepository chatRepository;

//   FlutterSecureStorage flutterSecureStorage = const FlutterSecureStorage();

//   late GraphQLService _graphQLService;

//   AuthenticationRepository(this.chatRepository) {
//     _graphQLService = GraphQLService();
//   }

//   // We create the stream for connecting to the BLoC's
//   Stream<AuthState> get status async* {
//     yield LoadingAuthState();
//     String? jwt = await flutterSecureStorage.read(key: 'jwt');
//     // await storage.delete(key: 'jwt');
//     if (jwt != null) {
//       QueryResult result = await _graphQLService.performQuery(getUser);
//       if (result.hasException) {
//         yield ErrorAccured(ErrorType.networkError);
//       }

//       if (result.data == null) {
//         await flutterSecureStorage.delete(key: 'jwt');
//         yield UnAuthorised();
//       }

//       UserData userData = UserData.convert(result.data!['getUser']);

//       if (userData.companyId == null) {
//         yield NoCompany(user: userData);
//       } else {
//         try {
//           dynamic user = await chatRepository.connectUser(userData);
//           if (user != null) {
//             yield Authorised(user: userData);
//           } else {
//             _controller.add(UnAuthorised());
//           }
//         } catch (e) {
//           yield ErrorAccured(ErrorType.missingLicence);
//         }
//       }
//     } else {
//       yield UnAuthorised();
//     }
//     yield* _controller.stream;
//   }

//   Future logIn({
//     required String email,
//     required String password,
//   }) async {
//     QueryResult result = await _graphQLService.performQuery(signInUser,
//         variables: {"email": email, "password": password});

//     if (result.hasException) {
//       return ErrorMessage.getErrorMessage(result);
//     }

//     if (result.data!['signinUser']['jwt'] != null) {
//       flutterSecureStorage.write(
//           key: 'jwt', value: result.data!['signinUser']['jwt']);

//       UserData userData = UserData.convert(result.data!['signinUser']['user']);
//       dynamic user = await chatRepository.connectUser(userData);

//       if (user != null) {
//         if (userData.companyId == null) {
//           _controller.add(NoCompany(user: userData));
//         } else {
//           _controller.add(Authorised(user: userData));
//         }
//       }
//     }
//   }

//   Future refreshJWT() async {
//     _controller.add(AuthLoading());

//     QueryResult result = await _graphQLService.performQuery(refreshJWTString);
//     if (result.data!['refreshJWT']['jwt'] != null) {
//       await flutterSecureStorage.delete(key: 'jwt');
//       await flutterSecureStorage.write(
//           key: 'jwt', value: result.data!['refreshJWT']['jwt']);

//       UserData userData = UserData.convert(result.data!['refreshJWT']['user']);
//       dynamic user = await chatRepository.connectUser(userData);

//       if (user != null) {
//         if (userData.companyId == null) {
//           _controller.add(NoCompany(user: userData));
//         } else {
//           _controller.add(Authorised(user: userData));
//         }
//       } else {
//         _controller.add(UnAuthorised());
//       }

//       return user;
//     } else {
//       _controller.add(UnAuthorised());
//       return null;
//     }
//   }

//   void logOut() async {
//     await flutterSecureStorage.delete(key: 'jwt');
//     _controller.add(UnAuthorised());
//   }

//   void dispose() => _controller.close();
// }
