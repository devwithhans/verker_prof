String createProject = """ 
mutation createProject(\$title: String!,\$address: String!,\$zip: String!,\$description: String!,\$coordinates: [Float!]!,\$projectImages: [String!]!,\$projectType: String!,){
  
  createProject(projectInput:{
    address: {
      address: \$address
      zip: \$zip
    }
    description: \$description
    deadline: "No deadline"
    location:{
      type: "Point"
      coordinates: \$coordinates
    }
    projectImages:\$projectImages
    projectType: \$projectType
    title: \$title
  }){}
}
""";
