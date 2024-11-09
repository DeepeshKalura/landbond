// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'conservation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Conservation _$ConservationFromJson(Map<String, dynamic> json) => Conservation(
      userId1: json['userId1'] as String,
      userId2: json['userId2'] as String,
      messages: (json['messages'] as List<dynamic>)
          .map((e) => Message.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ConservationToJson(Conservation instance) =>
    <String, dynamic>{
      'userId1': instance.userId1,
      'userId2': instance.userId2,
      'messages': instance.messages,
    };
