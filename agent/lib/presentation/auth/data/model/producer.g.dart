// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'producer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Producer _$ProducerFromJson(Map<String, dynamic> json) => Producer(
      id: json['id'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      profilePhotoUrl: json['profilePhotoUrl'] as String,
      isVerified: json['isVerified'] as bool? ?? false,
      timezone: json['timezone'] as String? ?? "Asia/Kolkata",
      verificationDocuments: (json['verificationDocuments'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$ProducerToJson(Producer instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'email': instance.email,
      'profilePhotoUrl': instance.profilePhotoUrl,
      'isVerified': instance.isVerified,
      'timezone': instance.timezone,
      'verificationDocuments': instance.verificationDocuments,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };
