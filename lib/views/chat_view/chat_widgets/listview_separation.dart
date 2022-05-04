import 'package:flutter/material.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';
import 'package:verker_prof/views/chat_view/chat_view.dart';
import 'package:verker_prof/views/chat_view/chat_widgets/date_divider.dart';
import 'package:verker_prof/views/chat_view/chat_widgets/message_buble.dart';

class MessageListViewSeparated extends StatelessWidget {
  const MessageListViewSeparated({
    Key? key,
    required this.messages,
    required ScrollController scrollController,
    required this.widget,
  })  : _scrollController = scrollController,
        super(key: key);

  final ScrollController _scrollController;
  final ChannelPage widget;
  final List<Message> messages;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ListView.separated(
          addAutomaticKeepAlives: false,
          addRepaintBoundaries: false,
          controller: _scrollController,
          itemCount: messages.length,
          reverse: true,
          separatorBuilder: (BuildContext context, int index) {
            Message message = messages[index];
            Message nextMessage = messages[index + 1];

            if (!Jiffy(message.createdAt.toLocal()).isSame(
              nextMessage.createdAt.toLocal(),
              Units.HOUR,
            )) {
              final divider = Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: VerkerDateDivider(
                  dateTime: message.createdAt.toLocal(),
                ),
              );
              return divider;
            }
            final timeDiff = Jiffy(nextMessage.createdAt.toLocal()).diff(
              message.createdAt.toLocal(),
              Units.MINUTE,
            );

            final spacingRules = <SpacingType>[];

            final isNextUserSame = message.user!.id == nextMessage.user?.id;
            final isThread = message.replyCount! > 0;
            final isDeleted = message.isDeleted;
            final hasTimeDiff = timeDiff >= 1;

            if (hasTimeDiff) {
              spacingRules.add(SpacingType.timeDiff);
            }

            if (!isNextUserSame) {
              spacingRules.add(SpacingType.otherUser);
            }

            if (isThread) {
              spacingRules.add(SpacingType.thread);
            }

            if (isDeleted) {
              spacingRules.add(SpacingType.deleted);
            }

            if (spacingRules.isNotEmpty) {
              return const SizedBox(height: 8);
            }
            return const SizedBox(height: 2);
          },
          itemBuilder: (BuildContext context, int index) {
            final client = StreamChatCore.of(context).client;
            Message message = messages[index];

            return VerkerMessageBuble(
              item: message,
              recieved: message.user!.id == client.state.currentUser!.id,
            );
          },
        ),
      ],
    );
  }
}
