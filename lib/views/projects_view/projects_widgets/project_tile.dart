import 'package:flutter/material.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';
import 'package:verker_prof/models/outreach.dart';
import 'package:verker_prof/models/project.dart';
import 'package:verker_prof/services/variables.dart';
import 'package:verker_prof/theme/constants/textstyle.dart';
import 'package:verker_prof/theme/widgets/components.dart';
import 'package:verker_prof/views/chat_view/chat_view.dart';

class ProjectTile extends StatelessWidget {
  const ProjectTile({
    Key? key,
    required this.outreach,
  }) : super(key: key);

  final Outreach outreach;

  @override
  Widget build(BuildContext context) {
    ProjectModel project = outreach.project;
    Channel channel = outreach.channel;

    double width = MediaQuery.of(context).size.width;
    int unreadCount = 0;

    return StreamBuilder<int?>(
        stream: channel.state!.unreadCountStream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            unreadCount = snapshot.data as int;
          }
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => StreamChannel(
                    channel: channel,
                    child: ChannelPage(
                      outreach: outreach,
                    ),
                  ),
                ),
              );
            },
            child: Container(
              margin: const EdgeInsets.only(bottom: 15),
              color: Colors.transparent,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: width * 0.2,
                    width: width * 0.2,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                        image:
                            NetworkImage(imageUrl + (project.images[0] ??= '')),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(10, 2, 10, 4),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: Text(
                                  project.title!,
                                  overflow: TextOverflow.ellipsis,
                                  style: kMediumBold,
                                ),
                              ),
                              StatusBox(
                                outreachStatus: outreach.status,
                              )
                            ],
                          ),
                          Text(
                            'Du har ${unreadCount == 0 ? 'ingen' : unreadCount} ${unreadCount == 1 ? 'ny besked' : 'nye beskeder'}',
                            style: TextStyle(
                                fontWeight:
                                    unreadCount > 0 ? FontWeight.bold : null),
                          ),
                          Text(
                            project.address!['zip'],
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }
}
