import 'dart:convert';

import 'package:adoodlz/blocs/models/user.dart';
import 'package:adoodlz/blocs/validators/signin_request_body.dart';
import 'package:adoodlz/data/remote/interfaces/i_auth_api.dart';
import 'package:adoodlz/helpers/shared_preferences_keys.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider extends ChangeNotifier {
  String userStatus;
  final IAuthApi _authApi;
  User user;
  Map<String, dynamic> tokenData;
  bool _loading;
  bool _updatingUser;

  bool get loading => _loading;

  bool get updatingUser => _updatingUser;

  bool _finish;

  set loading(bool loading) {
    _loading = loading;
    notifyListeners();
  }

  set updatingUser(bool updatingUser) {
    _updatingUser = updatingUser;
    notifyListeners();
  }

  void status(String status) {
    userStatus = status;
    notifyListeners();
  }

  bool get isAuth =>
      tokenData != null && tokenData['token'] != null && user != null;

  AuthProvider(this._authApi)
      : _loading = false,
        _updatingUser = false;

  Future<String> signIn(SigninRequestBody signinRequestBody) async {
    try {
      loading = true;
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      tokenData = await _authApi.signIn(signinRequestBody);
      await prefs.setString(savedTokenDataKey, json.encode(tokenData));
      user = await _authApi.getUser(
          tokenData['token'] as String, tokenData['id'] as int);
      await prefs.setString(savedUserKey, json.encode(user.toJson()));
      return 'true';
      //return true;
    } catch (e) {
      if (e is DioError) {
        // print('oru dataaaaaaa${e.response.data.toString()}');
        // status(e.response.data.toString());
        // print('useeeeeeeer $userStatus');
        loading = false;
        return e.response.data.toString();
      } else {
        loading = false;
        rethrow;
      }
    }
  }

  Future<void> updateUserData() async {
    try {
      loading = true;
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      user = await _authApi.getUser(
          tokenData['token'] as String, tokenData['id'] as int);
      await prefs.setString(savedUserKey, json.encode(user.toJson()));
      loading = false;
    } catch (e) {
      loading = false;
      rethrow;
    } finally {
      loading = false;
    }
    notifyListeners();
  }

  Future<bool> createUser(Map<String, dynamic> formData,
      {String id, String mobile, bool resetBalance = false}) async {
    try {
      loading = true;

      final success =
          await _authApi.createUser(mobile ?? user.mobile, formData);
      loading = false;
      return success;
    } catch (e) {
      loading = false;
      rethrow;
    } finally {
      loading = false;
    }
  }

  Future<bool> editUserData(Map<String, dynamic> formData) async {
    try {
      loading = true;
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      formData['id'] = tokenData['id'].toString();
      formData['mobile'] = user.mobile;
      user = await _authApi.updateUser(formData);
      await prefs.setString(savedUserKey, json.encode(user.toJson()));
      loading = false;
      return true;
    } catch (e) {
      loading = false;
      debugPrint(e.toString());
      rethrow;
    } finally {
      loading = false;
    }
  }

  Future<void> init() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey(savedTokenDataKey)) {
      tokenData = json.decode(prefs.getString(savedTokenDataKey))
          as Map<String, dynamic>;
    }
    if (prefs.containsKey(savedUserKey)) {
      user = User.fromJson(
          json.decode(prefs.getString(savedUserKey)) as Map<String, dynamic>);
    }
  }

  Future<void> logout() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(savedTokenDataKey);
    await prefs.remove(savedUserKey);
  }

  /// ///////////////////////////////////////
  Future<bool> addUserFireBaseToken(String token) async {
    try {
      loading = true;
      //final SharedPreferences prefs = await SharedPreferences.getInstance();
      String userId = tokenData['id'].toString();
      //formData['mobile'] = user.mobile;
      user = await _authApi.addFireBaseMessageToken(token, userId);
      //await prefs.setString(savedUserKey, json.encode(user.toJson()));
      loading = false;
      return true;
    } catch (e) {
      loading = false;
      debugPrint(e.toString());
      rethrow;
    } finally {
      loading = false;
    }
  }

  /// ///////////////////////////////////

  Future<String> signUpUser(Map<String, dynamic> formData,
      {String id, String mobile, bool resetBalance = false}) async {
    try {
      loading = true;

      final id = await _authApi.signUp(
        formData,
      );
      loading = false;
      return id;
    } catch (e) {
      loading = false;
      rethrow;
    } finally {
      loading = false;
    }
  }

  // Future<String> resetPassword({String id, String mobile}) async {
  //   try {
  //     loading = true;

  //     final id = await _authApi.reset(mobile);
  //     loading = false;
  //     return id;
  //   } catch (e) {
  //     loading = false;
  //     rethrow;
  //   } finally {
  //     loading = false;
  //   }
  // }

  /// ///////////////////////

  Future<String> resendOtpCode(Map<String, dynamic> formData) async {
    try {
      loading = true;
      final id = await _authApi.signUp(formData);
      loading = false;
      return id;
    } catch (e) {
      loading = false;
      rethrow;
    } finally {
      loading = false;
    }
  }
}
