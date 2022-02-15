import 'package:geocoder/geocoder.dart';
import 'package:json_annotation/json_annotation.dart';

part 'signin_request_body.g.dart';

@JsonSerializable()
class SigninRequestBody {
  final String mobile;
  final String password;
  final String version;
  final String coordinates;
  final String address;
  final String firebaseToken;
  final String deviceId;

  SigninRequestBody(
      {this.mobile,
      this.password,
      this.version,
      this.coordinates,
      this.firebaseToken,
      this.deviceId,
      this.address});

  factory SigninRequestBody.fromJson(Map<String, dynamic> json) =>
      _$SigninRequestBodyFromJson(json);
  Map<String, dynamic> toJson() => _$SigninRequestBodyToJson(this);
}
