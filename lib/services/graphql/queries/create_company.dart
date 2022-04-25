String createCompany = """
  mutation CreateCompany(\$name: String!, \$description: String!, \$phone: String!, \$email: String!, \$cvr: String!, \$type: String!, \$logo: String!, \$established: String!, \$address: String!, \$zip: String!, \$employees: Int!,  ){
  createCompany(companyInput:{
      type: \$type
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
  }){
    _id
  }
}
""";
