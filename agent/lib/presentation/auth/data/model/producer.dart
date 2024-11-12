import 'package:json_annotation/json_annotation.dart';

import '../../../home/data/model/types.dart';

part 'producer.g.dart';

@JsonSerializable()
class Producer {
  final String id;
  final String name;
  final String email;
  final String profilePhotoUrl;
  final bool isVerified;
  final UserRole role = UserRole.producer;
  final String timezone;
  final List<String> verificationDocuments;
  final DateTime createdAt;
  final DateTime updatedAt;

  Producer({
    required this.id,
    required this.name,
    required this.email,
    required this.profilePhotoUrl,
    this.isVerified = false,
    this.timezone = "Asia/Kolkata",
    required this.verificationDocuments,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Producer.fromJson(Map<String, dynamic> json) =>
      _$ProducerFromJson(json);

  Map<String, dynamic> toJson() => _$ProducerToJson(this);
}
