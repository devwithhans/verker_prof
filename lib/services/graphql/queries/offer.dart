String getOffer = """
  query GetOffer(\$offerId: ID!){

  getOffer(offerId: \$offerId){
            _id
        status
        projectId
        outreachId
        verkerId
        consumerId
        consumerName
        consumerAddress {
          address
          zip
        }
        companyId
        companyName
        cvr
        companyAddress {
          address
          zip
        }
        companyEmail
        description
        materials {name, price, quantity}
        hours
        hourlyRate
        startDate
        offerExpires

}
}
""";
