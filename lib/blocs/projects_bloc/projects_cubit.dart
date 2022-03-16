import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:graphql/client.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';
import 'package:verker_prof/models/outreach.dart';
import 'package:verker_prof/services/graphql/GrapgQLService.dart';
import 'package:verker_prof/services/graphql/queries/project.dart';

part 'projects_state.dart';

class ProjectsCubit extends Cubit<ProjectsState> {
  ProjectsCubit(this.streamChatClient) : super(ProjectsState());
  StreamChatClient streamChatClient;

  GraphQLService graphQLService = GraphQLService();

  void getMyProjects() async {
    print('lidt virker det dat ${state.projects}');
    emit(state.copyWith(status: ProjectsStatus.loading));

    List<Channel> channels = await streamChatClient.queryChannels().last;
    List<Outreach> projects = [];

    QueryResult result = await graphQLService.performQuery(
      getMyProject,
    );

    if (!result.hasException) {
      if (result.data != null) {
        for (var i in result.data!['verkerGetProjects']) {
          try {
            Channel channel = channels
                .where((element) => element.id == i['outreach']['_id'])
                .first;
            projects.add(Outreach.convert(i, channel));
          } catch (e) {
            print('BIG FAT ERROR');
            return emit(state.copyWith(status: ProjectsStatus.failed));
          }
        }
      }
      emit(state.copyWith(status: ProjectsStatus.succes, projects: projects));
    }
  }
}
