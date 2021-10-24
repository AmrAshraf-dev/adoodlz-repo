import 'package:adoodlz/feature/tasks/data/models/field_setting_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'lang_setting.g.dart';

@JsonSerializable()
class LangSettingModel {

  String title;
  String description;
  @JsonKey(name: 'fields_settings')
  List<FieldSettingModel> fieldSetting;

  LangSettingModel({
    this.title,
    this.description,
    this.fieldSetting,
  });

  factory LangSettingModel.fromJson(Map<String, dynamic> json) => _$LangSettingModelFromJson(json);
  Map<String, dynamic> toJson() => _$LangSettingModelToJson(this);
}
