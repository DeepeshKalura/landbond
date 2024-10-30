import 'package:json_annotation/json_annotation.dart';

part 'roles.g.dart';

@JsonSerializable()
class Roles {
  final int id;
  final String name;
  final DateTime createdAt;
  final DateTime updatedAt;

  Roles({
    required this.id,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Roles.fromJson(Map<String, dynamic> json) => _$RolesFromJson(json);

  Map<String, dynamic> toJson() => _$RolesToJson(this);

  String get roleName => name;
}
