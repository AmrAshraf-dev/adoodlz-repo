import 'package:json_annotation/json_annotation.dart';

part 'corporate.g.dart';

@JsonSerializable()
class Corporate {
  int id;
  String email;
  String mobile;
  String status;
  int balance;
  String details;

  Corporate({
    this.balance,
    this.details,
    this.email,
    this.id,
    this.mobile,
    this.status,
  });

  factory Corporate.fromJson(Map<String, dynamic> json) =>
      _$CorporateFromJson(json);
  Map<String, dynamic> toJson() => _$CorporateToJson(this);
}
