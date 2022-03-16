String getProjects = """ 
query browseProjects(\$maxDistance: Int!, \$coordinates: [Float!], \$type: String!, \$skip: Int!, \$limit: Int!){
  browseProjects(maxDistance: \$maxDistance, coordinates:\$coordinates, type: \$type, skip: \$skip, limit: \$limit){
    _id
    title
    deadline
    description
    projectImages
    projectType
    distance
    address {
      address
      zip
    }
    location {
      coordinates
    }
    _id
  }
}
""";

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
