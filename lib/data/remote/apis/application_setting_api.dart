import 'package:adoodlz/blocs/models/setting_model.dart';
import 'package:adoodlz/helpers/shared_preferences_keys.dart';
import 'package:adoodlz/data/remote/constants/endpoints.dart' as endpoints;

import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class ApplicationSetting {
  Future<dynamic> getApplicationSetting() async {
    // TODO: implement reset
    try {
      var response = await http.get(
        Uri.parse(endpoints.getAppConfig),
      );

      print('htttttttttttttttttttttttttttttp');
      print(response.statusCode);
      SharedPreferences pref = await SharedPreferences.getInstance();

      var body = jsonDecode(response.body);
      // print(body['configrations']['whatsapp_mobile']);
      if (response.statusCode == 200) {
        pref.remove(whatsappNumberKey);
        whatsappNumber = body['configrations']['whatsapp_mobile'] as String;
        // print(whatsappNumber);
        pref.setString(whatsappNumberKey, whatsappNumber);
        whatsappNumber = pref.getString(whatsappNumberKey);
        print(whatsappNumber);
        return body;
      }
      return body;
    } catch (e) {
      rethrow;
    }
  }
}
