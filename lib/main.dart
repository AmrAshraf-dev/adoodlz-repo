import 'package:extended_image/extended_image.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:adoodlz/helpers/localizations_provider.dart';
import 'package:adoodlz/routes/router.dart';
import 'package:adoodlz/themes/theme.dart';
import 'package:adoodlz/providers_setup.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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

class MyApp extends StatelessWidget {
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
