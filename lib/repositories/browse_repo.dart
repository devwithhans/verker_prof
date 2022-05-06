import 'package:graphql/client.dart';
import 'package:verker_prof/models/project.dart';
import 'package:verker_prof/services/graphql/graphql_service.dart';
import 'package:verker_prof/services/graphql/queries/project.dart';

/// The browse repo makes it posible to browse projects with pagination. This repo is used with the swipe_screen

class BrowseRepo {
  static final BrowseRepo _browseRepo = BrowseRepo._();
  static const int _perPage = 10;
  GraphQLService graphQLService = GraphQLService();

  BrowseRepo._();

  factory BrowseRepo() {
    return _browseRepo;
  }

  Future<dynamic> queryProjects({
    required int page,
    required List<double> position,
    required String type,
    required int maxDistance,
  }) async {
    List<ProjectModel> projects = [];

    QueryResult result = await graphQLService.performQuery(
      getProjects,
      variables: {
        'maxDistance': maxDistance,
        'type': type,
        'coordinates': position,
        'skip': _perPage,
        'limit': page * _perPage,
      },
    );

    if (!result.hasException) {
      if (result.data != null) {
        for (var i in result.data!['browseProjects']) {
          projects.add(ProjectModel.convert(i));
        }
        return projects;
      }
    }
  }
}
