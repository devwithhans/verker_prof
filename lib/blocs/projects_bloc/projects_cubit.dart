import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:graphql/client.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';
import 'package:verker_prof/blocs/projects_bloc/projects_event.dart';
import 'package:verker_prof/models/outreach.dart';
import 'package:verker_prof/services/graphql/GrapgQLService.dart';
import 'package:verker_prof/services/graphql/queries/project.dart';

part 'projects_state.dart';

class ProjectsBloc extends Bloc<ProjectsEvent, ProjectsState> {
  ProjectsBloc(this.streamChatClient) : super(ProjectsState()) {
    on<FetchMyProjects>(_getMyProjects);
  }

  StreamChatClient streamChatClient;

  Future<void> _getMyProjects(FetchMyProjects event, Emitter emit) async {
    emit(state.copyWith(status: ProjectsStatus.loading));

    List<Channel> channels = await streamChatClient.queryChannels().last;
    List<Outreach> projects = [];

    QueryResult result = await GraphQLService().performQuery(
      getMyProject,
    );

    if (!result.hasException) {
      if (result.data != null) {
        List rawList = result.data!['verkerGetProjects'];

        for (var i in rawList) {
          try {
            Channel channel = channels
                .where((element) => element.id == i['outreach']['_id'])
                .first;
            projects.add(Outreach.convert(i, channel));
          } catch (e) {
            return emit(state.copyWith(status: ProjectsStatus.failed));
          }
        }
      }
      return emit(
          state.copyWith(status: ProjectsStatus.succes, projects: projects));
    }
  }
}
