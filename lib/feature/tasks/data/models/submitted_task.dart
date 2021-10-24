import 'package:adoodlz/feature/tasks/data/models/field_submitted_task.dart';
import 'package:adoodlz/feature/tasks/data/models/task_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'submitted_task.g.dart';

@JsonSerializable()
class SubmittedTaskModel {
  @JsonKey(name: '_id')
  String id;
  String userId;
  TaskModel taskId;
  List<FieldSubmittedTask> fields;
  String status;

  SubmittedTaskModel({
    this.id,
    this.userId,
    this.taskId,
    this.fields,
    this.status,
  });

  factory SubmittedTaskModel.fromJson(Map<String, dynamic> json) =>
      _$SubmittedTaskModelFromJson(json);
  Map<String, dynamic> toJson() => _$SubmittedTaskModelToJson(this);
}
