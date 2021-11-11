import 'package:json_annotation/json_annotation.dart';

part 'signin_request_body.g.dart';

@JsonSerializable()
class SigninRequestBody {
  final String mobile;
  final String password;
  final String version;

  SigninRequestBody({this.mobile, this.password, this.version});

  factory SigninRequestBody.fromJson(Map<String, dynamic> json) =>
      _$SigninRequestBodyFromJson(json);
  Map<String, dynamic> toJson() => _$SigninRequestBodyToJson(this);
}
