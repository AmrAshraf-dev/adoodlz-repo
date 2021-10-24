// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'submitted_task.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SubmittedTaskModel _$SubmittedTaskModelFromJson(Map<String, dynamic> json) {
  return SubmittedTaskModel(
    id: json['_id'] as String,
    userId: json['userId'] as String,
    taskId: json['taskId'] == null
        ? null
        : TaskModel.fromJson(json['taskId'] as Map<String, dynamic>),
    fields: (json['fields'] as List)
        ?.map((e) => e == null
            ? null
            : FieldSubmittedTask.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    status: json['status'] as String,
  );
}

Map<String, dynamic> _$SubmittedTaskModelToJson(SubmittedTaskModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'userId': instance.userId,
      'taskId': instance.taskId,
      'fields': instance.fields,
      'status': instance.status,
    };
