// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'content_task_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ContentTaskModel _$ContentTaskModelFromJson(Map<String, dynamic> json) {
  return ContentTaskModel(
    en: json['en'] == null
        ? null
        : LangSettingModel.fromJson(json['en'] as Map<String, dynamic>),
    ar: json['ar'] == null
        ? null
        : LangSettingModel.fromJson(json['ar'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$ContentTaskModelToJson(ContentTaskModel instance) =>
    <String, dynamic>{
      'en': instance.en,
      'ar': instance.ar,
    };
