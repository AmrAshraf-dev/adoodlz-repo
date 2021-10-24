import 'package:json_annotation/json_annotation.dart';

part 'source.g.dart';

@JsonSerializable()
class Source {
  String ip;
  String country;
  String city;
  String language;
  @JsonKey(name: 'entry_url')
  String entryUrl;
  @JsonKey(name: 'referral_url')
  String referralUrl;
  String browser;
  String technology;
  String device;
  String os;
  String resolution;
  @JsonKey(name: 'created_at')
  DateTime createdAt;

  Source({
    this.browser,
    this.city,
    this.country,
    this.createdAt,
    this.device,
    this.entryUrl,
    this.ip,
    this.language,
    this.os,
    this.referralUrl,
    this.resolution,
    this.technology,
  });

  factory Source.fromJson(Map<String, dynamic> json) => _$SourceFromJson(json);
  Map<String, dynamic> toJson() => _$SourceToJson(this);
}
