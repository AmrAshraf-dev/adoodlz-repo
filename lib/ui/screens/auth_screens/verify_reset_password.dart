import 'dart:async';

import 'package:adoodlz/blocs/providers/auth_provider.dart';
import 'package:adoodlz/blocs/validators/signin_request_body.dart';
import 'package:adoodlz/data/remote/apis/auth_api.dart';
import 'package:adoodlz/feature/change_passwrod/ui/screens/change_passwprd_screen.dart';
import 'package:adoodlz/routes/router.dart';
import 'package:adoodlz/ui/screens/auth_screens/forget_password_screen.dart';
import 'package:adoodlz/ui/screens/auth_screens/reset_password_screen.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:adoodlz/helpers/ui/ui_helpers.dart';
import 'package:adoodlz/ui/widgets/custom_raised_button.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';

class VerifyResetPasswordScreen extends StatefulWidget {
  // ignore: avoid_positional_boolean_parameters
  const VerifyResetPasswordScreen(
      this.mobileNumber, this.id, this.resetPassword,
      {this.password});
  final String mobileNumber;
  final String id;
  final bool resetPassword;
  final String password;

  @override
  _VerifyResetPasswordScreenState createState() =>
      _VerifyResetPasswordScreenState();
}

class _VerifyResetPasswordScreenState extends State<VerifyResetPasswordScreen> {
  final TextEditingController _pinController = TextEditingController();
  bool loading;
  int _counter = 60;
  Timer _timer;
  Map<String, dynamic> formData = {};

  @override
  void initState() {
    loading = false;
    _startTimer();

    super.initState();
  }

