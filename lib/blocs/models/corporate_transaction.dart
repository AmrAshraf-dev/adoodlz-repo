import 'package:json_annotation/json_annotation.dart';

part 'corporate_transaction.g.dart';

@JsonSerializable()
class CorporateTransaction {
  String id;
  @JsonKey(name: 'corpid')
  int corpId;
  int points;
  String status;
  String details;
  @JsonKey(name: 'created_at')
  DateTime createdAt;

  CorporateTransaction({
    this.corpId,
    this.createdAt,
    this.details,
    this.id,
    this.points,
    this.status,
  });

  factory CorporateTransaction.fromJson(Map<String, dynamic> json) =>
      _$CorporateTransactionFromJson(json);
  Map<String, dynamic> toJson() => _$CorporateTransactionToJson(this);
}
