// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'corporate.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Corporate _$CorporateFromJson(Map<String, dynamic> json) {
  return Corporate(
    balance: json['balance'] as int,
    details: json['details'] as String,
    email: json['email'] as String,
    id: json['id'] as int,
    mobile: json['mobile'] as String,
    status: json['status'] as String,
  );
}

Map<String, dynamic> _$CorporateToJson(Corporate instance) => <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'mobile': instance.mobile,
      'status': instance.status,
      'balance': instance.balance,
      'details': instance.details,
    };
