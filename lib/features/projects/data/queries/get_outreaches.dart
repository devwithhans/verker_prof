String getOutreaches = """
  query getOutreaches(\$companyId: ID!){
  getOutreaches(companyId: \$companyId){
    _id
    projectId
    projectTitle
    initialMessage
    consumerId
    company {
      name 
    }
    messages {
      message
      senderId
      createdAt
    }

    members {
      userId
      role
      firstName
      profileImage
      totalUnread
    }
    totalMessages
    createdAt
  }
}

""";
