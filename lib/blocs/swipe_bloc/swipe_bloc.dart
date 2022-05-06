import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:graphql/client.dart';
import 'package:verker_prof/models/filter.dart';

import 'package:verker_prof/models/project.dart';
import 'package:verker_prof/services/graphql/graphql_service.dart';
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
      List<double> position = [];
      try {
        position = await _determinePosition();
      } catch (e) {
        return emit(state.copyWith(
            errorText: e.toString(), status: ProjectStatus.failed));
      }
      emit(
        const SwipeState().copyWith(
          status: ProjectStatus.loading,
          maxDistance: event.projectSearchFilter!.maxDistance,
          type: event.projectSearchFilter!.type,
          position: position,
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

  Future<List<double>> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.

      return Future.error(
          'Du har ikke accepteret at dele lokation, og vi kan derfor ikke vise projekter i nærheden af dig.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    Position result = await Geolocator.getCurrentPosition();
    return [result.latitude, result.longitude];
  }
}
