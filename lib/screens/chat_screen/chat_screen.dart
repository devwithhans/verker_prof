import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';
import 'package:verker_prof/blocs/auth_bloc/auth_bloc.dart';
import 'package:verker_prof/blocs/offer_bloc/offer_bloc.dart';
import 'package:verker_prof/models/outreach.dart';
import 'package:verker_prof/screens/make_offer_screen/make_offer.dart';
import 'package:verker_prof/screens/project_details_screen/project_details_screen.dart';
import 'package:verker_prof/services/variables.dart';
import 'package:verker_prof/theme/constants/textstyle.dart';

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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 2,
        actions: [],
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
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    consumer.user!.name,
                    style: TextStyle(color: Colors.black),
                  ),
                  Text(
                    widget.outreach.project.title!,
                    style: TextStyle(color: Colors.black, fontSize: 14),
                  )
                ],
              ),
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
                    ) =>
                        Stack(
                      children: [
                        ListView.separated(
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
                                padding:
                                    const EdgeInsets.symmetric(vertical: 12),
                                child: VerkerDateDivider(
                                  dateTime: message.createdAt.toLocal(),
                                ),
                              );
                              return divider;
                            }
                            final timeDiff =
                                Jiffy(nextMessage.createdAt.toLocal()).diff(
                              message.createdAt.toLocal(),
                              Units.MINUTE,
                            );

                            final spacingRules = <SpacingType>[];

                            final isNextUserSame =
                                message.user!.id == nextMessage.user?.id;
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

                            print(message.type);

                            return VerkerMessageBuble(
                              item: message,
                              recieved: message.user!.id ==
                                  client.state.currentUser!.id,
                            );
                          },
                        ),
                        SizedBox(
                          height: 40,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                BlocProvider<OfferBloc>(
                                                  create: (context) =>
                                                      OfferBloc(),
                                                  child: OfferFormWrap(),
                                                )));
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 5),
                                    color: Colors.black.withOpacity(0.5),
                                    child: const Center(
                                      child: Text(
                                        'Lav tilbud til kunden',
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.white,
                                            decoration:
                                                TextDecoration.underline),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
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

class VerkerMessageBuble extends StatelessWidget {
  final bool recieved;

  const VerkerMessageBuble({
    required this.recieved,
    Key? key,
    required this.item,
  }) : super(key: key);

  final Message item;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: recieved
          ? EdgeInsets.fromLTRB(30, 2, 10, 2)
          : EdgeInsets.fromLTRB(10, 2, 30, 2),
      child: Column(
        crossAxisAlignment:
            recieved ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Material(
            borderRadius:
                recieved ? kMessageSideRadiusRight : kMessageSideRadiusLeft,
            color: recieved ? Colors.lightBlueAccent : Colors.grey[200],
            child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Column(
                  children: [
                    Text(item.text!,
                        style: TextStyle(
                            color: recieved ? Colors.white : Colors.black,
                            fontSize: 15)),
                  ],
                )),
          ),
        ],
      ),
    );
  }
}

class SendForm extends StatelessWidget {
  final TextEditingController controller;
  final void Function() onSend;

  const SendForm({required this.controller, required this.onSend, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.fromLTRB(20, 15, 20, 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 5,
            child: TextFormField(
              textCapitalization: TextCapitalization.sentences,
              controller: controller,
              maxLines: null,
              keyboardType: TextInputType.multiline,
              obscureText: false,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.fromLTRB(20, 10, 10, 10),
                filled: true,
                fillColor: Color(0xffF1F5F9),
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(100),
                ),
                hintText: 'Svar Verker',
              ),
            ),
          ),
          Expanded(
            child: IconButton(icon: Icon(Icons.send), onPressed: onSend),
          )
        ],
      ),
    );
  }
}

String getTranslatedDatetime(DateTime dateTime) {
  final createdAt = Jiffy(dateTime);
  final now = Jiffy(DateTime.now());

  var dayInfo = createdAt.MMMd;
  if (createdAt.isSame(now, Units.DAY)) {
    dayInfo = createdAt.Hm;
  } else if (createdAt.isSame(now.subtract(days: 1), Units.DAY)) {
    dayInfo = 'I går ${createdAt.Hm}';
  } else if (createdAt.isAfter(now.subtract(days: 7), Units.DAY)) {
    dayInfo = '${createdAt.MMMd} ${createdAt.Hm}';
  }
  return dayInfo;
}

class VerkerDateDivider extends StatelessWidget {
  /// Constructor for creating a [DateDivider]
  const VerkerDateDivider({
    Key? key,
    required this.dateTime,
    this.uppercase = false,
  }) : super(key: key);

  /// [DateTime] to display
  final DateTime dateTime;

  /// If text is uppercase
  final bool uppercase;

  @override
  Widget build(BuildContext context) {
    final createdAt = Jiffy(dateTime);
    final now = Jiffy(DateTime.now());

    var dayInfo = createdAt.MMMd;
    if (createdAt.isSame(now, Units.DAY)) {
      dayInfo = createdAt.Hm;
    } else if (createdAt.isSame(now.subtract(days: 1), Units.DAY)) {
      dayInfo = 'I går ${createdAt.Hm}';
    } else if (createdAt.isAfter(now.subtract(days: 7), Units.DAY)) {
      dayInfo = createdAt.EEEE;
    } else if (createdAt.isAfter(now.subtract(years: 1), Units.DAY)) {
      dayInfo = createdAt.MMMd;
    }

    if (uppercase) dayInfo = dayInfo.toUpperCase();

    final chatThemeData = StreamChatTheme.of(context);
    return Center(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 1),
        decoration: BoxDecoration(
          color: chatThemeData.colorTheme.overlayDark,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          dayInfo,
          style: chatThemeData.textTheme.footnote.copyWith(
            color: chatThemeData.colorTheme.barsBg,
          ),
        ),
      ),
    );
  }
}
