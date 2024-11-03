import 'package:json_annotation/json_annotation.dart';

import 'cordinates.dart';

part 'locality.g.dart';

@JsonSerializable()
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

  factory Locality.fromJson(Map<String, dynamic> json) =>
      _$LocalityFromJson(json);

  Map<String, dynamic> toJson() => _$LocalityToJson(this);
}
