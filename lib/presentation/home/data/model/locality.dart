import 'package:json_annotation/json_annotation.dart';

import 'cordinates.dart';

part 'locality.g.dart';

@JsonSerializable()
class Locality {
  final String id;
  final String name; // 5
  final String cityId; // 1
  final Coordinates coordinates; // 2
  final double popularityScore; // 7
  final List<String> nearbyLandmarks; // 6
  final bool isActive; // 4
  final double rating; // 9
  final String propertyId;
  final DateTime createdAt; // 3
  final DateTime updatedAt; // 8

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
    required this.rating,
    required this.propertyId,
  });

  factory Locality.fromJson(Map<String, dynamic> json) =>
      _$LocalityFromJson(json);

  Map<String, dynamic> toJson() => _$LocalityToJson(this);
}