  void _startTimer() {
    _counter = 60;
    if (_timer != null) {
      _timer.cancel();
    }
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_counter > 0) {
        setState(() {
          _counter--;
        });
      } else {
        _timer.cancel();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              // const SizedBox(
              //   height: 36,
              // ),
              // Text(
              //   AppLocalizations.of(context).verifyAccount,
              //   style: Theme.of(context).textTheme.headline4,
              // ),

              // Padding(
              //   padding: const EdgeInsets.all(16.0),
              //   child: Align(
              //     alignment: Alignment.centerLeft,
              //     child: IconButton(
              //       icon: const Icon(
              //         Icons.arrow_back_ios_outlined,
              //         color: Colors.black,
              //         size: 24.0,
              //       ),
              //       onPressed: () {
              //         Navigator.of(context).pop();
              //       },
              //     ),
              //   ),
              // ),
              const SizedBox(
                height: 100,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    const SizedBox(
                      height: 16,
                    ),
                    Text(AppLocalizations.of(context).mobileVerificationOngoing,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            fontSize: 20.0, fontWeight: FontWeight.w600)),
                    const SizedBox(
                      height: 24,
                    ),
                    Container(
                      alignment: Alignment.center,
                      child: Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: AppLocalizations.of(context)
                                  .otpWillBeSent(widget.mobileNumber),
                              style: const TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 16.0,
                                color: Color(0xFF9B9B9B),
                              ),
                            ),
                            TextSpan(
                              text: widget.mobileNumber,
                              style: const TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 16.0,
                                color: Colors.blue,
                              ),
                            ),
                          ],
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    Directionality(
                      textDirection: TextDirection.ltr,
                      child: Padding(
                        padding: const EdgeInsets.all(30.0),
                        child: Builder(
                          builder: (context) => PinCodeTextField(
                              appContext: context,
                              length: 4,
                              controller: _pinController,
                              enableActiveFill: true,
                              pinTheme: PinTheme(
                                fieldHeight: 65.0,
                                fieldWidth: 50.0,
                                borderRadius: BorderRadius.circular(25.0),
                                shape: PinCodeFieldShape.box,
                                selectedFillColor: const Color(0xFFF8DEE8),
                                selectedColor: const Color(0xFFF8DEE8),
                                inactiveColor: const Color(0xFFF8DEE8),
                                inactiveFillColor: const Color(0xFFF8DEE8),
                              ),
                              backgroundColor:
                                  Theme.of(context).scaffoldBackgroundColor,
                              onSubmitted: (value) async {
                                if (!loading &&
                                    _pinController.text.isNotEmpty &&
                                    _pinController.text.length == 4) {
                                  setState(() {
                                    loading = true;
                                  });

                                  try {
                                    final pin = _pinController.text;
                                    final successOtp = await Provider.of<
                                            AuthApi>(context, listen: false)
                                        .verifyOtp(widget.mobileNumber, pin);

                                    if (successOtp) {
                                      print('hey');

                                      print('we get pass');
                                      try {
                                        Navigator.pop(context);
                                        Navigator.of(context)
                                            .pushReplacementNamed(
                                                Routes.resetPasswordScreen);
                                        //print("After Sign in");

                                      } catch (e) {
                                        showDialog(
                                            context: context,
                                            builder: (context) => AlertDialog(
                                                  title: Text(
                                                      AppLocalizations.of(
                                                              context)
                                                          .loginFailed),
                                                  content: Text(
                                                      AppLocalizations.of(
                                                              context)
                                                          .wrongOtp),
                                                ));
                                        //print('$_signupInfo my registeration info الاسم و الباسورد و التأكيد');
                                      }
                                    } else {
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
                                    }
                                  } catch (e) {
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
                                  } finally {
                                    setState(() {
                                      loading = false;
                                    });
                                  }
                                } else {
                                  Scaffold.of(context).showSnackBar(SnackBar(
                                    content: Text(AppLocalizations.of(context)
                                        .invalidOtp),
                                  ));
                                }
                              },
                              onChanged: (value) async {}),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 70,
                    ),
                    Builder(
                      builder: (context) => CustomRaisedButton(
                        onPressed: () async {
                          if (!loading &&
                              _pinController.text.isNotEmpty &&
                              _pinController.text.length == 4) {
                            setState(() {
                              loading = true;
                            });

                            try {
                              final pin = _pinController.text;
                              final successOtp = await Provider.of<AuthApi>(
                                      context,
                                      listen: false)
                                  .verifyOtp(widget.mobileNumber, pin);

                              if (successOtp) {
                                print('hey');

                                print('we get pass');
                                try {
                                  Navigator.pop(context);
                                  Navigator.of(context).pushReplacementNamed(
                                      Routes.resetPasswordScreen);
                                  //print("After Sign in");

                                } catch (e) {
                                  showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                            title: Text(
                                                AppLocalizations.of(context)
                                                    .loginFailed),
                                            content: Text(
                                                AppLocalizations.of(context)
                                                    .wrongOtp),
                                          ));
                                  //print('$_signupInfo my registeration info الاسم و الباسورد و التأكيد');
                                }
                              } else {
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
                              }
                            } catch (e) {
                              showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                        title: Text(AppLocalizations.of(context)
                                            .processFailure),
                                        content: Text(
                                            AppLocalizations.of(context)
                                                .somethingWentWrong),
                                      ));
                            } finally {
                              setState(() {
                                loading = false;
                              });
                            }
                          } else {
                            Scaffold.of(context).showSnackBar(SnackBar(
                              content:
                                  Text(AppLocalizations.of(context).invalidOtp),
                            ));
                          }
                        },
                        label: AppLocalizations.of(context).verify,
                        loading: loading,
                      ),
                    ),
                    UIHelper.verticalSpaceLarge(),
                    Text(
                      '00:${_counter.toString().padLeft(2, "0")}',
                      style: Theme.of(context)
                          .textTheme
                          .headline6
                          .copyWith(fontWeight: FontWeight.w400),
                      textAlign: TextAlign.center,
                    ),
                    UIHelper.verticalSpaceMedium(),
                    GestureDetector(
                      onTap: _counter > 0
                          ? () {}
                          : () async {
                              formData['mobile'] = widget.mobileNumber;
                              formData['password'] = widget.password;
                              formData['id'] = widget.id;
                              _startTimer();
                              try {
                                final id = await Provider.of<AuthProvider>(
                                        context,
                                        listen: false)
                                    .resendOtpCode(formData);
                                if (id != null || id.isEmpty) {
                                  print('send Success');
                                  print(id);
                                } else {
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
                                }
                              } catch (e) {
                                debugPrint(
                                    (e as DioError).response.data.toString());
                                debugPrint("Error Here Catch");
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
                              }
                            },
                      child: Text(
                        AppLocalizations.of(context).resendCode,
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 15.0,
                            color: _counter > 0 ? Colors.grey : Colors.blue),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _pinController.dispose();
    _timer.cancel();
  }
}
