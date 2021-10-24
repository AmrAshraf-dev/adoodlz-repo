import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  int id;
  String mobile;
  String status;
  int balance;
  @JsonKey(name: 'pending_balance')
  int waitBalance;
  String email;
  String name;
  String details;
  @JsonKey(name: 'affiliater_id')
  String affiliaterId;
  String language;
  num rate;
  String image;
  DateTime updatedAt;

  User(
      {this.id,
      this.mobile,
      this.status,
      this.balance,
      this.email,
      this.details,
      this.affiliaterId,
      this.name,
      this.image,
      this.language,
      this.rate,
      this.updatedAt,
      this.waitBalance});

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}
