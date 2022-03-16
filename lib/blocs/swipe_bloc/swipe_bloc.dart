import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:graphql/client.dart';
import 'package:verker_prof/models/filter.dart';

import 'package:verker_prof/models/project.dart';
import 'package:verker_prof/services/graphql/GrapgQLService.dart';
import 'package:verker_prof/services/graphql/queries/project.dart';

part 'swipe_event.dart';
part 'swipe_state.dart';

class SwipeBloc extends Bloc<SwipeEvent, SwipeState> {
  GraphQLService graphQLService = GraphQLService();

  SwipeBloc() : super(const SwipeState()) {
    on<FetchProjects>(_fetchProjects);
    on<RemoveProject>(_removeProject);
  }

  Future<void> _removeProject(RemoveProject event, Emitter emit) async {
    List<ProjectModel> projects = [];
    projects.addAll(state.projects);

    projects.removeWhere((element) => element.id == event.id);

    emit(state.copyWith(projects: projects));
  }

  Future<void> _fetchProjects(FetchProjects event, Emitter emit) async {
    if (event.projectSearchFilter != null) {
      emit(
        const SwipeState().copyWith(
          status: ProjectStatus.loading,
          maxDistance: event.projectSearchFilter!.maxDistance,
          type: event.projectSearchFilter!.type,
          position: event.projectSearchFilter!.position,
        ),
      );
    } else {
      emit(state.copyWith(
        currentIndex: event.currentIndex,
        status: ProjectStatus.loading,
      ));
    }

    List<ProjectModel> projects = [];
    projects.addAll(state.projects);

    QueryResult result;
    try {
      print(state.maxDistance);
      result = await graphQLService.performQuery(
        getProjects,
        variables: {
          'maxDistance': state.maxDistance,
          'type': state.type,
          'coordinates': state.position,
          'skip': projects.length,
          'limit': 4,
        },
      );
    } catch (e) {
      return emit(state.copyWith(status: ProjectStatus.failed));
    }

    if (!result.hasException) {
      if (result.data != null) {
        List projectsResult = result.data!['browseProjects'];
        if (projectsResult.isEmpty) {
          return emit(state.copyWith(
              hasReachedMax: true, status: ProjectStatus.succes));
        }
        for (var i in projectsResult) {
          projects.add(ProjectModel.convert(i));
        }
        emit(state.copyWith(projects: projects, status: ProjectStatus.succes));
      }
    }
  }
}
