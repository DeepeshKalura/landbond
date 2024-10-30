import 'package:json_annotation/json_annotation.dart';

part 'users.g.dart';

@JsonSerializable()
class Users {
  final int userId;
  final String name;
  final String email;
  final String password;
  final int roleId;
  final String phoneNumber;
  final String profilePhotoUrl;
  String? location;
  String? address;
  String? createdAt;
  String? updatedAt;

  Users({
    required this.userId,
    required this.name,
    required this.email,
    required this.password,
    required this.roleId,
    required this.phoneNumber,
    required this.profilePhotoUrl,
    this.location,
    this.address,
    this.createdAt,
    this.updatedAt,
  });

  factory Users.fromJson(Map<String, dynamic> json) => _$UsersFromJson(json);

  Map<String, dynamic> toJson() => _$UsersToJson(this);
}
