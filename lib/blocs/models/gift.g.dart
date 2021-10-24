// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gift.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Gift _$GiftFromJson(Map<String, dynamic> json) {
  return Gift(
    details: json['details'] as String,
    expireAt: json['expire_at'] == null
        ? null
        : DateTime.parse(json['expire_at'] as String),
    id: json['id'] as int,
    image: json['image'] as String,
    points: json['points'] as String,
    status: json['status'] as String,
    stock: json['stock'] as int,
    vendor: json['vendor'] as String,
  )..dbId = json['_id'] as String;
}

Map<String, dynamic> _$GiftToJson(Gift instance) => <String, dynamic>{
      '_id': instance.dbId,
      'id': instance.id,
      'vendor': instance.vendor,
      'points': instance.points,
      'status': instance.status,
      'details': instance.details,
      'image': instance.image,
      'stock': instance.stock,
      'expire_at': instance.expireAt?.toIso8601String(),
    };
