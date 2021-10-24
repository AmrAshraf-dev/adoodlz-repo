import 'package:adoodlz/blocs/providers/auth_provider.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:adoodlz/blocs/validators/signin_request_body.dart';
import 'package:adoodlz/helpers/ui/ui_helpers.dart';
import 'package:adoodlz/ui/widgets/custom_raised_button.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:adoodlz/helpers/ui/app_colors.dart';
import 'package:adoodlz/routes/router.dart';
import 'package:provider/provider.dart';

class SignupScreen extends StatefulWidget {
  // ignore: avoid_positional_boolean_parameters
  const SignupScreen(this.mobile, this.id, this.resetPassword);
  final String mobile;
  final String id;
  final bool resetPassword;

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final GlobalKey<FormState> _signupFormKey = GlobalKey<FormState>();

  bool loading;
  Map<String, String> _signupInfo;

  @override
  void initState() {
    loading = false;
    _signupInfo = {};
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: Column(
            children: [
              const SizedBox(
                height: 84,
              ),
              Text(
                AppLocalizations.of(context).createAccount,
                style: Theme.of(context).textTheme.headline4,
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 24,
              ),
              Form(
                key: _signupFormKey,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      UIHelper.verticalSpaceMedium(),
                      if (!widget.resetPassword)
                        TextFormField(
                          onSaved: (value) => setState(() {
                            _signupInfo['name'] = value;
                          }),
                          decoration: InputDecoration(
                            labelText: AppLocalizations.of(context).name,
                            prefixIcon: Icon(LineAwesomeIcons.lock,
                                color: textColor.withOpacity(0.7)),
                          ),
                          validator: (value) {
                            if (value.isEmpty) {
                              return AppLocalizations.of(context).fieldRequired;
                            } else if (value.length < 2) {
                              return AppLocalizations.of(context)
                                  .fieldMinimum(4);
                            }
                            return null;
                          },
                        ),
                      if (!widget.resetPassword) UIHelper.verticalSpaceMedium(),
                      TextFormField(
                        textDirection: TextDirection.ltr,
                        onSaved: (value) => setState(() {
                          _signupInfo['password'] = value;
                        }),
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: AppLocalizations.of(context).password,
                          prefixIcon: Icon(LineAwesomeIcons.lock,
                              color: textColor.withOpacity(0.7)),
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
                      UIHelper.verticalSpaceMedium(),
                      TextFormField(
                        textDirection: TextDirection.ltr,
                        onSaved: (value) => setState(() {
                          _signupInfo['password_confirmation'] = value;
                        }),
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText:
                              AppLocalizations.of(context).confirmPassword,
                          prefixIcon: Icon(LineAwesomeIcons.lock,
                              color: textColor.withOpacity(0.7)),
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
                      const SizedBox(
                        height: 25,
                      ),
                      CustomRaisedButton(
                        onPressed: () async {
                          if (_signupFormKey.currentState.validate() && !loading) {
                            _signupFormKey.currentState.save();
                            if (_signupInfo['password'] == _signupInfo['password_confirmation']) {
                              setState(() {
                                loading = true;
                              });
                              try {
                                final success = await Provider.of<AuthProvider>(
                                        context,
                                        listen: false)
                                    .createUser(_signupInfo,
                                        mobile: widget.mobile,
                                        id: widget.id,
                                        resetBalance: !widget.resetPassword);

                                if (success) {
                                  final signinRequestBody =
                                      SigninRequestBody.fromJson({
                                    'mobile': widget.mobile,
                                    'password': _signupInfo['password']
                                  });
                                  try {
                                    //print("Before Sign in");
                                    final success =
                                        await Provider.of<AuthProvider>(context,
                                                listen: false)
                                            .signIn(signinRequestBody);
                                    //print("After Sign in");
                                    if (success == 'true') {
                                      Provider.of<Dio>(context, listen: false)
                                          .options = BaseOptions(headers: {
                                        "Authorization":
                                            "Bearer ${Provider.of<AuthProvider>(context, listen: false).tokenData['token']}"
                                      });

                                      Navigator.of(context)
                                          .pushReplacementNamed(
                                              Routes.homeScreen);
                                    } else {
                                      showDialog(
                                          context: context,
                                          builder: (context) => AlertDialog(
                                                title: Text(
                                                    AppLocalizations.of(context)
                                                        .processFailure),
                                                content: Text(
                                                    AppLocalizations.of(context)
                                                        .invalidCredentials),
                                              ));
                                      //print('$_signupInfo my registeration info الاسم و الباسورد و التأكيد');
                                    }
                                  } catch (e) {
                                    showDialog(
                                        context: context,
                                        builder: (context) => AlertDialog(
                                              title: Text(
                                                  AppLocalizations.of(context)
                                                      .loginFailed),
                                              content: Text(
                                                  AppLocalizations.of(context)
                                                      .somethingWentWrong),
                                            ));
                                    //print('$_signupInfo my registeration info الاسم و الباسورد و التأكيد');
                                  }
                                } else {
                                  // print("not success");
                                  showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                            title: Text(
                                                AppLocalizations.of(context)
                                                    .processFailure),
                                            content: Text(
                                                AppLocalizations.of(context)
                                                    .somethingWentWrong),
                                          ));
                                  // print('$_signupInfo my registeration info الاسم و الباسورد و التأكيد');
                                }
                              } catch (e) {
                                // print("not success 3");
                                showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                          title: Text(
                                              AppLocalizations.of(context)
                                                  .processFailure),
                                          content: Text(
                                              AppLocalizations.of(context)
                                                  .somethingWentWrong),
                                        ));
                                //print( '$_signupInfo my registeration info الاسم و الباسورد و التأكيد');
                              } finally {
                                setState(() {
                                  loading = false;
                                });
                                //print('$_signupInfo my registeration info الاسم و الباسورد و التأكيد');
                              }
                            } else {
                              showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                        title: Text(AppLocalizations.of(context)
                                            .processFailure),
                                        content: Text(
                                            AppLocalizations.of(context)
                                                .passwordMismatch),
                                      ));
                            }
                          }
                        },
                        label: AppLocalizations.of(context).signupShort,
                        loading: loading,
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.05,
                      ),
                      // Text(
                      //   AppLocalizations.of(context).registerMessage,
                      //   style: TextStyle(fontSize: 18),
                      // ),
                      UIHelper.verticalSpaceMedium()
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
