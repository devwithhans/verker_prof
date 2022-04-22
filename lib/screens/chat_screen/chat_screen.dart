import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';
import 'package:verker_prof/blocs/auth_bloc/auth_bloc.dart';
import 'package:verker_prof/models/outreach.dart';
import 'package:verker_prof/screens/chat_screen/sections/date_divider.dart';
import 'package:verker_prof/screens/chat_screen/sections/message_buble.dart';
import 'package:verker_prof/screens/chat_screen/sections/send_form.dart';
import 'package:verker_prof/screens/project_details_screen/project_details_screen.dart';
import 'package:verker_prof/services/variables.dart';

class ChannelPage extends StatefulWidget {
  final Outreach outreach;

  const ChannelPage({
    required this.outreach,
    Key? key,
  }) : super(key: key);

  @override
  _ChannelPageState createState() => _ChannelPageState();
}

class _ChannelPageState extends State<ChannelPage> {
  late final TextEditingController _controller;
  late final ScrollController _scrollController;
  final messageListController = MessageListController();

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _updateList() {
    _scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    final channel = StreamChannel.of(context).channel;

    final user = BlocProvider.of<AuthBloc>(context).state.user;
    final consumer = channel.state!.members.firstWhere(
      (element) => element.userId != user.id,
    );
    channel.markRead();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 2,
        titleSpacing: 5,
        title: InkWell(
          onTap: (() {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ProjectDetails(
                          project: widget.outreach.project,
                          outreach: true,
                        )));
          }),
          child: Row(
            children: [
              CircleAvatar(
                  foregroundImage: NetworkImage(
                      imageUrl + widget.outreach.project.images.first)),
              SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      consumer.user!.name,
                      overflow: TextOverflow.clip,
                      style: TextStyle(color: Colors.black),
                    ),
                    Text(
                      widget.outreach.project.title!,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(color: Colors.black, fontSize: 14),
                    )
                  ],
                ),
              ),
              SizedBox(width: 15),
            ],
          ),
        ),
      ),
      body: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus!.unfocus();
        },
        child: SafeArea(
          bottom: false,
          child: Column(
            children: [
              Expanded(
                child: LazyLoadScrollView(
                  onEndOfPage: () async {
                    messageListController.paginateData!();
                  },
                  child: MessageListCore(
                    messageListController: messageListController,
                    emptyBuilder: (BuildContext context) => const Center(
                      child: Text('Nothing here yet'),
                    ),
                    loadingBuilder: (BuildContext context) => const Center(
                      child: SizedBox(
                        height: 100,
                        width: 100,
                        child: CircularProgressIndicator(),
                      ),
                    ),
                    messageListBuilder: (
                      BuildContext context,
                      List<Message> messages,
                    ) {
                      return MessageListViewSeparated(
                          messages: messages,
                          scrollController: _scrollController,
                          widget: widget);
                    },
                    errorBuilder: (BuildContext context, error) {
                      print(error.toString());
                      return const Center(
                        child: SizedBox(
                          height: 100,
                          width: 100,
                          child:
                              Text('Oh no, an error occured. Please see logs.'),
                        ),
                      );
                    },
                  ),
                ),
              ),
              SendForm(
                controller: _controller,
                onSend: () async {
                  if (_controller.value.text.isNotEmpty) {
                    await channel.sendMessage(
                      Message(text: _controller.value.text),
                    );
                    if (mounted) {
                      _controller.clear();
                      _updateList();
                    }
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

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
