import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

import 'message.dart';

part 'conservation.g.dart';

@JsonSerializable()
@immutable
class Conservation {
  final String userId1;
  final String userId2;
  final List<Message> messages;

  const Conservation({
    required this.userId1,
    required this.userId2,
    required this.messages,
  });

  factory Conservation.fromJson(Map<String, dynamic> json) =>
      _$ConservationFromJson(json);

  Map<String, dynamic> toJson() => _$ConservationToJson(this);
}
