// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lang_setting.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LangSettingModel _$LangSettingModelFromJson(Map<String, dynamic> json) {
  return LangSettingModel(
    title: json['title'] as String,
    description: json['description'] as String,
    fieldSetting: (json['fields_settings'] as List)
        ?.map((e) => e == null
            ? null
            : FieldSettingModel.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$LangSettingModelToJson(LangSettingModel instance) =>
    <String, dynamic>{
      'title': instance.title,
      'description': instance.description,
      'fields_settings': instance.fieldSetting,
    };
