import 'dart:math';

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

enum DealType { rent, sale }

enum ProducerType { dealer, agent, owner }

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

// Models
class Coordinates {
  final double latitude;
  final double longitude;

  Coordinates({
    required this.latitude,
    required this.longitude,
  });

  Map<String, dynamic> toJson() => {
        'latitude': latitude,
        'longitude': longitude,
      };

  factory Coordinates.fromJson(Map<String, dynamic> json) => Coordinates(
        latitude: json['latitude'],
        longitude: json['longitude'],
      );
}

class City {
  final String id;
  final String name;
  final String imageUrl;
  final Coordinates coordinates;
  final String state;
  final bool isActive;
  final DateTime createdAt;
  final DateTime updatedAt;

  City({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.coordinates,
    required this.state,
    this.isActive = true,
    required this.createdAt,
    required this.updatedAt,
  });
}

class Locality {
  final String id;
  final String name;
  final String cityId;
  final Coordinates coordinates;
  final double popularityScore;
  final List<String> nearbyLandmarks;
  final bool isActive;
  final DateTime createdAt;
  final DateTime updatedAt;

  Locality({
    required this.id,
    required this.name,
    required this.cityId,
    required this.coordinates,
    this.popularityScore = 0.0,
    required this.nearbyLandmarks,
    this.isActive = true,
    required this.createdAt,
    required this.updatedAt,
  });
}

class Producer {
  final String id;
  final String name;
  final ProducerType type;
  final String phoneNumber;
  final String email;
  final String timezone;
  final bool isVerified;
  final List<String> verificationDocuments;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? verifiedAt;

  Producer({
    required this.id,
    required this.name,
    required this.type,
    required this.phoneNumber,
    required this.email,
    required this.timezone,
    this.isVerified = false,
    required this.verificationDocuments,
    required this.createdAt,
    required this.updatedAt,
    this.verifiedAt,
  });
}

class PropertyImage {
  final String url;
  final bool isPrimary;
  final String? caption;

  PropertyImage({
    required this.url,
    this.isPrimary = false,
    this.caption,
  });
}

class NearbyPlace {
  final String name;
  final double distance;
  final String type;

  NearbyPlace({
    required this.name,
    required this.distance,
    required this.type,
  });
}

class Property {
  final String id;
  final String name;
  final PropertyType propertyType;
  final PropertyStatus status;
  final DealType dealType;
  final bool hasEMIOption;
  final double price;
  final String currency;
  final String? rentPeriodicity;
  final double size;
  final String sizeUnit;
  final int age;
  final String producerId;
  final String cityId;
  final String localityId;
  final Coordinates coordinates;
  final List<NearbyPlace> nearbyPlaces;
  final List<String> facilities;
  final List<String> features;
  final String description;
  final String? websiteUrl;
  final List<PropertyImage> images;
  final double popularityScore;
  final String verificationStatus;
  final bool isActive;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? verifiedAt;

  Property({
    required this.id,
    required this.name,
    required this.propertyType,
    required this.status,
    required this.dealType,
    this.hasEMIOption = false,
    required this.price,
    required this.currency,
    this.rentPeriodicity,
    required this.size,
    required this.sizeUnit,
    required this.age,
    required this.producerId,
    required this.cityId,
    required this.localityId,
    required this.coordinates,
    required this.nearbyPlaces,
    required this.facilities,
    required this.features,
    required this.description,
    this.websiteUrl,
    required this.images,
    this.popularityScore = 0.0,
    this.verificationStatus = 'PENDING',
    this.isActive = true,
    required this.createdAt,
    required this.updatedAt,
    this.verifiedAt,
  });
}

class PropertyReview {
  final String id;
  final String propertyId;
  final String userId;
  final double rating;
  final String comment;
  final List<String>? images;
  final bool isVerified;
  final DateTime createdAt;
  final DateTime updatedAt;

  PropertyReview({
    required this.id,
    required this.propertyId,
    required this.userId,
    required this.rating,
    required this.comment,
    this.images,
    this.isVerified = false,
    required this.createdAt,
    required this.updatedAt,
  });
}

class PropertyInteraction {
  final String id;
  final String propertyId;
  final String userId;
  final PropertyInteractionType interactionType;
  final DateTime timestamp;
  final String sessionId;
  final DeviceInfo deviceInfo;

