import 'package:json_annotation/json_annotation.dart';

part 'users.g.dart';

enum UserRole { consumer, admin, producer }

@JsonSerializable()
class Users {
  final String userId;
  final String name;
  final String email;
  final UserRole role;
  final String profilePhotoUrl;
  String? timezone;
  String? phoneNumber;
  String? location;
  String? address;
  late DateTime createdAt;
  late DateTime updatedAt;

  Users({
    required this.userId,
    required this.name,
    required this.email,
    required this.role,
    required this.profilePhotoUrl,
    this.location,
    this.phoneNumber,
    this.address,
    this.timezone,
  }) {
    createdAt = DateTime.now().toUtc();
    updatedAt = DateTime.now().toUtc();
  }

  factory Users.fromJson(Map<String, dynamic> json) => _$UsersFromJson(json);

  Map<String, dynamic> toJson() => _$UsersToJson(this);
}
