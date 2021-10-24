// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'field_setting_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FieldSettingModel _$FieldSettingModelFromJson(Map<String, dynamic> json) {
  return FieldSettingModel(
    fieldId: json['field_id'] as String,
    status: json['status'] as String,
    name: json['name'] as String,
    info: json['info'] as String,
  );
}

Map<String, dynamic> _$FieldSettingModelToJson(FieldSettingModel instance) =>
    <String, dynamic>{
      'field_id': instance.fieldId,
      'status': instance.status,
      'name': instance.name,
      'info': instance.info,
    };
