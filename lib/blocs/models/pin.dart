import 'package:json_annotation/json_annotation.dart';

part 'pin.g.dart';

@JsonSerializable()
class Pin {
  String id;
  @JsonKey(name: 'postid')
  int postId;
  @JsonKey(name: 'userid')
  int userId;
  String status;
  @JsonKey(name: 'created_at')
  DateTime createdAt;
  @JsonKey(name: 'expireAt')
  DateTime expireAt;

  Pin({
    this.id,
    this.createdAt,
    this.expireAt,
    this.postId,
    this.status,
    this.userId,
  });

  factory Pin.fromJson(Map<String, dynamic> json) => _$PinFromJson(json);
  Map<String, dynamic> toJson() => _$PinToJson(this);
}
