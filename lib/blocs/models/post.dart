import 'package:json_annotation/json_annotation.dart';
import 'package:adoodlz/blocs/models/goal.dart';
import 'package:adoodlz/blocs/models/stats.dart';

part 'post.g.dart';

@JsonSerializable()
class Post {
  @JsonKey(name: '_id')
  String dbId;
  int id;
  String title;
  String url;
  List<String> media;
  String content;
  @JsonKey(name: 'corpid')
  String corpId;
  List<Goal> goals;
  String status;
  @JsonKey(name: 'created_at')
  DateTime createdAt;
  @JsonKey(name: 'expire_at')
  DateTime expireAt;
  List<String> tags;
  Stats stats;
  @JsonKey(name: 'share_count')
  num shareCount;

  Post(
      {this.content,
      this.corpId,
      this.createdAt,
      this.expireAt,
      this.goals,
      this.id,
      this.media,
      this.stats,
      this.status,
      this.tags,
      this.url,
      this.dbId,
      this.title,
      this.shareCount});

  factory Post.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);
  Map<String, dynamic> toJson() => _$PostToJson(this);
}
