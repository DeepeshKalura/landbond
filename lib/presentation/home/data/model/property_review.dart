import 'package:json_annotation/json_annotation.dart';

import '../../../auth/data/model/users.dart';

part 'property_review.g.dart';

@JsonSerializable()
class PropertyReview {
  final String id;
  final String propertyId;
  final Users user;
  final double rating;
  final String comment;
  final List<String>? images;
  final bool isVerified;
  final DateTime createdAt;
  final DateTime updatedAt;

  PropertyReview({
    required this.id,
    required this.propertyId,
    required this.user,
    required this.rating,
    required this.comment,
    this.images,
    this.isVerified = false,
    required this.createdAt,
    required this.updatedAt,
  });

  factory PropertyReview.fromJson(Map<String, dynamic> json) =>
      _$PropertyReviewFromJson(json);

  Map<String, dynamic> toJson() => _$PropertyReviewToJson(this);
}
