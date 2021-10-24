import 'package:json_annotation/json_annotation.dart';
import 'package:adoodlz/blocs/models/goal.dart';
import 'package:adoodlz/blocs/models/source.dart';

part 'hit.g.dart';

@JsonSerializable()
class Hit {
  @JsonKey(name: 'userid')
  String userId;
  @JsonKey(name: 'corpid')
  String corpId;
  @JsonKey(name: 'post_id')
  String postId;

  Goal goal;
  String status;
  Source source;

  Hit({this.corpId, this.goal, this.source, this.status, this.userId,this.postId});

  factory Hit.fromJson(Map<String, dynamic> json) => _$HitFromJson(json);
  Map<String, dynamic> toJson() => _$HitToJson(this);
}
