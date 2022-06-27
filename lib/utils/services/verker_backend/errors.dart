class ErrorMessage {
  final String frontendMessage;
  final String developerMessage;
  final String errorName;

  ErrorMessage(
      {required this.developerMessage,
      required this.frontendMessage,
      required this.errorName});

  static ErrorMessage noStreamToken = ErrorMessage(
    developerMessage:
        'There was no streamtoken provided so we could not acces the streamchat',
    frontendMessage: 'Vi kunne ikke oprette forbindelse til serveren',
    errorName: 'NO_STREAM_TOKEN',
  );

  static ErrorMessage emailNotFound = ErrorMessage(
    developerMessage: 'Could not find the email in the database',
    frontendMessage: 'This email does not exist',
    errorName: 'EMAIL_NOT_FOUND',
  );

  static ErrorMessage failedToConnectChatClient = ErrorMessage(
    developerMessage: 'User was not found in getStream',
    frontendMessage: 'Noget gik galt',
    errorName: 'FAILED_TO_CONNCET_CHATCLIENT',
  );
  static ErrorMessage noCompanyFoud = ErrorMessage(
    developerMessage:
        'User is not connected with a company, and should therefore be navigated to create company screen',
    frontendMessage: 'Du har endnu ingen virksomhed tilknyttet',
    errorName: 'NO_COMPANY_FOUND',
  );
  static ErrorMessage passwordIsIncorrect = ErrorMessage(
    developerMessage: 'Password does not match ',
    frontendMessage: 'Password er forkert',
    errorName: 'PASSWORD_IS_INCORRECT',
  );
  static ErrorMessage userAlreadyExists = ErrorMessage(
    developerMessage: '',
    frontendMessage: 'Email is already in use',
    errorName: 'USER_ALREADY_EXISTS',
  );
  static ErrorMessage userDoesNotExists = ErrorMessage(
    developerMessage: '',
    frontendMessage: 'The user do not exist any more. You can make a new here',
    errorName: 'USER_DOES_NOT_EXIST',
  );
  static ErrorMessage noJWT = ErrorMessage(
    developerMessage: '',
    frontendMessage: '',
    errorName: 'NO_JWT',
  );
  static ErrorMessage noProjects = ErrorMessage(
    developerMessage: '',
    frontendMessage: '',
    errorName: 'NO_PROJECTS',
  );
  static ErrorMessage noMessages = ErrorMessage(
    developerMessage: '',
    frontendMessage: '',
    errorName: 'NO_MESSAGES',
  );
  static ErrorMessage unknown = ErrorMessage(
    developerMessage:
        'This error comes when we the backend isent awailable, or we dont know the error',
    frontendMessage: 'Vi kunne ikke oprette forbindelse til serveren',
    errorName: 'UNKNOWN',
  );

  // Add project errors
  static ErrorMessage noImagesUploaded = ErrorMessage(
    developerMessage:
        'No images was uploaded, when you trying to add the project. Therefore it does not continue',
    frontendMessage: 'En fejl opstod under upload af billederne',
    errorName: 'UNKNOWN',
  );
  static ErrorMessage camerasIsEmpty = ErrorMessage(
    developerMessage: 'There is no cameras available',
    frontendMessage:
        'Vi kunne ikke finde nogle kameraer, har du husket at give appen tilladelse',
    errorName: 'UNKNOWN',
  );
  static ErrorMessage failedToUseCamera = ErrorMessage(
    developerMessage:
        'This might be because the camera controller is null, check the camera cubit',
    frontendMessage: 'Der skete en fejl',
    errorName: 'UNKNOWN',
  );
  static ErrorMessage failedQueryChannels = ErrorMessage(
    developerMessage: 'Could not query channel from the streamchat API',
    frontendMessage: 'Der skete en fejl',
    errorName: 'UNKNOWN',
  );

  //Server Errors:
  static Map<String, ErrorMessage> errors = {
    'EMAIL_NOT_FOUND': emailNotFound,
    'PASSWORD_IS_INCORRECT': passwordIsIncorrect,
    'USER_ALREADY_EXISTS': userAlreadyExists,
    'USER_DOES_NOT_EXIST': userDoesNotExists,
    'NO_JWT': noJWT,
    'NO_PROJECTS': noProjects,
    'NO_MESSAGES': noMessages,
    'UNKNOWN': unknown,
  };

  static ErrorMessage? getErrorMessage(response) {
    String errorName = 'UNKNOWN';
    try {
      errorName = response.exception.linkException.parsedResponse.errors[0]
          .extensions['errorName'] ??= 'UNKNOWN';
    } catch (e) {
      print(response);
      return ErrorMessage.errors[errorName];
    }
    return ErrorMessage.errors[errorName] ?? ErrorMessage.errors['UNKNOWN'];
  }
}
