import 'package:json_annotation/json_annotation.dart';

part 'field_submitted_task.g.dart';

@JsonSerializable()
class FieldSubmittedTask {
  @JsonKey(name: '_id')
  String id;
  @JsonKey(name: 'field_id')
  String fieldID;
  String value;

  FieldSubmittedTask({
    this.id,
    this.fieldID,
    this.value,
  });

  factory FieldSubmittedTask.fromJson(Map<String, dynamic> json) =>
      _$FieldSubmittedTaskFromJson(json);
  Map<String, dynamic> toJson() => _$FieldSubmittedTaskToJson(this);

}
