import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:graphql/client.dart';
import 'package:verker_prof/models/project.dart';
import 'package:verker_prof/services/graphql/GrapgQLService.dart';
import 'package:verker_prof/services/graphql/queries/getOutreaches.dart';

part 'browse_projects_state.dart';

class BrowseProjectCubit extends Cubit<BrowseProjectState> {
  BrowseProjectCubit() : super(BrowsingInitial());

  GraphQLService graphQLService = GraphQLService();

  void browseProjects({
    required List<double> position,
    required String type,
    required int maxDistance,
  }) async {
    emit(BrowsingLoading());
    List<ProjectModel> projects = [];

    QueryResult result = await graphQLService.performQuery(
      getOutreaches,
    );

    if (!result.hasException) {
      if (result.data != null) {
        for (var i in result.data!['browseProjects']) {
          projects.add(ProjectModel.convert(i));
        }
        print(projects.first.images);

        emit(BrowsingSucces(projects));
      }
    }
  }
}
