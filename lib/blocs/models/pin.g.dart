// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pin.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Pin _$PinFromJson(Map<String, dynamic> json) {
  return Pin(
    id: json['id'] as String,
    createdAt: json['created_at'] == null
        ? null
        : DateTime.parse(json['created_at'] as String),
    expireAt: json['expireAt'] == null
        ? null
        : DateTime.parse(json['expireAt'] as String),
    postId: json['postid'] as int,
    status: json['status'] as String,
    userId: json['userid'] as int,
  );
}

Map<String, dynamic> _$PinToJson(Pin instance) => <String, dynamic>{
      'id': instance.id,
      'postid': instance.postId,
      'userid': instance.userId,
      'status': instance.status,
      'created_at': instance.createdAt?.toIso8601String(),
      'expireAt': instance.expireAt?.toIso8601String(),
    };
