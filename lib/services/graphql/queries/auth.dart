const String signInUser = """
query SigninUser(\$email: String!, \$password: String!) { 
  signinUser(email: \$email, password: \$password, verker: true){
    
    jwt
    user {
      verker
      _id
      firstName
      lastName
      profileImage
      deviceToken
      verker
      address {
        address
        zip
      }
      email
      phone
      streamToken
    }
    }
}
 """;

String getUser = """
query {
  getUser(email:"s"){

    verker
    _id
    firstName
    lastName
    address {
      address
      zip
    }
    email
    phone
    profileImage
    streamToken
  }
}
""";
