import 'package:adoodlz/feature/tasks/data/models/lang_setting.dart';
import 'package:json_annotation/json_annotation.dart';

part 'content_task_model.g.dart';

@JsonSerializable()
class ContentTaskModel{

LangSettingModel en;
LangSettingModel ar;

ContentTaskModel({this.en,this.ar});

factory ContentTaskModel.fromJson(Map<String, dynamic> json) =>
    _$ContentTaskModelFromJson(json);
Map<String, dynamic> toJson() => _$ContentTaskModelToJson(this);
}