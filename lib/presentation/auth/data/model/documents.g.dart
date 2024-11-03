// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'documents.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Documents _$DocumentsFromJson(Map<String, dynamic> json) => Documents(
      id: (json['id'] as num).toInt(),
      userId: (json['userId'] as num).toInt(),
      documentType: json['documentType'] as String,
      filePath: json['filePath'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$DocumentsToJson(Documents instance) => <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'documentType': instance.documentType,
      'filePath': instance.filePath,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };
