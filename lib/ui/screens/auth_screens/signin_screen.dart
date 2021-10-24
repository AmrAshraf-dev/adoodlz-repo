import 'dart:async';

import 'package:adoodlz/blocs/providers/auth_provider.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:adoodlz/blocs/validators/signin_request_body.dart';
import 'package:adoodlz/helpers/ui/ui_helpers.dart';
import 'package:adoodlz/ui/widgets/custom_raised_button.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:adoodlz/helpers/ui/app_colors.dart';
import 'package:adoodlz/routes/router.dart';
import 'package:adoodlz/ui/widgets/floating_support_button.dart';
import 'package:package_info/package_info.dart';
import 'package:provider/provider.dart';

class SigninScreen extends StatefulWidget {
  const SigninScreen();

  @override
  _SigninScreenState createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen>
    with SingleTickerProviderStateMixin {
  final GlobalKey<FormState> _signInFormkey = GlobalKey<FormState>();

  bool loading;
  bool obscurePassword;
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
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: _signInFormkey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                const SizedBox(
                  height: 84,
                ),
                Center(child: Image.asset('assets/images/logo.png')),
                const SizedBox(
                  height: 24,
                ),
                // const Icon(Icons.phone),
                Directionality(
                  textDirection: TextDirection.ltr,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(LineAwesomeIcons.user,
                          color: textColor.withOpacity(0.7)),
                      Flexible(
                        child: IntlPhoneField(
                          onSaved: (value) => setState(() {
                            _signInInfo['mobile'] = value.completeNumber;
                          }),
                          initialCountryCode: 'EG',
                          autoValidate: false,
                          decoration: InputDecoration(
                            labelText:
                                AppLocalizations.of(context).mobileNumber,
                          ),
                          validator: (value) {
                            if (value.length > 12 || value.length < 8) {
                              return AppLocalizations.of(context).invalidPhone;
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                ),

                UIHelper.verticalSpaceMedium(),
                Directionality(
                  textDirection: TextDirection.ltr,
                  child: TextFormField(
                    onSaved: (value) => setState(() {
                      _signInInfo['password'] = value;
                    }),
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: obscurePassword,
                    decoration: InputDecoration(
                      labelText: AppLocalizations.of(context).password,
                      prefixIcon: Icon(LineAwesomeIcons.lock,
                          color: textColor.withOpacity(0.7)),
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
                ),
                const SizedBox(
                  height: 25,
                ),
                CustomRaisedButton(
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

                      final signinRequestBody =
                          SigninRequestBody.fromJson(_signInInfo);
                      final authProvider =
                          Provider.of<AuthProvider>(context, listen: false);
                      try {
                        final success = await Provider.of<AuthProvider>(context,
                                listen: false)
                            .signIn(signinRequestBody);

                        // ignore: avoid_print
                        print('$_signInInfo thisss isss ourrr successss');

                        if (success == 'true') {
                          Provider.of<Dio>(context, listen: false).options =
                              BaseOptions(headers: {
                            "Authorization":
                                "Bearer ${Provider.of<AuthProvider>(context, listen: false).tokenData['token']}"
                          });

                          Navigator.of(context)
                              .pushReplacementNamed(Routes.homeScreen);

                          if (authProvider.user.status == 'User suspended') {
                            _loginButtonController.reverse();
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: Text(
                                    AppLocalizations.of(context).loginFailed),
                                content: Text(
                                    AppLocalizations.of(context).suspended),
                              ),
                            );
                            // ignore: avoid_print
                            print('$_signInInfo holddd');
                          }
                        } else if (success == 'User suspended') {
                          _loginButtonController.reverse();
                          showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                    title: Text(AppLocalizations.of(context)
                                        .loginFailed),
                                    content: Text(
                                        AppLocalizations.of(context).suspended),
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
                                  title: Text(
                                      AppLocalizations.of(context).loginFailed),
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
                UIHelper.verticalSpaceMedium(),
                GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushNamed(
                          Routes.forgetPasswordScreen,
                          );
                    },
                    child: Text(
                      AppLocalizations.of(context).forgotPassword,
                      style: Theme.of(context).textTheme.subtitle2,
                    )),
                UIHelper.verticalSpaceMedium(),
                GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushReplacementNamed(
                          Routes.createAccountScreen,
                          arguments: {'resetPassword': false});
                    },
                    child: Text(
                      AppLocalizations.of(context).signUp,
                      style: Theme.of(context).textTheme.subtitle2,
                    )),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.05,
                ),
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
                UIHelper.verticalSpaceMedium()
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
