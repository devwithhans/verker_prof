String createOutreach = """
  mutation CreateOutreach(\$projectId: ID!, \$initialMessage: String!){
  createOutreach(outreachInput:{
    projectId: \$projectId
    initialMessage: \$initialMessage
  }){
    
  }
}
""";
