// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) {
  return User(
    id: json['id'] as int,
    mobile: json['mobile'] as String,
    status: json['status'] as String,
    balance: json['balance'] as int,
    email: json['email'] as String,
    details: json['details'] as String,
    affiliaterId: json['affiliater_id'] as String,
    name: json['name'] as String,
    image: json['image'] as String,
    language: json['language'] as String,
    rate: json['rate'] as num,
    updatedAt: json['updatedAt'] == null
        ? null
        : DateTime.parse(json['updatedAt'] as String),
    waitBalance: json['pending_balance'] as int,
  );
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'mobile': instance.mobile,
      'status': instance.status,
      'balance': instance.balance,
      'pending_balance': instance.waitBalance,
      'email': instance.email,
      'name': instance.name,
      'details': instance.details,
      'affiliater_id': instance.affiliaterId,
      'language': instance.language,
      'rate': instance.rate,
      'image': instance.image,
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };
