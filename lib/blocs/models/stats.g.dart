// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stats.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Stats _$StatsFromJson(Map<String, dynamic> json) {
  return Stats(
    points: json['points'] as int,
    shares: json['shares'] as int,
  );
}

Map<String, dynamic> _$StatsToJson(Stats instance) => <String, dynamic>{
      'shares': instance.shares,
      'points': instance.points,
    };
