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
      reviewId: json['reviewId'] as String?,
      year: (json['year'] as num).toInt(),
      producerId: json['producerId'] as String,
      cityId: json['cityId'] as String,
      localityId: json['localityId'] as String,
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
      address: json['address'] as String,
      images: (json['images'] as List<dynamic>)
          .map((e) => PropertyImage.fromJson(e as Map<String, dynamic>))
          .toList(),
      popularityScore: (json['popularityScore'] as num?)?.toDouble() ?? 0.0,
      verificationStatus: $enumDecodeNullable(
              _$VerificationStatusEnumMap, json['verificationStatus']) ??
          VerificationStatus.pending,
      isActive: json['isActive'] as bool? ?? true,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      verifiedAt: json['verifiedAt'] == null
          ? null
          : DateTime.parse(json['verifiedAt'] as String),
      rating: (json['rating'] as num).toDouble(),
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
      'year': instance.year,
      'producerId': instance.producerId,
      'cityId': instance.cityId,
      'localityId': instance.localityId,
      'nearbyPlaces': instance.nearbyPlaces,
      'reviewId': instance.reviewId,
      'rating': instance.rating,
      'address': instance.address,
      'facilities': instance.facilities,
      'features': instance.features,
      'description': instance.description,
      'websiteUrl': instance.websiteUrl,
      'images': instance.images,
      'popularityScore': instance.popularityScore,
      'verificationStatus':
          _$VerificationStatusEnumMap[instance.verificationStatus]!,
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
  DealType.plot: 'plot',
};

const _$VerificationStatusEnumMap = {
  VerificationStatus.pending: 'pending',
  VerificationStatus.verified: 'verified',
  VerificationStatus.rejected: 'rejected',
};
