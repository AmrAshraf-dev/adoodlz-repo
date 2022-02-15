import 'dart:async';
import 'dart:io';

import 'package:adoodlz/data/remote/apis/application_setting_api.dart';
import 'package:adoodlz/data/remote/constants/consts_function.dart';
import 'package:adoodlz/helpers/localizations_provider.dart';
import 'package:adoodlz/helpers/shared_preferences_keys.dart';
import 'package:adoodlz/providers_setup.dart';
import 'package:adoodlz/routes/router.dart';
import 'package:adoodlz/themes/theme.dart';
import 'package:connectivity/connectivity.dart';
import 'package:device_info/device_info.dart';
import 'package:extended_image/extended_image.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/ui/utils/stream_subscriber_mixin.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final localizationsProvider = LocalizationsProvider();
  await localizationsProvider.init();

  await Firebase.initializeApp();

  getMemoryImageCache().maximumSize = 40;

  final cacheSizeInMB = (await getCachedSizeBytes()) / 1048576;
  if (cacheSizeInMB > 100) {
    clearDiskCachedImages();
  }

  runApp(ChangeNotifierProvider(
      create: (_) => localizationsProvider,
      builder: (_, __) => MultiProvider(providers: providers, child: MyApp())));
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  ApplicationSetting app = ApplicationSetting();

  @override
  StreamSubscription subscribtion;

  void initState() {
    //removeshared();

    getCountryName();
    super.initState();
    // subscribtion =
    //     Connectivity().onConnectivityChanged.listen(showConnectivitySnackbar);
    getDeviceDetails();
    app.getApplicationSetting();
  }

  @override
  void dispose() {
    subscribtion.cancel();
    super.dispose();
  }

  // void showConnectivitySnackbar(ConnectivityResult result) async {
  //   final connectionResult = await Connectivity().checkConnectivity();

  //   final hasInternet = connectionResult != ConnectivityResult.none;
  //   final message =
  //       hasInternet ? 'you have again Internet' : 'You have no internet';
  //   final color = hasInternet ? Colors.green : Colors.red;
  //   print('colorrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr');
  //   print(connectionResult);

  //   Get.snackbar('Status', message,
  //       backgroundColor: color, colorText: Colors.white);
  // }

  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Adoodlz App',
      theme: appTheme.copyWith(
          //highlightColor: Color(0xffffc600),
          //scaffoldBackgroundColor: Colors.white,
          textTheme: appTheme.textTheme.apply(
              fontFamily:
                  context.watch<LocalizationsProvider>().locale.languageCode ==
                          'ar'
                      ? 'Almarai'
                      : 'Open sans')),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: context.watch<LocalizationsProvider>().locale,
      onGenerateRoute: CustomRouter.generateRoute,
      initialRoute: Routes.splashScreen0,
    );
  }
}
