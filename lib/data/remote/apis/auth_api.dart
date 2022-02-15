import 'dart:convert';

import 'package:adoodlz/blocs/models/user.dart';
import 'package:adoodlz/blocs/validators/signin_request_body.dart';
import 'package:adoodlz/data/remote/dio_client.dart';
import 'package:adoodlz/data/remote/constants/endpoints.dart' as endpoints;
import 'package:adoodlz/data/remote/interfaces/i_auth_api.dart';
import 'package:adoodlz/exceptions/fetch_exception.dart';
import 'package:adoodlz/helpers/shared_preferences_keys.dart';
import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthApi implements IAuthApi {
  final DioClient _dioClient;

  AuthApi(this._dioClient);

  @override
  Future<Map<String, dynamic>> signIn(
      SigninRequestBody signinRequestBody) async {
    try {
      final dynamic response = await _dioClient.post(endpoints.signIn,
          data: signinRequestBody.toJson());
      debugPrint(response.toString());

      if (response['error'] != null) {
        throw UserNotFoundException(signinRequestBody.mobile);
      } else {
        return response as Map<String, dynamic>;
      }
    } catch (e) {
      if (e is DioError) {
        debugPrint(e.response.data.toString());
      }
      rethrow;
    }
  }

  @override
  Future<User> getUser(String token, int id) async {
    try {
      final dynamic response = await _dioClient.get(
          '${endpoints.getUserData}/$id',
          options: Options(headers: {'Authorization': 'Bearer $token'}));
      if (response['user'] != null) {
        return User.fromJson(response['user'] as Map<String, dynamic>);
      } else {
        throw UserNotFoundException(id.toString());
      }
    } catch (e) {
      if (e is DioError) {
        debugPrint(e.response.data.toString());
      }
      rethrow;
    }
  }

  @override
  Future<String> sendOtp(String mobile) async {
    try {
      final dynamic response = await _dioClient
          .post(endpoints.generateOtp, data: {"mobile": mobile});
      if (response['sent'] != null && response['sent'] as bool) {
        return response['_id'] as String;
      } else {
        throw NetworkErrorException();
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<bool> verifyOtp(String mobile, String code) async {
    try {
      final dynamic response = await _dioClient
          .post(endpoints.verifyOtp, data: {"mobile": mobile, "code": code});
      //print('this our new Response ${response.toString()}');
      if (response['valid'] != null) {
        return response['valid'] as bool;
      } else {
        throw NetworkErrorException();
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<bool> createUser(
    String mobile,
    Map<String, dynamic> formData,
  ) async {
    try {
      formData['mobile'] = mobile;
      formData.remove('password_confirmation');
      print("print");
      final dynamic response = await _dioClient.put(
        endpoints.createPassword,
        data: formData,
      );
      print("response");
      print(response);

      if (response['id'] != null) {
        return true;
      }
      return false;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<User> updateUser(Map<String, dynamic> formData) async {
    try {
      final formDataToSend = FormData.fromMap(formData);
      debugPrint(formDataToSend.toString());
      final dynamic response = await _dioClient.put(
        endpoints.getUsers,
        data: formDataToSend,
      );
      if (response['user'] != null) {
        return User.fromJson(response['user'] as Map<String, dynamic>);
      } else {
        throw NetworkErrorException();
      }
    } catch (e) {
      if (e is DioError) {
        debugPrint(e.response.data.toString());
      }
      rethrow;
    }
  }

  @override
  Future<User> addFireBaseMessageToken(String token, String userId) async {
    try {
      //final formDataToSend = FormData.fromMap(formData);
      //debugPrint(formDataToSend.toString());
      final dynamic response = await _dioClient.put(
        endpoints.getUsers,
        data: {
          "id": userId,
          "firebase_token": token,
        },
      );
      print(response.toString());
      print('my data here ${response.toString()}');
      if (response['user'] != null) {
        print(response['user'].toString());
        return User.fromJson(response['user'] as Map<String, dynamic>);
      } else {
        throw NetworkErrorException();
      }
    } catch (e) {
      if (e is DioError) {
        debugPrint(e.response.data.toString());
      }
      rethrow;
    }
  }

  @override
  Future<String> signUp(Map<String, dynamic> formData) async {
    try {
      formData.remove('password_confirmation');
      debugPrint('this our Data live ${formData.toString()}');
      final formDataToSend = FormData.fromMap(formData);

      debugPrint('this our Data ${formDataToSend.toString()}');

      final dynamic response =
          await _dioClient.post(endpoints.generateOtp, data: formDataToSend);
      print('our response Data${response.toString()}');
      if (response['sent'] != null && response['sent'] as bool) {
        print('method Success');

        print(response['_id'] as String);
        return response['_id'] as String;
      } else {
        throw NetworkErrorException();
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> resetPassword(String mobile, String firebaseToken) async {
    try {
      final dynamic response = await _dioClient.post(endpoints.forgetPassword,
          data: {"mobile": mobile, "firebase_token": firebaseToken});
      print('this our new Response ${response.toString()}');
      if (response['valid'] != null) {
        return response['valid'] as bool;
      } else {
        throw NetworkErrorException();
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<String> updatePassword(String mobile, String password) async {
    try {
      final dynamic response = await _dioClient.post(endpoints.changePassword,
          data: {"mobile": mobile, "password": password});
      print('this our new Response ${response.toString()}');
      if (response['message'] != null) {
        return response['message'] as String;
      } else {
        throw NetworkErrorException();
      }
    } catch (e) {
      rethrow;
    }
  }

  // Future<String> resetPassword(String mobile) async {
  //   try {
  //     // formData.remove('password_confirmation');
  //     // debugPrint('this our Data live ${formData.toString()}');
  //     //final formDataToSend = FormData.fromMap(formData);

  //     //debugPrint('this our Data ${formDataToSend.toString()}');

  //     var response = await http.post(
  //         Uri.parse('https://adoodlz.herokuapp.com/otp/forget/password'),
  //         body: {'mobile': mobile});
  //     print(endpoints.forgetPassword);
  //     if (response.statusCode == 200) {
  //       // print(jsonDecode(response.body));
  //       final body = response.body;

  //       // SharedPreferences pref = await SharedPreferences.getInstance();
  //       // pref.setString(resetPasswordTokenKey, resetPasswordToken);

  //       return body;
  //     }
  //     throw Error();

  //     // if (response['sent'] != null && response['sent'] as bool) {
  //     //   print('method Success');
  //     //   print(response['_id'] as String);
  //     //   return response['_id'] as String;
  //     // } else {
  //     //   throw NetworkErrorException();
  //     // }
  //   } catch (e) {
  //     rethrow;
  //   }
  // }

  // @override
  // Future<String> reset(Map<String, dynamic> resetData) async {
  //   // TODO: implement reset
  //   try {
  //     // formData.remove('password_confirmation');
  //     // debugPrint('this our Data live ${formData.toString()}');
  //     //final formDataToSend = FormData.fromMap(formData);

  //     //debugPrint('this our Data ${formDataToSend.toString()}');
  //     final formDataToSend = FormData.fromMap(resetData);

  //     var response = await http.post(
  //         Uri.parse('https://adoodlz.herokuapp.com/otp/forget/password'),
  //         body: formDataToSend);
  //     print(endpoints.forgetPassword);
  //     if (response.statusCode == 200) {
  //       // print(jsonDecode(response.body));
  //       final body = response.body;

  //       // SharedPreferences pref = await SharedPreferences.getInstance();
  //       // pref.setString(resetPasswordTokenKey, resetPasswordToken);

  //       return body;
  //     }
  //     throw Error();

  //     // if (response['sent'] != null && response['sent'] as bool) {
  //     //   print('method Success');
  //     //   print(response['_id'] as String);
  //     //   return response['_id'] as String;
  //     // } else {
  //     //   throw NetworkErrorException();
  //     // }
  //   } catch (e) {
  //     rethrow;
  //   }

  // @override
  // Future<String> reset(Map<String, dynamic> formData) async {
  //   try {
  //     formData.remove('password_confirmation');
  //     debugPrint('this our Data live ${formData.toString()}');
  //     final formDataToSend = FormData.fromMap(formData);

  //     debugPrint('this our Data ${formDataToSend.toString()}');

  //     final dynamic response =
  //         await _dioClient.post(endpoints.generateOtp, data: formDataToSend);
  //     print('our response Data${response.toString()}');
  //     if (response['sent'] != null && response['sent'] as bool) {
  //       print('method Success');
  //       print(response['_id'] as String);
  //       return response['_id'] as String;
  //     } else {
  //       throw NetworkErrorException();
  //     }
  //   } catch (e) {
  //     rethrow;
  //   }
  // }

}
