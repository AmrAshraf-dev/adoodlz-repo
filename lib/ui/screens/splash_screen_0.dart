import 'dart:async';

import 'package:adoodlz/blocs/providers/auth_provider.dart';
import 'package:adoodlz/blocs/providers/change_ip_country_provider.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:adoodlz/helpers/localizations_provider.dart';
import 'package:adoodlz/helpers/shared_preferences_keys.dart';
import 'package:adoodlz/routes/router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class SplashScreen0 extends StatefulWidget {
  const SplashScreen0({Key key}) : super(key: key);

  @override
  _SplashScreen0State createState() => _SplashScreen0State();
}

class _SplashScreen0State extends State<SplashScreen0> {
  @override
  void initState() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    //  checkVersion();
    Timer(const Duration(seconds: 5), () async {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);

      final SharedPreferences prefs = await SharedPreferences.getInstance();
      if (prefs.getString(savedLocaleKey) != null) {
        await authProvider.init();
        if (authProvider.isAuth) {
          Provider.of<ChangeCountryIpProvider>(context,listen: false).getCountryIp();
          Provider.of<Dio>(context, listen: false).options = BaseOptions(
              headers: {
                "Authorization": "Bearer ${authProvider.tokenData['token']}"
              });
          Navigator.of(context).pushReplacementNamed(Routes.homeScreen);
        } else {
          // Navigator.of(context).pushReplacementNamed(Routes.verifyAccountScreen,arguments: <String, dynamic>{
          //   'number': '+966123456789',
          //   'password': '123456',
          //   '_id': '123',
          //   'resetPassword': false,
          // } );
          Navigator.pushReplacementNamed(context, Routes.signinScreen0);
        }
      } else {
        Provider.of<LocalizationsProvider>(context, listen: false)
            .changeLocale(kDefaultLocale);
        Navigator.of(context)
            .pushReplacementNamed(Routes.languageSelectionScreen0);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Container(
        color: Colors.white,
        child: Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
            image: AssetImage('assets/images/splash.png'),
            fit: BoxFit.cover,
          )),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 8,
                      color: Theme.of(context).accentColor,
                    ),
                  ),
                  Expanded(
                    child: Container(
                      height: 8,
                      color: Theme.of(context).accentColor.withOpacity(0.24),
                    ),
                  ),
                ],
              ),
              const Spacer(),
              SizedBox(height: MediaQuery.of(context).size.height * 0.1),
              Column(
                children: [
                  Center(
                    child: Image.asset(
                      'assets/images/logo.png',
                      width: 242,
                      height: 128,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  Text(
                    '${AppLocalizations.of(context).loading} ...',
                    style: Theme.of(context).textTheme.subtitle1,
                  ),

                  // Image.asset('assets/images/splash.png'),
                ],
              ),
              const Spacer()
            ],
          ),
        ),
      ),
    );
  }
}
