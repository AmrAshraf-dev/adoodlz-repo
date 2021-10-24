import 'package:json_annotation/json_annotation.dart';

part 'user_transaction.g.dart';

@JsonSerializable()
class UserTransaction {
  String id;
  @JsonKey(name: 'userid')
  int userId;
  int points;
  String status;
  String details;
  @JsonKey(name: 'created_at')
  DateTime createdAt;

  UserTransaction({
    this.userId,
    this.createdAt,
    this.details,
    this.id,
    this.points,
    this.status,
  });

  factory UserTransaction.fromJson(Map<String, dynamic> json) =>
      _$UserTransactionFromJson(json);
  Map<String, dynamic> toJson() => _$UserTransactionToJson(this);
}
