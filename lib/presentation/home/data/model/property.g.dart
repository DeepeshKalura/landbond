// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'property.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Property _$PropertyFromJson(Map<String, dynamic> json) => Property(
      id: json['id'] as String,
      name: json['name'] as String,
      propertyType: $enumDecode(_$PropertyTypeEnumMap, json['propertyType']),
      status: $enumDecode(_$PropertyStatusEnumMap, json['status']),
      dealType: $enumDecode(_$DealTypeEnumMap, json['dealType']),
      hasEMIOption: json['hasEMIOption'] as bool? ?? false,
      price: (json['price'] as num).toDouble(),
      currency: json['currency'] as String,
      rentPeriodicity: json['rentPeriodicity'] as String?,
      size: (json['size'] as num).toDouble(),
      sizeUnit: json['sizeUnit'] as String,
      review: PropertyReview.fromJson(json['review'] as Map<String, dynamic>),
      age: (json['age'] as num).toInt(),
      producer: Producer.fromJson(json['producer'] as Map<String, dynamic>),
      city: Cities.fromJson(json['city'] as Map<String, dynamic>),
      locality: Locality.fromJson(json['locality'] as Map<String, dynamic>),
      coordinates:
          Coordinates.fromJson(json['coordinates'] as Map<String, dynamic>),
      nearbyPlaces: (json['nearbyPlaces'] as List<dynamic>)
          .map((e) => NearbyPlace.fromJson(e as Map<String, dynamic>))
          .toList(),
      facilities: (json['facilities'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      features:
          (json['features'] as List<dynamic>).map((e) => e as String).toList(),
      description: json['description'] as String,
      websiteUrl: json['websiteUrl'] as String?,
      images: (json['images'] as List<dynamic>)
          .map((e) => PropertyImage.fromJson(e as Map<String, dynamic>))
          .toList(),
      popularityScore: (json['popularityScore'] as num?)?.toDouble() ?? 0.0,
      verificationStatus: json['verificationStatus'] as String? ?? 'PENDING',
      isActive: json['isActive'] as bool? ?? true,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      verifiedAt: json['verifiedAt'] == null
          ? null
          : DateTime.parse(json['verifiedAt'] as String),
    );

Map<String, dynamic> _$PropertyToJson(Property instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'propertyType': _$PropertyTypeEnumMap[instance.propertyType]!,
      'status': _$PropertyStatusEnumMap[instance.status]!,
      'dealType': _$DealTypeEnumMap[instance.dealType]!,
      'hasEMIOption': instance.hasEMIOption,
      'price': instance.price,
      'currency': instance.currency,
      'rentPeriodicity': instance.rentPeriodicity,
      'size': instance.size,
      'sizeUnit': instance.sizeUnit,
      'age': instance.age,
      'producer': instance.producer,
      'city': instance.city,
      'locality': instance.locality,
      'coordinates': instance.coordinates,
      'nearbyPlaces': instance.nearbyPlaces,
      'review': instance.review,
      'facilities': instance.facilities,
      'features': instance.features,
      'description': instance.description,
      'websiteUrl': instance.websiteUrl,
      'images': instance.images,
      'popularityScore': instance.popularityScore,
      'verificationStatus': instance.verificationStatus,
      'isActive': instance.isActive,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      'verifiedAt': instance.verifiedAt?.toIso8601String(),
    };

const _$PropertyTypeEnumMap = {
  PropertyType.apartment: 'apartment',
  PropertyType.commercial: 'commercial',
  PropertyType.investmentProperty: 'investmentProperty',
  PropertyType.farmingLand: 'farmingLand',
  PropertyType.businessPlot: 'businessPlot',
  PropertyType.constructionLand: 'constructionLand',
  PropertyType.villa: 'villa',
  PropertyType.residentialPlot: 'residentialPlot',
};

const _$PropertyStatusEnumMap = {
  PropertyStatus.underConstruction: 'underConstruction',
  PropertyStatus.readyToMove: 'readyToMove',
  PropertyStatus.completed: 'completed',
};

const _$DealTypeEnumMap = {
  DealType.rent: 'rent',
  DealType.sale: 'sale',
};
