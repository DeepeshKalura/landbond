enum PropertyType {
  apartment,
  commercial,
  investmentProperty,
  farmingLand,
  businessPlot,
  constructionLand,
  villa,
  residentialPlot
}

enum PropertyStatus { underConstruction, readyToMove, completed }

enum DealType { rent, sale, plot }

enum ProducerType { dealer, agent, owner }

enum UserRole { consumer, admin, producer }

enum PropertyInteractionType {
  view,
  contact,
  bookmark,
  share,
  enquiry,
  visit,
  imageView,
  mapView,
  priceView
}

enum VerificationStatus { pending, verified, rejected }
