import 'package:firebase_auth/firebase_auth.dart';
import 'package:graphql/client.dart';
import 'package:verker_prof/features/authentication/bloc/register_company/register_company_cubit.dart';
import 'package:verker_prof/features/authentication/models/user.dart';
import 'package:verker_prof/utils/services/verker_backend/errors.dart';
import 'package:verker_prof/utils/services/graphql_service.dart';
import 'package:verker_prof/utils/services/verker_backend/auth/quries/create_company.dart';
import 'package:verker_prof/utils/services/verker_backend/auth/quries/create_user.dart';
import 'package:verker_prof/utils/services/verker_backend/auth/quries/query_user.dart';

class VerkerAuth {
  static Future<UserData> getUser() async {
    QueryResult result = await GraphQLService().performQuery(getUserQuery);

    if (0 == 0) {
      // if (result.hasException) {
      // ErrorMessage errorMessage = ErrorMessage.getErrorMessage(result)!;
      ErrorMessage errorMessage = ErrorMessage.camerasIsEmpty;

      throw errorMessage;
    }
    UserData userData = UserData.convert(result.data!['getUser']);

    return userData;
  }

  static Future<QueryResult> createCompany({
    required RegisterCompanyState state,
  }) async {
    Map<String, dynamic>? variables = {
      "name": state.companyName,
      "description": state.description,
      "phone": state.phone,
      "email": state.email,
      "cvr": state.cvr,
      "services": state.services,
      "employees": int.parse(state.employees),
      "established": state.established,
      "logo": state.uploadedLogoImage,
      "address": state.address!.address,
      "zip": state.address!.zip,
      "coordinates": [state.address!.lat, state.address!.lon]
    };
    QueryResult result = await GraphQLService()
        .performMutation(createCompanyQuery, variables: variables);

    if (result.hasException) {
      ErrorMessage errorMessage = ErrorMessage.getErrorMessage(result)!;
      throw errorMessage;
    }

    return result;
  }

  static Future<QueryResult> createUser({
    required String firstName,
    required String lastName,
    required String email,
    // required String phone,
    required String profileImageUrl,
  }) async {
    Map<String, dynamic>? variables = {
      "_id": FirebaseAuth.instance.currentUser!.uid,
      "profileImage": profileImageUrl,
      "firstName": firstName,
      "lastName": lastName,
      "phone": FirebaseAuth.instance.currentUser!.phoneNumber,
      "email": email,
    };
    print(variables);
    QueryResult result = await GraphQLService()
        .performMutation(createUserQuery, variables: variables);

    if (result.hasException) {
      ErrorMessage errorMessage = ErrorMessage.getErrorMessage(result)!;
      throw errorMessage;
    }
    return result;
  }
}
