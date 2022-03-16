import 'package:stream_chat_flutter/stream_chat_flutter.dart';
import 'package:verker_prof/models/user.dart';

class ChatRepository {
  StreamChatClient _client;

  ChatRepository(this._client);

  @override
  Future<dynamic> connectUser(UserData user) async {
    if (user.streamToken == null) {
      return Exception();
    }

    String testToken =
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoidHV0b3JpYWwtZmx1dHRlciJ9.S-MJpoSwDiqyXpUURgO5wVqJ4vKlIVFLSEyrFYCOE1c';

    await _client.disconnectUser();

    // FOR TESTING PURPOSE ONLY!!!
    // await _client.connectUser(
    //     User(
    //       id: "delicate-bush-9",
    //       name: "delicate",
    //       image: "https://bit.ly/2u9Vc0r",
    //     ),
    //     "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoiZGVsaWNhdGUtYnVzaC05IiwiZXhwIjoxNjQyNDI3NzYzfQ.YPGO3ilVdTkYbjC_5oxNQLZlTv4JXNFuiFls2D0_4Ew");
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
