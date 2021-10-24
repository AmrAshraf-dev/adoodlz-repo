import 'package:json_annotation/json_annotation.dart';

part 'log.g.dart';

@JsonSerializable()
class Log {
  String id;
  String source;
  @JsonKey(name: 'created_at')
  DateTime createdAt;
  String details;

  Log({
    this.createdAt,
    this.details,
    this.id,
    this.source,
  });

  factory Log.fromJson(Map<String, dynamic> json) => _$LogFromJson(json);
  Map<String, dynamic> toJson() => _$LogToJson(this);
}
