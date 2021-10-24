import 'package:adoodlz/feature/tasks/data/models/lang_setting.dart';
import 'package:json_annotation/json_annotation.dart';

part 'field_setting_model.g.dart';

@JsonSerializable()
class FieldSettingModel {
  @JsonKey(name: 'field_id')
  String fieldId;
  String status;
  String name;
  String info;

  FieldSettingModel({
    this.fieldId,
    this.status,
    this.name,
    this.info,
  });

  factory FieldSettingModel.fromJson(Map<String, dynamic> json) => _$FieldSettingModelFromJson(json);
  Map<String, dynamic> toJson() => _$FieldSettingModelToJson(this);
}

