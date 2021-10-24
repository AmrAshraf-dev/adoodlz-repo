// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'field_submitted_task.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FieldSubmittedTask _$FieldSubmittedTaskFromJson(Map<String, dynamic> json) {
  return FieldSubmittedTask(
    id: json['_id'] as String,
    fieldID: json['field_id'] as String,
    value: json['value'] as String,
  );
}

Map<String, dynamic> _$FieldSubmittedTaskToJson(FieldSubmittedTask instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'field_id': instance.fieldID,
      'value': instance.value,
    };
