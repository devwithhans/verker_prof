String getMyProject = """
  
query {
  verkerGetProjects{
    project{
            _id
    title
    deadline
    description
    projectImages
    projectType
    address {
      address
      zip
    }
    location {
      coordinates
    }
    }
    outreach {
      status
      createdAt
      _id
    }
     }
}

  
""";
