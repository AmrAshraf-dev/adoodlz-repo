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
        pref.remove(registerStatusKey);

        whatsappNumber = body['configrations']['whatsapp_mobile'] as String;
        registerStatus = body['configrations']['register'] as bool;

        // print(whatsappNumber);
        pref.setString(whatsappNumberKey, whatsappNumber);
        pref.setBool(registerStatusKey, registerStatus);

        whatsappNumber = pref.getString(whatsappNumberKey);
        registerStatus = pref.getBool(registerStatusKey);
        print(whatsappNumber);
        print('/////////////////////////////////');
        print(registerStatus);

        return body;
      }
      return body;
    } catch (e) {
      rethrow;
    }
  }
}
