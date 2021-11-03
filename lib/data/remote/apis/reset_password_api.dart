import 'dart:convert';

import 'package:adoodlz/blocs/models/reset_password_model.dart';
import 'package:adoodlz/blocs/providers/change_ip_country_provider.dart';
import 'package:adoodlz/data/remote/dio_client.dart';
import 'package:adoodlz/data/remote/constants/endpoints.dart' as endpoints;
import 'package:adoodlz/exceptions/fetch_exception.dart';
import 'package:adoodlz/helpers/shared_preferences_keys.dart';
import 'package:adoodlz/routes/router.dart';
import 'package:adoodlz/ui/screens/auth_screens/forget_password_screen.dart';
import 'package:adoodlz/ui/screens/auth_screens/signin_screen_0.dart';
import 'package:adoodlz/ui/screens/auth_screens/verify_reset_password.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ResetPasswordApi {
  Dio dio;
  @override
  Future<String> reset(
      {@required String mobile, @required BuildContext context}) async {
    // TODO: implement reset
    try {
      // formData.remove('password_confirmation');
      // debugPrint('this our Data live ${formData.toString()}');
      //final formDataToSend = FormData.fromMap(formData);

      //debugPrint('this our Data ${formDataToSend.toString()}');
      final getCountry =
          Provider.of<ChangeCountryIpProvider>(context, listen: false);
      var response = await http
          .post(Uri.parse(endpoints.forgetPassword), body: {"mobile": mobile});

      print('htttttttttttttttttttttttttttttp');
      print(response.statusCode);
      print(response.body);
      print(endpoints.forgetPassword);
      var body = jsonDecode(response.body);
      if (response.statusCode == 200) {
        resetPasswordToken = body['token'] as String;
        resetPasswordId = body['id'] as int;
        print(body['id']);
        //  print(resetPasswordToken);
        SharedPreferences pref = await SharedPreferences.getInstance();
        pref.setString(resetPasswordTokenKey, resetPasswordToken.toString());
        pref.setInt(resetPasswordIdKey, resetPasswordId);
        resetPasswordToken = pref.getString(resetPasswordTokenKey);
        resetPasswordId = pref.getInt(resetPasswordIdKey);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (builder) =>
                VerifyResetPasswordScreen(mobile, body['id'].toString(), true),
          ),
        );
      } else if (response.statusCode == 404) {
        if (body['message'] == 'invalid phone number' ||
            body['message'] == 'user not found') {
          print(jsonDecode(response.body));
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text(AppLocalizations.of(context).processFailure),
              content: Text(AppLocalizations.of(context).invalidCredentials),
            ),
          );
        }

        /////////////////////////////////

        //print(pref.getString(resetPasswordTokenKey));

        return response.body;
      }
      return response.body;

      // if (response['sent'] != null && response['sent'] as bool) {
      //   print('method Success');
      //   print(response['_id'] as String);
      //   return response['_id'] as String;
      // } else {
      //   throw NetworkErrorException();
      // }
    } catch (e) {
      rethrow;
    }
  }

  Future<String> requestNewPassword({
    @required BuildContext context,
    @required String password,
    @required String token,
  }) async {
    // TODO: implement reset
    try {
      // formData.remove('password_confirmation');
      // debugPrint('this our Data live ${formData.toString()}');
      //final formDataToSend = FormData.fromMap(formData);

      //debugPrint('this our Data ${formDataToSend.toString()}');

      var response = await http.post(Uri.parse(endpoints.verifyResetPassword),
          body: {"password": password},
          headers: {"Authorization": 'Bearer $token'});
      print('================================================================');
      print(response.statusCode);
      print(response.body);
      if (response.statusCode == 200) {
        print(jsonDecode(response.body));
        var body = jsonDecode(response.body);
        if (body['message'] == 'password updated successfuly') {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (builder) => SigninScreen0(),
            ),
          );
        }

        return response.body;
      } else {
        throw NetworkErrorException();
      }

      // if (response['sent'] != null && response['sent'] as bool) {
      //   print('method Success');
      //   print(response['_id'] as String);
      //   return response['_id'] as String;
      // } else {
      //   throw NetworkErrorException();
      // }
    } catch (e) {
      rethrow;
    }
  }
}
