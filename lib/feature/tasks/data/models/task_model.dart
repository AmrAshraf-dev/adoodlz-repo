import 'package:adoodlz/feature/tasks/data/models/content_task_model.dart';
import 'package:adoodlz/feature/tasks/data/models/field_setting_model.dart';
import 'package:adoodlz/feature/tasks/data/models/icon_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'task_model.g.dart';

@JsonSerializable()
class TaskModel {
  @JsonKey(name: '_id')
  String id;
  ContentTaskModel content;
  String image;
  IconModel icon;
  String corpId;
  @JsonKey(name: 'points_in')
  num pointsIn;
  @JsonKey(name: 'points_out')
  num pointsOut;
  String status;
  @JsonKey(name: 'default')
  String def;
  @JsonKey(name: 'approval_guide')
  String approvalGuide;
  @JsonKey(name: 'expires_at')
  DateTime expireAt;
  @JsonKey(name: 'max_app_submit')
  num maxAppSubmit;
  @JsonKey(name: 'max_user_submit')
  num maxUserSubmit;
  @JsonKey(name: 'total_user_submit')
  num totalUserSubmit;
  @JsonKey(name: 'total_app_submit')
  num totalAppSubmit;
  @JsonKey(name: 'fields_settings')
  List<FieldSettingModel> fieldSetting;
  @JsonKey(name: 'submitted')
  bool submitted;
  @JsonKey(name: 'submit_count')
  int submitCount;

  TaskModel({
    this.id,
    this.content,
    this.image,
    this.icon,
    this.corpId,
    this.pointsIn,
    this.pointsOut,
    this.status,
    this.def,
    this.fieldSetting,
    this.approvalGuide,
    this.expireAt,
    this.maxAppSubmit,
    this.maxUserSubmit,
    this.totalAppSubmit,
    this.totalUserSubmit,
    this.submitted,
    this.submitCount,
  });

  factory TaskModel.fromJson(Map<String, dynamic> json) =>
      _$TaskModelFromJson(json);
  Map<String, dynamic> toJson() => _$TaskModelToJson(this);
}
