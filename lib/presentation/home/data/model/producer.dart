import 'package:json_annotation/json_annotation.dart';
import 'types.dart';

part 'producer.g.dart';

@JsonSerializable()
class Producer {
  final String id;
  final String name;
  final ProducerType type;
  final String phoneNumber;
  final String email;
  final String timezone;
  final bool isVerified;
  final List<String> verificationDocuments;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? verifiedAt;

  Producer({
    required this.id,
    required this.name,
    required this.type,
    required this.phoneNumber,
    required this.email,
    required this.timezone,
    this.isVerified = false,
    required this.verificationDocuments,
    required this.createdAt,
    required this.updatedAt,
    this.verifiedAt,
  });

  factory Producer.fromJson(Map<String, dynamic> json) =>
      _$ProducerFromJson(json);

  Map<String, dynamic> toJson() => _$ProducerToJson(this);
}
