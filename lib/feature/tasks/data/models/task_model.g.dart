// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TaskModel _$TaskModelFromJson(Map<String, dynamic> json) {
  return TaskModel(
    id: json['_id'] as String,
    content: json['content'] == null
        ? null
        : ContentTaskModel.fromJson(json['content'] as Map<String, dynamic>),
    image: json['image'] as String,
    icon: json['icon'] == null
        ? null
        : IconModel.fromJson(json['icon'] as Map<String, dynamic>),
    corpId: json['corpId'] as String,
    pointsIn: json['points_in'] as num,
    pointsOut: json['points_out'] as num,
    status: json['status'] as String,
    def: json['default'] as String,
    example: json['example'] as String,
    fieldSetting: (json['fields_settings'] as List)
        ?.map((e) => e == null
            ? null
            : FieldSettingModel.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    approvalGuide: json['approval_guide'] as String,
    expireAt: json['expires_at'] == null
        ? null
        : DateTime.parse(json['expires_at'] as String),
    maxAppSubmit: json['max_app_submit'] as num,
    maxUserSubmit: json['max_user_submit'] as num,
    totalAppSubmit: json['total_app_submit'] as num,
    totalUserSubmit: json['total_user_submit'] as num,
    submitted: json['submitted'] as bool,
    submitCount: json['submit_count'] as int,
  );
}

Map<String, dynamic> _$TaskModelToJson(TaskModel instance) => <String, dynamic>{
      '_id': instance.id,
      'content': instance.content,
      'image': instance.image,
      'icon': instance.icon,
      'corpId': instance.corpId,
      'points_in': instance.pointsIn,
      'points_out': instance.pointsOut,
      'status': instance.status,
      'default': instance.def,
      'approval_guide': instance.approvalGuide,
      'expires_at': instance.expireAt?.toIso8601String(),
      'max_app_submit': instance.maxAppSubmit,
      'max_user_submit': instance.maxUserSubmit,
      'total_user_submit': instance.totalUserSubmit,
      'total_app_submit': instance.totalAppSubmit,
      'fields_settings': instance.fieldSetting,
      'submitted': instance.submitted,
      'submit_count': instance.submitCount,
      'example': instance.example,
    };
