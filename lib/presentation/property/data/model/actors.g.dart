// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'actors.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Actors _$ActorsFromJson(Map<String, dynamic> json) => Actors(
      id: json['id'] as String,
      email: json['email'] as String,
      name: json['name'] as String,
      phoneNumber: json['phoneNumber'] as String,
      isVerified: json['isVerified'] as String,
      profilePhotoUrl: json['profilePhotoUrl'] as String,
      timezone: json['timezone'] as String,
      type: $enumDecode(_$ProducerTypeEnumMap, json['type']),
      verificationDocuments: (json['verificationDocuments'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      verifiedAt: json['verifiedAt'] == null
          ? null
          : DateTime.parse(json['verifiedAt'] as String),
    );

Map<String, dynamic> _$ActorsToJson(Actors instance) => <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'name': instance.name,
      'phoneNumber': instance.phoneNumber,
      'isVerified': instance.isVerified,
      'profilePhotoUrl': instance.profilePhotoUrl,
      'timezone': instance.timezone,
      'type': _$ProducerTypeEnumMap[instance.type]!,
      'verificationDocuments': instance.verificationDocuments,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      'verifiedAt': instance.verifiedAt?.toIso8601String(),
    };

const _$ProducerTypeEnumMap = {
  ProducerType.dealer: 'dealer',
  ProducerType.agent: 'agent',
  ProducerType.owner: 'owner',
};
