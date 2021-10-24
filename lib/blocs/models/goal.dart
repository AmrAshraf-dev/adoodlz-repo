import 'package:json_annotation/json_annotation.dart';

part 'goal.g.dart';

@JsonSerializable()
class Goal {
  @JsonKey(name: 'goal_type')
  String type;
  @JsonKey(name: 'points_in')
  int pointsIn;
  @JsonKey(name: 'points_out')
  int pointsOut;

  Goal({
    this.pointsIn,
    this.pointsOut,
    this.type,
  });

  factory Goal.fromJson(Map<String, dynamic> json) => _$GoalFromJson(json);
  Map<String, dynamic> toJson() => _$GoalToJson(this);
}
