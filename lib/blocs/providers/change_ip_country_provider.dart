import 'package:adoodlz/data/remote/constants/endpoints.dart' as endpoints;
import 'package:adoodlz/helpers/shared_preferences_keys.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChangeCountryIpProvider extends ChangeNotifier {
  String _country;
  String get countryName => _country;

  // ignore: avoid_void_async
  void changeToEgypt() async {
    final preferences = await SharedPreferences.getInstance();
    endpoints.baseUrl = endpoints.baseUrlEgypt;
    await preferences.setString(countryIp, endpoints.baseUrlEgypt);
    await preferences.setString(country, 'EG');
    _country = 'EG';
    notifyListeners();
    print('my first Url of egypt ${endpoints.baseUrlEgypt}');
    
  }

  // ignore: avoid_void_async
  void changeToSaudi() async {
    final preferences = await SharedPreferences.getInstance();
    endpoints.baseUrl = endpoints.baseUrlSaudi;
    await preferences.setString(countryIp, endpoints.baseUrl);
    await preferences.setString(country, 'SA');
    _country = 'SA';
    notifyListeners();
    print('my first Url of saudi ${endpoints.baseUrl}');
  }

  void getCountryIp() async {
    final preferences = await SharedPreferences.getInstance();

    final getCountryIp =
        preferences.getString(countryIp) ?? endpoints.baseUrlSaudi;
    final getCountryCode = preferences.getString(country) ?? 'SA';
    endpoints.baseUrl = getCountryIp;
    _country = getCountryCode;
    notifyListeners();
  }

  Future<void> getCountry() async {
    final preferences = await SharedPreferences.getInstance();
    final getCountryCode = preferences.getString(country) ?? 'SA';
    _country = getCountryCode;
    notifyListeners();
  }
}
