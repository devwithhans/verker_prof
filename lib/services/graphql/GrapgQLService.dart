import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:gql/ast.dart';
import 'package:gql/language.dart';
import 'package:graphql/client.dart';
import 'package:verker_prof/services/variables.dart';
import 'package:normalize/utils.dart';

/// This is the service used to process our graphql quries to our own backend.
/// We do this with the graphql package.

// TODO: Extract the final url to an ignored .env file.



class GraphQLService {
  late GraphQLClient _client;
  GraphQLService() {
    final Link link = AuthLink(getToken: () async {
      String? token = await FlutterSecureStorage().read(key: "jwt");
      return "Bearer $token";
    }).concat(HttpLink('$serverUrl/graphql'));

    _client = GraphQLClient(link: link, cache: GraphQLCache(store: null));
  }

  Future<QueryResult> performQuery(String query,
      {Map<String, dynamic>? variables}) async {
    QueryOptions options =
        QueryOptions(document: gql(query), variables: variables ??= {});

    final result = await _client.query(options);
    return result;
  }

  Future<QueryResult> performMutation(String query,
      {Map<String, dynamic>? variables}) async {
    MutationOptions options =
        MutationOptions(document: gql(query), variables: variables ??= {});
    final result = await _client.mutate(options);

    return result;
  }
}

class GraphQLVerker {
  static getErrorCode(result) {
    return result.exception.linkException.parsedResponse.errors[0]
        .extensions['customCode'];
  }
}
