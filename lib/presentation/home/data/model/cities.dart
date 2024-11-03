import 'package:json_annotation/json_annotation.dart';

import 'cordinates.dart';

part 'cities.g.dart';

@JsonSerializable()
class Cities {
  final String id;
  final String name;
  final String imageUrl;
  final Coordinates coordinates;
  final String state;
  final bool isActive;
  final DateTime createdAt;
  final DateTime updatedAt;

  Cities({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.coordinates,
    required this.state,
    this.isActive = true,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Cities.fromJson(Map<String, dynamic> json) => _$CitiesFromJson(json);

  Map<String, dynamic> toJson() => _$CitiesToJson(this);
}
