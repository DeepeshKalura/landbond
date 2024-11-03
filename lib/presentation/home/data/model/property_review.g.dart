// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'property_review.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PropertyReview _$PropertyReviewFromJson(Map<String, dynamic> json) =>
    PropertyReview(
      id: json['id'] as String,
      propertyId: json['propertyId'] as String,
      user: Users.fromJson(json['user'] as Map<String, dynamic>),
      rating: (json['rating'] as num).toDouble(),
      comment: json['comment'] as String,
      images:
          (json['images'] as List<dynamic>?)?.map((e) => e as String).toList(),
      isVerified: json['isVerified'] as bool? ?? false,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$PropertyReviewToJson(PropertyReview instance) =>
    <String, dynamic>{
      'id': instance.id,
      'propertyId': instance.propertyId,
      'user': instance.user,
      'rating': instance.rating,
      'comment': instance.comment,
      'images': instance.images,
      'isVerified': instance.isVerified,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };
