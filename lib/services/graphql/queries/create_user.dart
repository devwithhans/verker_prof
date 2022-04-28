String createUser = """
  mutation CreateUser(\$firstName: String!, \$lastName: String!, \$phone: String!, \$email: String!, \$password: String!){
  createUser(userInput:{
    firstName: \$firstName
    lastName: \$lastName
    phone: \$phone
    email: \$email
    password: \$password
    platform: "prof"
  }){
    _id
  }
}
""";
