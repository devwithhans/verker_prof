String createUserQuery = """
  mutation CreateUser(\$profileImage: String! \$_id: String! \$firstName: String!, \$lastName: String!, \$phone: String!, \$email: String!){
  createUser(userInput:{
    _id: \$_id
    profileImage: \$profileImage
    firstName: \$firstName
    lastName: \$lastName
    phone: \$phone
    email: \$email
    platform: "prof"
  }){
    _id
  }
}
""";
