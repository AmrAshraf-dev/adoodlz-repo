// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'signin_request_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SigninRequestBody _$SigninRequestBodyFromJson(Map<String, dynamic> json) {
  return SigninRequestBody(
    mobile: json['mobile'] as String,
    password: json['password'] as String,
    version: json['version'] as String,
    coordinates: json['cordinates'] as String,
    address: json['address'] as String,
    firebaseToken: json['firebase_token'] as String,
  );
}

Map<String, dynamic> _$SigninRequestBodyToJson(SigninRequestBody instance) =>
    <String, dynamic>{
      'mobile': instance.mobile,
      'password': instance.password,
      'version': instance.version,
      'cordinates': instance.coordinates,
      'address': instance.address,
      'firebase_token': instance.firebaseToken,
    };
