import 'package:adoodlz/blocs/models/user.dart';
import 'package:adoodlz/feature/change_passwrod/data/repo/change_password_api.dart';
import 'package:flutter/material.dart';

class ChangePasswordProvider extends ChangeNotifier{
  final ChangePasswordApi _changePasswordApi;
  User user;
  Map<String, dynamic> tokenData;
  bool _loading;

  ChangePasswordProvider(this._changePasswordApi) :_loading = false;

  set loading(bool loading) {
    _loading = loading;
    notifyListeners();
  }

  bool get loading => _loading;

  Future<bool> changePassword(Map<String, dynamic> formData) async {
    try {
      loading = true;
      //final SharedPreferences prefs = await SharedPreferences.getInstance();
      //formData['id'] = tokenData['id'].toString();
      //formData['mobile'] = user.mobile;
      user = await _changePasswordApi.changePasswordUser(formData);
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

}