// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hit.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Hit _$HitFromJson(Map<String, dynamic> json) {
  return Hit(
    corpId: json['corpid'] as String,
    goal: json['goal'] == null
        ? null
        : Goal.fromJson(json['goal'] as Map<String, dynamic>),
    source: json['source'] == null
        ? null
        : Source.fromJson(json['source'] as Map<String, dynamic>),
    status: json['status'] as String,
    userId: json['userid'] as String,
    postId: json['post_id'] as String,
  );
}

Map<String, dynamic> _$HitToJson(Hit instance) => <String, dynamic>{
      'userid': instance.userId,
      'corpid': instance.corpId,
      'post_id': instance.postId,
      'goal': instance.goal,
      'status': instance.status,
      'source': instance.source,
    };
