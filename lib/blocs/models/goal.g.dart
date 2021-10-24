// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'goal.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Goal _$GoalFromJson(Map<String, dynamic> json) {
  return Goal(
    pointsIn: json['points_in'] as int,
    pointsOut: json['points_out'] as int,
    type: json['goal_type'] as String,
  );
}

Map<String, dynamic> _$GoalToJson(Goal instance) => <String, dynamic>{
      'goal_type': instance.type,
      'points_in': instance.pointsIn,
      'points_out': instance.pointsOut,
    };
