import 'package:json_annotation/json_annotation.dart';

part 'gift.g.dart';

@JsonSerializable()
class Gift {
  @JsonKey(name: '_id')
  String dbId;
  int id;
  String vendor;
  String points;
  String status;
  String details;
  String image;
  int stock;
  @JsonKey(name: 'expire_at')
  DateTime expireAt;

  Gift({
    this.details,
    this.expireAt,
    this.id,
    this.image,
    this.points,
    this.status,
    this.stock,
    this.vendor,
  });

  factory Gift.fromJson(Map<String, dynamic> json) => _$GiftFromJson(json);
  Map<String, dynamic> toJson() => _$GiftToJson(this);
}
