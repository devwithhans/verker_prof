const String signInUser = """
query SigninUser(\$email: String!, \$password: String!) { 
  signinUser(email: \$email, password: \$password, verker: true){
    
    jwt
    user {
      _id
      firstName
      lastName
      profileImage
      deviceToken
      address {
        address
        zip
      }
      email
      phone
      streamToken
      companyId
    }
    }
}
 """;

const String refreshJWTString = """
query  {
  refreshJWT{
    jwt
    user {
      _id
      firstName
      lastName
      profileImage
      deviceToken
      address {
        address
        zip
      }
      email
      phone
      streamToken
      companyId
    }
  }
}
 """;

String getUser = """
query {
  getUser(email:"s"){
    _id
    firstName
    companyId
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
