import 'package:adoodlz/blocs/providers/auth_provider.dart';
import 'package:adoodlz/blocs/providers/change_ip_country_provider.dart';
import 'package:adoodlz/data/remote/apis/auth_api.dart';
import 'package:adoodlz/data/remote/apis/reset_password_api.dart';
import 'package:adoodlz/helpers/shared_preferences_keys.dart';
import 'package:adoodlz/routes/router.dart';
import 'package:adoodlz/data/remote/constants/endpoints.dart' as endpoints;

import 'package:adoodlz/ui/widgets/custom_raised_button.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ForgetPasswordScreen extends StatefulWidget {
  @override
  _ForgetPasswordScreenState createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen>
    with SingleTickerProviderStateMixin {
  OutlineInputBorder outLineBorder = const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(5.0)),
      borderSide: BorderSide(width: 0.2));
  final GlobalKey<FormState> _forgetPasswordFormKey = GlobalKey<FormState>();
  String mobileNumber = '';
  bool loading = false;
  Map<String, dynamic> resetPassword;
  String _countryCode;
  AnimationController _loginButtonController;
  Animation<double> buttonSqueezeAnimation;

  @override
  void initState() {
    // TODO: implement initState
    _countryCode = '';
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
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 50.0),
          child: Form(
            key: _forgetPasswordFormKey,
            child: Column(
              //crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: IconButton(
                    icon: const Icon(
                      Icons.arrow_back_ios_outlined,
                      color: Colors.black,
                      size: 24.0,
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ),
                const SizedBox(
                  height: 60.0,
                ),
                Text(
                  AppLocalizations.of(context).forgetPassword,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 20.0),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                Container(
                  margin: const EdgeInsets.only(top: 15.0, bottom: 40.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(
                            bottom: 5.0, left: 10.0, right: 10.0),
                        child: Text(
                          AppLocalizations.of(context).mobilePhone,
                          style: const TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      Directionality(
                        textDirection: TextDirection.ltr,
                        child: IntlPhoneField(
                          onSaved: (value) => setState(() {
                            mobileNumber = value.completeNumber;
                          }),
                          onChanged: (value) => setState(() {
                            _countryCode = value.countryISOCode;

                            //_countryCode = value.countryISOCode;
                            // print("Country Code ${value.countryISOCode}");
                            // print("Complete Number ${value.completeNumber}");
                            mobileNumber = value.completeNumber;
                            //resetPassword['mobile'] = value.completeNumber;
                          }),
                          initialCountryCode:
                              countryCodeLocation == 'Saudi Arabia'
                                  ? 'SA'
                                  : 'EG',
                          autoValidate: false,
                          style: const TextStyle(
                              color: Colors.black, fontSize: 22),
                          decoration: InputDecoration(
                            hintText: countryCodeLocation == 'Saudi Arabia'
                                ? '5x xxx xxxx'
                                : '1xx xxx xxxx',
                            hintStyle: TextStyle(color: Colors.grey.shade300),
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
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 30.0),
                  child: CustomRaisedButton(
                    onPressed: () async {
                      print(!loading);
                      print('====================================');
                      if (_forgetPasswordFormKey.currentState.validate() &&
                          !loading) {
                        _loginButtonController.forward();
                        setState(() {
                          loading = true;
                        });
                        _forgetPasswordFormKey.currentState.save();
                        FocusManager.instance.primaryFocus.unfocus();

                        try {
                          if (_countryCode == 'EG') {
                            await Provider.of<ChangeCountryIpProvider>(context,
                                    listen: false)
                                .changeToEgypt();
                          } else if (_countryCode == 'SA') {
                            await Provider.of<ChangeCountryIpProvider>(context,
                                    listen: false)
                                .changeToSaudi();
                          } else {
                            await Provider.of<ChangeCountryIpProvider>(context,
                                    listen: false)
                                .changeToEgypt();
                          }
                          ResetPasswordApi rest = ResetPasswordApi();
                          rest.reset(mobile: mobileNumber, context: context);

                          // String id = await Provider.of<AuthProvider>(context,
                          //         listen: false)
                          //     .toString();
                          // Navigator.of(context).pushReplacementNamed(
                          //     Routes.verifyResetPasswordPage,
                          //     arguments: <String, dynamic>{
                          //       'number': mobileNumber,
                          //       '_id': id,
                          //       'resetPassword': true,
                          //     });
                        } catch (e) {
                          debugPrint((e as DioError).response.data.toString());
                          debugPrint("Error Here Catch");
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: Text(
                                  AppLocalizations.of(context).processFailure),
                              content: Text(AppLocalizations.of(context)
                                  .somethingWentWrong),
                            ),
                          );
                        }

                        setState(() {
                          loading = false;
                        });
                      } else {}

                      print('====================================');
                      print(_countryCode);
                      print('====================================');
                      print(endpoints.baseUrl);
                    },
                    loading: loading,
                    label: AppLocalizations.of(context).sendCodeForgetPassword,
                    lightFont: true,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
