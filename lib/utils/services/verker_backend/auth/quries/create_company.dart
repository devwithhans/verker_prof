String createCompanyQuery = """
  mutation CreateCompany(
    \$name: String!  
    \$description: String! 
    \$phone: String!
    \$email: String! 
    \$cvr: String!
    \$services: [String!]! 
    \$logo: String!
    \$established: String!
    \$address: String!
    \$zip: String!
    \$employees: Int!
    \$coordinates: [Float!]!
  ){
  createCompany(companyInput:{
      services: \$services
        name: \$name
        description: \$description
        cvr: \$cvr
        email: \$email
        phone: \$phone
        employees: \$employees
        logo: \$logo
        established: \$established
        address: {
          address: \$address
          zip: \$zip
        }
        location:{
          type: "Point"
          coordinates: \$coordinates
        }
  }){
    _id
  }
}
""";
