import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';
import 'package:verker_prof/blocs/auth_bloc/auth_bloc.dart';
import 'package:verker_prof/models/outreach.dart';
import 'package:verker_prof/services/variables.dart';
import 'package:verker_prof/theme/widgets/loading_indicator.dart';
import 'package:verker_prof/views/chat_view/chat_widgets/listview_separation.dart';
import 'package:verker_prof/views/chat_view/chat_widgets/send_form.dart';
import 'package:verker_prof/views/project_details_view/project_details_screen.dart';

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
                    builder: (context) => ProjectDetailsView(
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
                      child: Text('Der er endnu ingen beskeder'),
                    ),
                    loadingBuilder: (BuildContext context) => const Center(
                      child: SizedBox(
                        height: 100,
                        width: 100,
                        child: LoadingIndicator(),
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
                          child: Text('Der skete en fejl, prøv igen senere'),
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
