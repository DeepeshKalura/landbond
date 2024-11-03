// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'users.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Users _$UsersFromJson(Map<String, dynamic> json) => Users(
      userId: json['userId'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      role: $enumDecode(_$UserRoleEnumMap, json['role']),
      profilePhotoUrl: json['profilePhotoUrl'] as String,
      location: json['location'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
      address: json['address'] as String?,
      timezone: json['timezone'] as String?,
    )
      ..createdAt = DateTime.parse(json['createdAt'] as String)
      ..updatedAt = DateTime.parse(json['updatedAt'] as String);

Map<String, dynamic> _$UsersToJson(Users instance) => <String, dynamic>{
      'userId': instance.userId,
      'name': instance.name,
      'email': instance.email,
      'role': _$UserRoleEnumMap[instance.role]!,
      'profilePhotoUrl': instance.profilePhotoUrl,
      'timezone': instance.timezone,
      'phoneNumber': instance.phoneNumber,
      'location': instance.location,
      'address': instance.address,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };

const _$UserRoleEnumMap = {
  UserRole.consumer: 'consumer',
  UserRole.admin: 'admin',
  UserRole.producer: 'producer',
};
