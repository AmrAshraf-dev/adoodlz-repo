// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Post _$PostFromJson(Map<String, dynamic> json) {
  return Post(
    content: json['content'] as String,
    corpId: json['corpid'] as String,
    createdAt: json['created_at'] == null
        ? null
        : DateTime.parse(json['created_at'] as String),
    expireAt: json['expire_at'] == null
        ? null
        : DateTime.parse(json['expire_at'] as String),
    goals: (json['goals'] as List)
        ?.map(
            (e) => e == null ? null : Goal.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    id: json['id'] as int,
    media: (json['media'] as List)?.map((e) => e as String)?.toList(),
    stats: json['stats'] == null
        ? null
        : Stats.fromJson(json['stats'] as Map<String, dynamic>),
    status: json['status'] as String,
    tags: (json['tags'] as List)?.map((e) => e as String)?.toList(),
    url: json['url'] as String,
    dbId: json['_id'] as String,
    title: json['title'] as String,
    shareCount: json['share_count'] as num,
  );
}

Map<String, dynamic> _$PostToJson(Post instance) => <String, dynamic>{
      '_id': instance.dbId,
      'id': instance.id,
      'title': instance.title,
      'url': instance.url,
      'media': instance.media,
      'content': instance.content,
      'corpid': instance.corpId,
      'goals': instance.goals,
      'status': instance.status,
      'created_at': instance.createdAt?.toIso8601String(),
      'expire_at': instance.expireAt?.toIso8601String(),
      'tags': instance.tags,
      'stats': instance.stats,
      'share_count': instance.shareCount,
    };
