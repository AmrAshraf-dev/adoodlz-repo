import 'package:adoodlz/blocs/models/user.dart';
import 'package:adoodlz/blocs/validators/signin_request_body.dart';

abstract class IAuthApi {
  Future<Map<String, dynamic>> signIn(SigninRequestBody loginRequestBody);
  Future<User> getUser(String token, int id);
  Future<String> sendOtp(String mobile);
  Future<bool> verifyOtp(String mobile, String code);
  Future<bool> createUser(
    String mobile,
    Map<String, dynamic> formData,
  );
  Future<User> updateUser(Map<String, dynamic> formData);
  Future<User> addFireBaseMessageToken(String token, String userId);

  Future<String> signUp(Map<String, dynamic> formData);
}
