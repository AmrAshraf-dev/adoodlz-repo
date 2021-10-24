// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'source.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Source _$SourceFromJson(Map<String, dynamic> json) {
  return Source(
    browser: json['browser'] as String,
    city: json['city'] as String,
    country: json['country'] as String,
    createdAt: json['created_at'] == null
        ? null
        : DateTime.parse(json['created_at'] as String),
    device: json['device'] as String,
    entryUrl: json['entry_url'] as String,
    ip: json['ip'] as String,
    language: json['language'] as String,
    os: json['os'] as String,
    referralUrl: json['referral_url'] as String,
    resolution: json['resolution'] as String,
    technology: json['technology'] as String,
  );
}

Map<String, dynamic> _$SourceToJson(Source instance) => <String, dynamic>{
      'ip': instance.ip,
      'country': instance.country,
      'city': instance.city,
      'language': instance.language,
      'entry_url': instance.entryUrl,
      'referral_url': instance.referralUrl,
      'browser': instance.browser,
      'technology': instance.technology,
      'device': instance.device,
      'os': instance.os,
      'resolution': instance.resolution,
      'created_at': instance.createdAt?.toIso8601String(),
    };
