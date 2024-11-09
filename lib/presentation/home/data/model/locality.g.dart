// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'locality.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Locality _$LocalityFromJson(Map<String, dynamic> json) => Locality(
      id: json['id'] as String,
      name: json['name'] as String,
      cityId: json['cityId'] as String,
      coordinates:
          Coordinates.fromJson(json['coordinates'] as Map<String, dynamic>),
      popularityScore: (json['popularityScore'] as num?)?.toDouble() ?? 0.0,
      nearbyLandmarks: (json['nearbyLandmarks'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      isActive: json['isActive'] as bool? ?? true,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      rating: (json['rating'] as num).toDouble(),
      propertyId: json['propertyId'] as String,
    );

Map<String, dynamic> _$LocalityToJson(Locality instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'cityId': instance.cityId,
      'coordinates': instance.coordinates,
      'popularityScore': instance.popularityScore,
      'nearbyLandmarks': instance.nearbyLandmarks,
      'isActive': instance.isActive,
      'rating': instance.rating,
      'propertyId': instance.propertyId,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };
