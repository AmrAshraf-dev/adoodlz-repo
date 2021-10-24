// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'corporate_transaction.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CorporateTransaction _$CorporateTransactionFromJson(Map<String, dynamic> json) {
  return CorporateTransaction(
    corpId: json['corpid'] as int,
    createdAt: json['created_at'] == null
        ? null
        : DateTime.parse(json['created_at'] as String),
    details: json['details'] as String,
    id: json['id'] as String,
    points: json['points'] as int,
    status: json['status'] as String,
  );
}

Map<String, dynamic> _$CorporateTransactionToJson(
        CorporateTransaction instance) =>
    <String, dynamic>{
      'id': instance.id,
      'corpid': instance.corpId,
      'points': instance.points,
      'status': instance.status,
      'details': instance.details,
      'created_at': instance.createdAt?.toIso8601String(),
    };
