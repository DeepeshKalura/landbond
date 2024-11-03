// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'producer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Producer _$ProducerFromJson(Map<String, dynamic> json) => Producer(
      id: json['id'] as String,
      name: json['name'] as String,
      type: $enumDecode(_$ProducerTypeEnumMap, json['type']),
      phoneNumber: json['phoneNumber'] as String,
      email: json['email'] as String,
      timezone: json['timezone'] as String,
      isVerified: json['isVerified'] as bool? ?? false,
      verificationDocuments: (json['verificationDocuments'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      verifiedAt: json['verifiedAt'] == null
          ? null
          : DateTime.parse(json['verifiedAt'] as String),
    );

Map<String, dynamic> _$ProducerToJson(Producer instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'type': _$ProducerTypeEnumMap[instance.type]!,
      'phoneNumber': instance.phoneNumber,
      'email': instance.email,
      'timezone': instance.timezone,
      'isVerified': instance.isVerified,
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
