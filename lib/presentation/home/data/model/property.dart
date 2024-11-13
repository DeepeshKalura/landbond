import 'package:json_annotation/json_annotation.dart';

import 'types.dart';

import 'nearby_place.dart';
import 'property_image.dart';

part 'property.g.dart';

@JsonSerializable()
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
  final int year;
  final String producerId;
  final String cityId;
  final String localityId;
  final List<NearbyPlace> nearbyPlaces;
  final String? reviewId;
  final double rating;
  final String address;
  final List<String> facilities;
  final List<String> features;
  final String description;
  final String? websiteUrl;
  final List<PropertyImage> images;
  final double popularityScore;
  final VerificationStatus verificationStatus;
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
    this.reviewId,
    required this.year,
    required this.producerId,
    required this.cityId,
    required this.localityId,
    required this.nearbyPlaces,
    required this.facilities,
    required this.features,
    required this.description,
    this.websiteUrl,
    required this.address,
    required this.images,
    this.popularityScore = 0.0,
    this.verificationStatus = VerificationStatus.pending,
    this.isActive = true,
    required this.createdAt,
    required this.updatedAt,
    this.verifiedAt,
    required this.rating,
  });

  factory Property.fromJson(Map<String, dynamic> json) =>
      _$PropertyFromJson(json);

  Map<String, dynamic> toJson() => _$PropertyToJson(this);
}
