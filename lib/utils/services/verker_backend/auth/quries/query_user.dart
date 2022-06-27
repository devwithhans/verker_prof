String getUserQuery = """
query {
  getUser(email:"s"){
    _id
    deviceTokens
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
