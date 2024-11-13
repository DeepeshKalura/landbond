// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Message _$MessageFromJson(Map<String, dynamic> json) => Message(
      senderId: json['senderId'] as String,
      receiverId: json['receiverId'] as String,
      text: json['text'] as String,
      timestamp: DateTime.parse(json['timestamp'] as String),
      isAgent: json['isAgent'] as bool,
      propteryId: json['propteryId'] as String,
    );

Map<String, dynamic> _$MessageToJson(Message instance) => <String, dynamic>{
      'senderId': instance.senderId,
      'receiverId': instance.receiverId,
      'text': instance.text,
      'timestamp': instance.timestamp.toIso8601String(),
      'isAgent': instance.isAgent,
      'propteryId': instance.propteryId,
    };
