import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:grouped_buttons/grouped_buttons.dart';
import 'package:provider/provider.dart';
import 'package:adoodlz/helpers/localizations_provider.dart';
import 'package:adoodlz/routes/router.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:adoodlz/ui/widgets/custom_raised_button.dart';

class LanguageSelectionScreen0 extends StatefulWidget {
  const LanguageSelectionScreen0({Key key}) : super(key: key);

  @override
  _LanguageSelectionScreen0State createState() =>
      _LanguageSelectionScreen0State();
}

class _LanguageSelectionScreen0State extends State<LanguageSelectionScreen0> {
  String locale;

  @override
  void initState() {
    super.initState();
    locale = 'ar';
  }

  bool valuefirstar = false;
  bool valueseconden = false;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        extendBody: true,
        backgroundColor: Colors.white,
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Container(
                  //padding: const EdgeInsets.only(top: 64),
                  child: Center(
                    child: Image.asset(
                      'assets/images/logo.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 125,
                ),
                if (locale == 'ar')
                  Container(
                    margin: EdgeInsets.only(
                        left: width * 0.7, bottom: height * 0.05),
                    child: Text(
                      AppLocalizations.of(context).chooseLanguage,
                      style: const TextStyle(
                          color: Colors.black,
                          //fontFamily: 'Cairo-regular',
                          fontSize: 15),
                    ),
                  ),
                if (locale == 'en')
                  Container(
                    margin: EdgeInsets.only(
                        right: width * 0.5, bottom: height * 0.05),
                    child: Text(
                      AppLocalizations.of(context).chooseLanguage,
                      style: const TextStyle(
                          color: Colors.black,
                          //fontFamily: 'Cairo-regular',
                          fontSize: 15),
                    ),
                  ),
                SizedBox(
                  width: width * 0.9,
                  height: 150.0,
                  // child: Row(
                  //   children: <Widget>[
                  //     LanguageButton(
                  //       locale: locale,
                  //       value: 'ar',
                  //       updateState: () {
                  //         setState(() {
                  //           locale = 'ar';
                  //         });
                  //       },
                  //     ),
                  //     LanguageButton(
                  //       locale: locale,
                  //       value: 'en',
                  //       updateState: () {
                  //         setState(() {
                  //           locale = 'en';
                  //         });
                  //       },
                  //     ),
                  //   ],
                  // ),

                  child: Container(
                    width: double.infinity,
                    //height: 150,
                    child: Card(
                      elevation: 25,
                      margin: const EdgeInsets.all(10),
                      shadowColor: Colors.grey,
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      //margin: EdgeInsets.only(right: width * 0.5),
                      child: Column(
                        children: [
                          //Widget buildCheckBox() => ListTile(
                          Row(
                            children: [
                              Checkbox(
                                checkColor: Colors.white,
                                activeColor: Colors.pinkAccent,
                                value: valuefirstar,
                                onChanged: (bool value) {
                                  // setState(() {
                                  //   //valuefirstar = value;
                                  // });
                                },
                              ),
                              LanguageButton(
                                locale: locale,
                                value: 'ar',
                                updateState: () {
                                  setState(() {
                                    locale = 'ar';
                                    valuefirstar = true;
                                    valueseconden = false;
                                  });
                                },
                              ),
                            ],
                          ),
                          const Text(
                            '_____________________________________________',
                            style: TextStyle(color: Colors.black12),
                          ),
                          Row(
                            children: [
                              Checkbox(
                                checkColor: Colors.white,
                                activeColor: Colors.pinkAccent,
                                value: valueseconden,
                                onChanged: (bool value) {
                                  setState(() {
                                    //valueseconden = value;
                                  });
                                },
                              ),
                              LanguageButton(
                                locale: locale,
                                value: 'en',
                                updateState: () {
                                  setState(() {
                                    locale = 'en';
                                    valuefirstar = false;
                                    valueseconden = true;
                                  });
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: CustomRaisedButton(
                      onPressed: () {
                        Navigator.of(context)
                            .pushReplacementNamed(Routes.signinScreen0);
                      },
                      label: AppLocalizations.of(context).start),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class LanguageButton extends StatefulWidget {
  const LanguageButton({Key key, this.locale, this.value, this.updateState})
      : super(key: key);
  final String locale;
  final String value;
  final Function updateState;

  @override
  _LanguageButtonState createState() => _LanguageButtonState();
}

class _LanguageButtonState extends State<LanguageButton> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SizedBox(
        height: 48,
        child: FlatButton(
          onPressed: () {
            Provider.of<LocalizationsProvider>(context, listen: false)
                .changeLocale(Locale(widget.value));
            widget.updateState();
          },
          child: Text(
            widget.value == 'ar'
                ? AppLocalizations.of(context).ar
                : AppLocalizations.of(context).en,
            style: TextStyle(
              fontFamily: widget.value == 'ar' ? 'Almarai' : 'Open sans',
              color: widget.locale == widget.value
                  //? Theme.of(context).primaryColor
                  ? Colors.pinkAccent
                  : Colors.black45,
            ),
          ),
        ),
      ),
    );
  }
}
