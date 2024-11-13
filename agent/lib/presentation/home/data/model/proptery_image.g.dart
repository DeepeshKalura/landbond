// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'proptery_image.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PropertyImage _$PropertyImageFromJson(Map<String, dynamic> json) =>
    PropertyImage(
      url: json['url'] as String,
      isPrimary: json['isPrimary'] as bool,
      caption: json['caption'] as String?,
    );

Map<String, dynamic> _$PropertyImageToJson(PropertyImage instance) =>
    <String, dynamic>{
      'url': instance.url,
      'isPrimary': instance.isPrimary,
      'caption': instance.caption,
    };
