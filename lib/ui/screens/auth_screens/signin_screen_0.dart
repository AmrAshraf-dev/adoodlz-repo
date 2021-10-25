import 'dart:async';

import 'package:adoodlz/blocs/providers/auth_provider.dart';
import 'package:adoodlz/blocs/providers/change_ip_country_provider.dart';
import 'package:adoodlz/ui/screens/language_selection_screen_0.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:adoodlz/blocs/validators/signin_request_body.dart';
import 'package:adoodlz/helpers/ui/ui_helpers.dart';
import 'package:adoodlz/ui/widgets/custom_raised_button.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:adoodlz/helpers/ui/app_colors.dart';
import 'package:adoodlz/routes/router.dart';
import 'package:adoodlz/ui/widgets/floating_support_button.dart';
import 'package:package_info/package_info.dart';
import 'package:provider/provider.dart';
import 'package:adoodlz/data/remote/constants/endpoints.dart' as endpoints;

class SigninScreen0 extends StatefulWidget {
  const SigninScreen0();

  @override
  _SigninScreen0State createState() => _SigninScreen0State();
}

class _SigninScreen0State extends State<SigninScreen0>
    with SingleTickerProviderStateMixin {
  OutlineInputBorder outLineBorder = const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(5.0)),
      borderSide: BorderSide(width: 0.2, color: Colors.black));

  final GlobalKey<FormState> _signInFormkey = GlobalKey<FormState>();
  LanguageButton languageButton;
  bool loading;
  bool obscurePassword;
  String countryISOCode;
  Map<String, String> _signInInfo;
  AnimationController _loginButtonController;
  Animation<double> buttonSqueezeAnimation;

  @override
  void initState() {
    _loginButtonController = AnimationController(
        duration: const Duration(milliseconds: 300), vsync: this);
    buttonSqueezeAnimation = Tween(
      begin: 320.0,
      end: 70.0,
    ).animate(
      CurvedAnimation(
        parent: _loginButtonController,
        curve: Curves.easeIn,
      ),
    );

    _loginButtonController.addListener(() {
      setState(() {});
    });

    loading = false;
    obscurePassword = true;
    _signInInfo = {};
    super.initState();
  }

  @override
  void dispose() {
    _loginButtonController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: _signInFormkey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const SizedBox(
                  height: 35,
                ),
                Center(child: Image.asset('assets/images/logo.png')),
                const SizedBox(
                  height: 50,
                ),
                //if (languageButton.locale == 'en')
                Padding(
                  padding: EdgeInsets.only(bottom: height * 0.02),
                  child: Text(
                    AppLocalizations.of(context).mobileNumber,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                ),

                // const Icon(Icons.phone),
                Directionality(
                  textDirection: TextDirection.ltr,
                  child: Flexible(
                    child: IntlPhoneField(
                      style: const TextStyle(fontSize: 22),
                      // onChanged: (value) => setState(() {
                      //   print("Country Code ${value.countryISOCode}");
                      //   print("Complete Number ${value.completeNumber}");
                      // }),
                      onSaved: (value) => setState(() {
                        _signInInfo['mobile'] = value.completeNumber;
                        countryISOCode = value.countryISOCode;
                      }),
                      initialCountryCode: 'SA',
                      autoValidate: false,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.only(
                          top: 15,
                          bottom: 5,
                          left: 20,
                          right: 20,
                        ),
                        disabledBorder: outLineBorder,
                        focusedErrorBorder: outLineBorder,
                        errorBorder: outLineBorder,
                        enabledBorder: outLineBorder,
                        focusedBorder: outLineBorder,
                        border: InputBorder.none,
                      ),
                      // decoration: InputDecoration(
                      //   labelText:
                      //       AppLocalizations.of(context).mobileNumber,
                      // ),
                      validator: (value) {
                        if (value.length > 12 || value.length < 8) {
                          return AppLocalizations.of(context).invalidPhone;
                        }
                        return null;
                      },
                    ),
                  ),
                ),

                UIHelper.verticalSpaceMedium(),
                Padding(
                  padding: EdgeInsets.only(
                      right: width * 0.6, bottom: height * 0.02),
                  child: Text(
                    AppLocalizations.of(context).password,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                ),
                Directionality(
                  textDirection: TextDirection.ltr,
                  child: TextFormField(
                    style: const TextStyle(fontSize: 22),
                    onSaved: (value) => setState(() {
                      _signInInfo['password'] = value;
                    }),
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: obscurePassword,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.only(
                        top: 15,
                        bottom: 5,
                        left: 20,
                        right: 20,
                      ),
                      disabledBorder: outLineBorder,
                      focusedErrorBorder: outLineBorder,
                      errorBorder: outLineBorder,
                      enabledBorder: outLineBorder,
                      focusedBorder: outLineBorder,
                      border: InputBorder.none,

                      //  labelText: AppLocalizations.of(context).password,
                      // prefixIcon: Icon(LineAwesomeIcons.lock,
                      //     color: textColor.withOpacity(0.7)),
                      suffixIcon: IconButton(
                        icon: Icon(
                          obscurePassword
                              ? FontAwesomeIcons.eye
                              : FontAwesomeIcons.eyeSlash,
                          color:
                              Theme.of(context).accentColor.withOpacity(0.45),
                        ),
                        onPressed: () {
                          setState(() {
                            obscurePassword = !obscurePassword;
                          });
                        },
                      ),
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return AppLocalizations.of(context).fieldRequired;
                      } else if (value.length < 2) {
                        return AppLocalizations.of(context).fieldMinimum(4);
                      }
                      return null;
                    },
                  ),
                  // GestureDetector(
                  //   onTap: () {
                  //     Navigator.of(context).pushReplacementNamed(
                  //         Routes.createAccountScreen,
                  //         arguments: {'resetPassword': true});
                  //   },
                  //   child: Text(
                  //     AppLocalizations.of(context).forgotPassword,
                  //     style: Theme.of(context).textTheme.subtitle2,
                  //   )),
                ),
                GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushNamed(
                        Routes.forgetPasswordScreen,
                      );
                    },
                    child: Container(
                      alignment: Alignment.centerRight,
                      padding: const EdgeInsets.all(5),
                      child: Text(
                        AppLocalizations.of(context).forgotPassword,
                        style: Theme.of(context).textTheme.subtitle1,
                        //textAlign: TextAlign.right,
                      ),
                    )),
                const SizedBox(
                  height: 25,
                ),
                Center(
                  child: CustomRaisedButton(
                    onPressed: () async {
                      if (_signInFormkey.currentState.validate() && !loading) {
                        _loginButtonController.forward();
                        setState(() {
                          loading = true;
                        });
                        _signInFormkey.currentState.save();
                        _signInInfo['mobile'] = _signInInfo['mobile'].trim();
                        if (_signInInfo['mobile'].length == 14) {
                          _signInInfo['mobile'] =
                              _signInInfo['mobile'].replaceFirst('0', '');
                        }

                        /// change ip country

                        /// ///////////
                        final signinRequestBody =
                            SigninRequestBody.fromJson(_signInInfo);
                        final authProvider =
                            Provider.of<AuthProvider>(context, listen: false);

                        print(endpoints.generateOtp);
                        try {
                          if (countryISOCode == 'EG') {
                            await Provider.of<ChangeCountryIpProvider>(context,
                                    listen: false)
                                .changeToEgypt();
                          } else if (countryISOCode == 'SA') {
                            await Provider.of<ChangeCountryIpProvider>(context,
                                    listen: false)
                                .changeToSaudi();
                          } else {
                            await Provider.of<ChangeCountryIpProvider>(context,
                                    listen: false)
                                .changeToSaudi();
                          }
                          final success =
                              await authProvider.signIn(signinRequestBody);

                          //ignore: avoid_print
                          print('$_signInInfo thisss isss ourrr successss');
                          print(endpoints.baseUrl);
                          if (success == 'true') {
                            Provider.of<Dio>(context, listen: false).options =
                                BaseOptions(headers: {
                              "Authorization":
                                  "Bearer ${Provider.of<AuthProvider>(context, listen: false).tokenData['token']}"
                            });

                            Navigator.of(context)
                                .pushReplacementNamed(Routes.homeScreen);

                            // if (authProvider.user.status == 'User suspended') {
                            //   _loginButtonController.reverse();
                            //   showDialog(
                            //     context: context,
                            //     builder: (context) => AlertDialog(
                            //       title: Text(
                            //           AppLocalizations.of(context).loginFailed),
                            //       content: Text(
                            //           AppLocalizations.of(context).suspended),
                            //     ),
                            //   );
                            //   // ignore: avoid_print
                            //   print('$_signInInfo holddd');
                            // }
                          } else if (success == 'User suspended') {
                            _loginButtonController.reverse();
                            showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                      title: Text(AppLocalizations.of(context)
                                          .loginFailed),
                                      content: Text(AppLocalizations.of(context)
                                          .suspended),
                                    ));
                            // ignore: avoid_print
                            print('$_signInInfo infooooo');
                          } else {
                            _loginButtonController.reverse();
                            showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                      title: Text(AppLocalizations.of(context)
                                          .loginFailed),
                                      content: Text(AppLocalizations.of(context)
                                          .invalidCredentials),
                                    ));

                            // ignore: avoid_print
                            print('$_signInInfo invalid credentials');

                            // ignore: avoid_print
                            print('$_signInInfo infooooooooooooooooooooosdddd');
                          }
                        } catch (e) {
                          _loginButtonController.reverse();
                          showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                    title: Text(AppLocalizations.of(context)
                                        .loginFailed),
                                    content: Text(AppLocalizations.of(context)
                                        .somethingWentWrong),
                                  ));
                          // ignore: avoid_print
                          print('$_signInInfo error bad request');
                        }

                        Timer(const Duration(milliseconds: 150), () {
                          setState(() {
                            loading = false;
                          });
                        });
                      }
                    },
                    label: AppLocalizations.of(context).signIn,
                    loading: loading,
                    width: buttonSqueezeAnimation.value,
                  ),
                ),
                UIHelper.verticalSpaceMedium(),

                FutureBuilder<PackageInfo>(
                  future: PackageInfo.fromPlatform(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Text(
                        'V ${snapshot.data.version}',
                        style: Theme.of(context).textTheme.subtitle2,
                      );
                    } else {
                      return Container();
                    }
                  },
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.0,
                ),
                UIHelper.verticalSpaceMedium(),

                Padding(
                  padding: AppLocalizations.of(context).localeName == 'ar'
                      ? const EdgeInsets.only(right: 25.0)
                      : const EdgeInsets.only(left: 25.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        AppLocalizations.of(context).dontHaveAccount,
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                      GestureDetector(
                          onTap: () {
                            Navigator.of(context).pushReplacementNamed(
                                Routes.createAccountScreen,
                                arguments: {'resetPassword': false});
                          },
                          child: Text(
                            AppLocalizations.of(context).signUp,
                            style: //Theme.of(context).textTheme.subtitle2,
                                const TextStyle(
                              color: primaryColor,
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.underline,
                            ),
                          )),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: SupportButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
    );
  }
}
