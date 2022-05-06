class ErrorMessage {
  final String frontendMessage;
  final String developerMessage;
  final String errorName;

  ErrorMessage(
      {required this.developerMessage,
      required this.frontendMessage,
      required this.errorName});

  static Map<String, ErrorMessage> errors = {
    'EMAIL_NOT_FOUND': ErrorMessage(
      developerMessage: 'Could not find the email in the database',
      frontendMessage: 'This email does not exist',
      errorName: 'EMAIL_NOT_FOUND',
    ),
    'PASSWORD_IS_INCORRECT': ErrorMessage(
      developerMessage: 'Password does not match ',
      frontendMessage: 'Password is incorrect',
      errorName: 'PASSWORD_IS_INCORRECT',
    ),
    'USER_ALREADY_EXISTS': ErrorMessage(
      developerMessage: '',
      frontendMessage: 'Email is already in use',
      errorName: 'USER_ALREADY_EXISTS',
    ),
    'NO_JWT': ErrorMessage(
      developerMessage: '',
      frontendMessage: '',
      errorName: 'NO_JWT',
    ),
    'NO_PROJECTS': ErrorMessage(
      developerMessage: '',
      frontendMessage: '',
      errorName: 'NO_PROJECTS',
    ),
    'NO_MESSAGES': ErrorMessage(
      developerMessage: '',
      frontendMessage: '',
      errorName: 'NO_MESSAGES',
    ),
    'UNKNOWN': ErrorMessage(
      developerMessage:
          'This error comes when we the backend isent awailable, or we dont know the error',
      frontendMessage: 'No idea why this error accured',
      errorName: 'UNKNOWN',
    ),
  };

  static ErrorMessage? getErrorMessage(response) {
    String errorName = 'UNKNOWN';
    try {
      errorName = response.exception.linkException.parsedResponse.errors[0]
          .extensions['errorName'] ??= 'UNKNOWN';
    } catch (e) {
      return ErrorMessage.errors[errorName];
    }

    return ErrorMessage.errors[errorName];
  }
}
