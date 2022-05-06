import 'package:stream_chat_flutter/stream_chat_flutter.dart';
import 'package:verker_prof/models/user.dart';

/// This repository gives connects gets the right user from the getstream API

class ChatRepository {
  final StreamChatClient _client;

  ChatRepository(this._client);

  Future<dynamic> connectUser(UserData user) async {
    if (user.streamToken == null) {
      return Exception();
    }

    await _client.disconnectUser();

    await _client.connectUser(
        User(
            id: user.id,
            name: user.firstName,
            image: user.profileImage,
            extraData: {'image': user.profileImage}),
        user.streamToken ??= '');
    return user;
  }
}
