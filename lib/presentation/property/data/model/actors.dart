import 'package:json_annotation/json_annotation.dart';

import '../../../home/data/model/types.dart';

part 'actors.g.dart';

@JsonSerializable()
class Actors {
  final String id;
  final String email;
  final String name;
  final String phoneNumber;
  final String isVerified;
  final String profilePhotoUrl;
  final String timezone;
  final ProducerType type;
  final List<String> verificationDocuments;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? verifiedAt;

  Actors({
    required this.id,
    required this.email,
    required this.name,
    required this.phoneNumber,
    required this.isVerified,
    required this.profilePhotoUrl,
    required this.timezone,
    required this.type,
    required this.verificationDocuments,
    required this.createdAt,
    required this.updatedAt,
    this.verifiedAt,
  });

  factory Actors.fromJson(Map<String, dynamic> json) => _$ActorsFromJson(json);

  Map<String, dynamic> toJson() => _$ActorsToJson(this);
}
