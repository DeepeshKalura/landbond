import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'message.g.dart';

@immutable
@JsonSerializable()
class Message {
  final String senderId;
  final String receiverId;
  final String text;
  final DateTime timestamp;
  final bool isAgent;
  final String propteryId;

  const Message({
    required this.senderId,
    required this.receiverId,
    required this.text,
    required this.timestamp,
    required this.isAgent,
    required this.propteryId,
  });

  factory Message.fromJson(Map<String, dynamic> json) =>
      _$MessageFromJson(json);

  Map<String, dynamic> toJson() => _$MessageToJson(this);
}
