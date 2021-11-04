import 'package:adoodlz/blocs/providers/auth_provider.dart';
import 'package:adoodlz/helpers/localizations_provider.dart';
import 'package:adoodlz/routes/router.dart';
import 'package:adoodlz/ui/widgets/my_custom_icons2_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(
      context, /*listen: false*/
    );
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).settings),
        elevation: 0.0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            size: 20.0,
            color: Colors.black,
          ),
        ),
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [
            const SizedBox(
              height: 20.0,
            ),
            Card(
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0)),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    ListTile(
                      onTap: () {
                        final Locale locale =
                            AppLocalizations.of(context).localeName == 'ar'
                                ? const Locale('en')
                                : const Locale('ar');
                        context
                            .read<LocalizationsProvider>()
                            .changeLocale(locale);
                      },
                      leading: const Icon(MyCustomIcons2.lang_icon,
                          color: Color(0xFFDE608F)),
                      trailing: const Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.grey,
                        size: 20.0,
                      ),
                      dense: true,
                      title: Text(AppLocalizations.of(context).language,
                          style: Theme.of(context)
                              .textTheme
                              .headline5
                              .copyWith(fontWeight: FontWeight.w400)),
                    ),
                    const Divider(
                      color: Color(0xFFCCDCDC),
                      thickness: 1.0,
                      endIndent: 20.0,
                      indent: 70,
                      height: 30.0,
                    ),
                    ListTile(
                      onTap: () {
                        Navigator.of(context)
                            .pushNamed(Routes.editAccountScreen);
                      },
                      leading: const Icon(MyCustomIcons2.edit_data_icon,
                          size: 20.0, color: Color(0xFFDE608F)),
                      dense: true,
                      trailing: const Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.grey,
                        size: 20.0,
                      ),
                      title: Text(AppLocalizations.of(context).editYourData,
                          style: Theme.of(context)
                              .textTheme
                              .headline5
                              .copyWith(fontWeight: FontWeight.w400)),
                    ),
                    const Divider(
                      color: Color(0xFFCCDCDC),
                      thickness: 1.0,
                      endIndent: 20.0,
                      indent: 70,
                      height: 30.0,
                    ),
                    ListTile(
                      onTap: () {
                        Navigator.of(context)
                            .pushNamed(Routes.changePasswordScreen);
                      },
                      leading: const Icon(Icons.lock_outline_rounded,
                          color: Color(0xFFDE608F)),
                      dense: true,
                      trailing: const Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.grey,
                        size: 20.0,
                      ),
                      title: Text(AppLocalizations.of(context).changePassword,
                          style: Theme.of(context)
                              .textTheme
                              .headline5
                              .copyWith(fontWeight: FontWeight.w400)),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            Card(
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0)),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    ListTile(
                      onTap: () {
                        Navigator.of(context).pushNamed(Routes.aboutScreen);
                      },
                      leading: const Icon(MyCustomIcons2.lang_icon,
                          color: Color(0xFFDE608F)),
                      trailing: const Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.grey,
                        size: 20.0,
                      ),
                      dense: true,
                      title: Text(AppLocalizations.of(context).aboutUs,
                          style: Theme.of(context)
                              .textTheme
                              .headline5
                              .copyWith(fontWeight: FontWeight.w400)),
                    ),
                    const Divider(
                      color: Color(0xFFCCDCDC),
                      thickness: 1.0,
                      endIndent: 20.0,
                      indent: 70,
                      height: 30.0,
                    ),
                    ListTile(
                      onTap: () {
//const whatsAppUrl = 'https://api.whatsapp.com/send/?phone=966580495019&text=%D8%A7%D8%B1%D8%BA%D8%A8+%D8%A8%D9%85%D8%B3%D8%A7%D8%B9%D8%AF%D8%A9+%D9%81%D9%8A+%D8%AA%D8%B7%D8%A8%D9%8A%D9%82+%D8%A7%D8%AF%D9%88%D9%88%D8%AF%D9%84%D8%B2&app_absent=0';
                        const whatsAppUrl =
                            'https://api.whatsapp.com/send/?phone=201274913123&text=%D8%A7%D8%B1%D8%BA%D8%A8+%D8%A8%D9%85%D8%B3%D8%A7%D8%B9%D8%AF%D8%A9+%D9%81%D9%8A+%D8%AA%D8%B7%D8%A8%D9%8A%D9%82+%D8%A7%D8%AF%D9%88%D9%88%D8%AF%D9%84%D8%B2&app_absent=0';
                        const tawkUrl = 'https://tawk.to/adoodlz';
                        showDialog(
                            context: context,
                            builder: (context) => Dialog(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(16)),
                                  elevation: 3,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 8.0),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        const SizedBox(
                                          width: 36,
                                        ),
                                        IconButton(
                                          icon: const Icon(
                                              FontAwesomeIcons.whatsapp),
                                          color: Colors.green,
                                          iconSize: 48,
                                          onPressed: () async {
                                            if (await canLaunch(whatsAppUrl)) {
                                              launch(whatsAppUrl);
                                            }
                                          },
                                        ),
                                        const Spacer(),
                                        IconButton(
                                          icon: const Icon(
                                              MyCustomIcons2.help_center_icon),
                                          color: Colors.blue,
                                          iconSize: 48,
                                          onPressed: () async {
                                            if (await canLaunch(tawkUrl)) {
                                              launch(tawkUrl);
                                            }
                                          },
                                        ),
                                        const SizedBox(
                                          width: 36,
                                        ),
                                      ],
                                    ),
                                  ),
                                ));
                      },
                      leading: const Icon(LineAwesomeIcons.comment_dots,
                          color: Color(0xFFDE608F)),
                      dense: true,
                      trailing: const Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.grey,
                        size: 20.0,
                      ),
                      title: Text(AppLocalizations.of(context).helpCenter,
                          style: Theme.of(context)
                              .textTheme
                              .headline5
                              .copyWith(fontWeight: FontWeight.w400)),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
