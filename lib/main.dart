import 'package:adoodlz/data/remote/apis/application_setting_api.dart';
import 'package:adoodlz/helpers/localizations_provider.dart';
import 'package:adoodlz/helpers/shared_preferences_keys.dart';
import 'package:adoodlz/providers_setup.dart';
import 'package:adoodlz/routes/router.dart';
import 'package:adoodlz/themes/theme.dart';
import 'package:extended_image/extended_image.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  void removeshared() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.remove(resetPasswordTokenKey);
    await preferences.remove(resetPasswordIdKey);
    print(preferences.getString(resetPasswordTokenKey));
  }

  Future<String> getCountryName() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    debugPrint('location: ${position.latitude}');
    final coordinates = Coordinates(position.latitude, position.longitude);
    final addresses =
        await Geocoder.local.findAddressesFromCoordinates(coordinates);
    final first = addresses.first;
    countryCodeLocation = first.countryName;
    city = first.adminArea ?? '';
    userCoordinates = first.coordinates.toString() ?? '';
    print('/////////////////////////////////////////////');
    print(city);
    print(userCoordinates);
    //print(first.addressLine);
    return first.countryName; // this will return country name
  }

  ApplicationSetting app = ApplicationSetting();
  void initState() {
    removeshared();
    getCountryName();
    super.initState();
    app.getApplicationSetting();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