  PropertyInteraction({
    required this.id,
    required this.propertyId,
    required this.userId,
    required this.interactionType,
    required this.timestamp,
    required this.sessionId,
    required this.deviceInfo,
  });
}

class DeviceInfo {
  final String deviceType;
  final String browser;
  final String platform;

  DeviceInfo({
    required this.deviceType,
    required this.browser,
    required this.platform,
  });
}

class PropertyPopularityMetrics {
  final String id;
  final String propertyId;

  // Basic Metrics
  final int totalViews;
  final int uniqueViews;
  final int bookmarks;
  final int shares;
  final int enquiries;
  final int scheduledVisits;

  // Time-based Metrics
  final int last24HourViews;
  final int last7DayViews;
  final int last30DayViews;

  // Engagement Metrics
  final double averageTimeSpent;
  final double imageViewRate;
  final double contactClickRate;
  final double returnVisitRate;

  // Review Metrics
  final int totalReviews;
  final double averageRating;

  // Combined Score
  final double popularityScore;

  // Timestamps
  final DateTime lastCalculated;
  final DateTime createdAt;
  final DateTime updatedAt;

  PropertyPopularityMetrics({
    required this.id,
    required this.propertyId,
    this.totalViews = 0,
    this.uniqueViews = 0,
    this.bookmarks = 0,
    this.shares = 0,
    this.enquiries = 0,
    this.scheduledVisits = 0,
    this.last24HourViews = 0,
    this.last7DayViews = 0,
    this.last30DayViews = 0,
    this.averageTimeSpent = 0.0,
    this.imageViewRate = 0.0,
    this.contactClickRate = 0.0,
    this.returnVisitRate = 0.0,
    this.totalReviews = 0,
    this.averageRating = 0.0,
    this.popularityScore = 0.0,
    required this.lastCalculated,
    required this.createdAt,
    required this.updatedAt,
  });

  static double calculatePopularityScore({
    required int uniqueViews,
    required int totalViews,
    required int enquiries,
    required int bookmarks,
    required int shares,
    required int scheduledVisits,
    required double averageTimeSpent,
    required double imageViewRate,
    required double contactClickRate,
    required double returnVisitRate,
    required int totalReviews,
    required double averageRating,
    required int last7DayViews,
    required int last30DayViews,
  }) {
    const double viewWeight = 0.15;
    const double engagementWeight = 0.20;
    const double reviewWeight = 0.20;
    const double recencyWeight = 0.10;

    double viewScore = (uniqueViews / 1000) * viewWeight;
    double engagementScore = ((bookmarks * 0.2) +
            (shares * 0.2) +
            (enquiries * 0.3) +
            (scheduledVisits * 0.3)) *
        engagementWeight;

    double reviewScore =
        ((totalReviews / 100) * 0.4 + (averageRating / 5) * 0.6) * reviewWeight;

    double recencyScore = ((last7DayViews / last30DayViews * 0.7) +
            (last7DayViews > 0 ? 0.3 : 0)) *
        recencyWeight;

    // Combine scores and cap at 100
    return min(viewScore + engagementScore + reviewScore + recencyScore, 100.0);
  }
}

class LocalityPopularityMetrics {
  final String id;
  final String localityId;

  // Property Metrics
  final int totalProperties;
  final int activeProperties;
  final double averagePropertyScore;

  // Search Metrics
  final int searchCount;
  final double searchClickThrough;

  // Transaction Metrics
  final int totalTransactions;
  final int last30DayTransactions;

  // Price Metrics
  final double averagePropertyPrice;
  final double priceAppreciation;

  // Combined Score
  final double popularityScore;

  // Timestamps
  final DateTime lastCalculated;
  final DateTime createdAt;
  final DateTime updatedAt;

  LocalityPopularityMetrics({
    required this.id,
    required this.localityId,
    this.totalProperties = 0,
    this.activeProperties = 0,
    this.averagePropertyScore = 0.0,
    this.searchCount = 0,
    this.searchClickThrough = 0.0,
    this.totalTransactions = 0,
    this.last30DayTransactions = 0,
    this.averagePropertyPrice = 0.0,
    this.priceAppreciation = 0.0,
    this.popularityScore = 0.0,
    required this.lastCalculated,
    required this.createdAt,
    required this.updatedAt,
  });
}
