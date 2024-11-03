import 'package:json_annotation/json_annotation.dart';

part 'documents.g.dart';

@JsonSerializable()
class Documents {
  final int id;
  final int userId;
  final String documentType;
  final String filePath;
  final DateTime createdAt;
  final DateTime updatedAt;

  Documents({
    required this.id,
    required this.userId,
    required this.documentType,
    required this.filePath,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Documents.fromJson(Map<String, dynamic> json) =>
      _$DocumentsFromJson(json);

  Map<String, dynamic> toJson() => _$DocumentsToJson(this);
}
