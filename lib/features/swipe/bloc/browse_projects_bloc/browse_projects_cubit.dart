

// import 'package:bloc/bloc.dart';
// import 'package:graphql/client.dart';
// import 'package:verker_prof/features/projects/models/project.dart';
// import 'package:verker_prof/utils/services/graphql_service.dart';

// class BrowseProjectCubit extends Cubit<BrowseProjectState> {
//   BrowseProjectCubit() : super(BrowsingInitial());

//   GraphQLService graphQLService = GraphQLService();

//   void browseProjects({
//     required List<double> position,
//     required String type,
//     required int maxDistance,
//   }) async {
//     emit(BrowsingLoading());
//     List<ProjectModel> projects = [];

//     QueryResult result = await graphQLService.performQuery(
//       getOutreaches,
//     );

//     if (!result.hasException) {
//       if (result.data != null) {
//         for (var i in result.data!['browseProjects']) {
//           projects.add(ProjectModel.convert(i));
//         }

//         emit(BrowsingSucces(projects));
//       }
//     }
//   }
// }
