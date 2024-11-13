import 'package:json_annotation/json_annotation.dart';

part 'proptery_image.g.dart';

@JsonSerializable()
class PropertyImage {
  final String url;
  final bool isPrimary;
  final String? caption;

  PropertyImage({
    required this.url,
    required this.isPrimary,
    this.caption,
  });

  factory PropertyImage.fromJson(Map<String, dynamic> json) =>
      _$PropertyImageFromJson(json);

  Map<String, dynamic> toJson() => _$PropertyImageToJson(this);
}
