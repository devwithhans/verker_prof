import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';
import 'package:verker_prof/features/authentication/models/user.dart';
import 'package:verker_prof/utils/services/graphql_service.dart';
import 'package:verker_prof/utils/services/verker_backend/auth/quries/push_device_token.dart';
import 'package:verker_prof/utils/services/verker_backend/errors.dart';

/// This repository gives connects gets the right user from the getstream API

class ChatRepository {
  final StreamChatClient _client;
  final GraphQLService _verkerGraphQL = GraphQLService();

  ChatRepository(this._client);

  Future<UserData> connectUser(UserData userData) async {
    if (userData.streamToken == null) {
      throw ErrorMessage.noStreamToken;
    }

    FirebaseMessaging messaging = FirebaseMessaging.instance;
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      final fcmToken = await messaging.getToken();
      print(fcmToken);
      if (userData.deviceToken
          .where((element) => element == fcmToken)
          .isEmpty) {
        await _verkerGraphQL.performMutation(
          addDeviceToken,
          variables: {'deviceToken': fcmToken},
        );
        userData.deviceToken.add(fcmToken);
        _client.addDevice(
          fcmToken!,
          PushProvider.firebase,
        );
      }
    }

    await _client.disconnectUser();

    await _client.connectUser(
      User(
          id: userData.id,
          name: userData.firstName,
          image: userData.profileImage,
          extraData: {'image': userData.profileImage}),
      userData.streamToken ??= '',
    );

    return userData;
  }
}
