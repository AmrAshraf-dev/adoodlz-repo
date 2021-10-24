// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_transaction.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserTransaction _$UserTransactionFromJson(Map<String, dynamic> json) {
  return UserTransaction(
    userId: json['userid'] as int,
    createdAt: json['created_at'] == null
        ? null
        : DateTime.parse(json['created_at'] as String),
    details: json['details'] as String,
    id: json['id'] as String,
    points: json['points'] as int,
    status: json['status'] as String,
  );
}

Map<String, dynamic> _$UserTransactionToJson(UserTransaction instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userid': instance.userId,
      'points': instance.points,
      'status': instance.status,
      'details': instance.details,
      'created_at': instance.createdAt?.toIso8601String(),
    };
