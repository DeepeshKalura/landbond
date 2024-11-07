import 'package:json_annotation/json_annotation.dart';

import 'cities.dart';

import 'types.dart';

import 'cordinates.dart';
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
  final Cities city;
  final String localityId;
  final Coordinates coordinates;
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
    this.reviewId,
    required this.year,
    required this.producerId,
    required this.city,
    required this.localityId,
    required this.coordinates,
    required this.nearbyPlaces,
    required this.facilities,
    required this.features,
    required this.description,
    this.websiteUrl,
    required this.address,
    required this.images,
    this.popularityScore = 0.0,
    this.verificationStatus = 'PENDING',
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
