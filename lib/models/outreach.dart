import 'package:stream_chat_flutter/stream_chat_flutter.dart';
import 'package:verker_prof/models/project.dart';

class Outreach {
  String id;
  String status;
  ProjectModel project;
  String createdAt;
  Channel channel;

  Outreach({
    required this.status,
    required this.id,
    required this.createdAt,
    required this.project,
    required this.channel,
  });

  static convert(response, Channel channel) {
    return Outreach(
        channel: channel,
        id: response['outreach']['_id'] ??= null,
        createdAt: response['outreach']['createdAt'] ??= null,
        status: response['outreach']['status'] ??= null,
        project: ProjectModel.convert(response['project']));
  }
}
