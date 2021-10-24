import 'package:adoodlz/data/remote/apis/auth_api.dart';
import 'package:adoodlz/routes/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:adoodlz/helpers/ui/ui_helpers.dart';
import 'package:adoodlz/ui/widgets/custom_raised_button.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';

class VerifyAccountPage extends StatefulWidget {
  // ignore: avoid_positional_boolean_parameters
  const VerifyAccountPage(this.mobileNumber, this.id, this.resetPassword);
  final String mobileNumber;
  final String id;
  final bool resetPassword;

  @override
  _VerifyAccountPageState createState() => _VerifyAccountPageState();
}

class _VerifyAccountPageState extends State<VerifyAccountPage> {
  final TextEditingController _pinController = TextEditingController();
  bool loading;

  @override
  void initState() {
    loading = false;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 36,
            ),
            Text(
              AppLocalizations.of(context).verifyAccount,
              style: Theme.of(context).textTheme.headline4,
            ),
            const SizedBox(
              height: 84,
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
                      style: Theme.of(context).textTheme.headline5),
                  const SizedBox(
                    height: 24,
                  ),
                  Text(
                      AppLocalizations.of(context)
                          .otpWillBeSent(widget.mobileNumber),
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headline6),
                  const SizedBox(
                    height: 24,
                  ),
                  Directionality(
                    textDirection: TextDirection.ltr,
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Builder(
                        builder: (context) => PinCodeTextField(
                            appContext: context,
                            length: 4,
                            controller: _pinController,
                            pinTheme: PinTheme(
                                selectedColor: Theme.of(context).primaryColor,
                                activeColor: Theme.of(context).primaryColor,
                                inactiveColor: Theme.of(context).accentColor),
                            onChanged: (value) async {
                              if (!loading &&
                                  _pinController.text.isNotEmpty &&
                                  _pinController.text.length == 4) {
                                setState(() {
                                  loading = true;
                                });
                                try {
                                  final success = await Provider.of<AuthApi>(
                                          context,
                                          listen: false)
                                      .verifyOtp(widget.mobileNumber,
                                          _pinController.text);
                                  if (success) {
                                    // Navigator.of(context).pushReplacementNamed(
                                    //     Routes.signupScreen,
                                    //     arguments: {
                                    //       'mobile': widget.mobileNumber,
                                    //       '_id': widget.id,
                                    //       'resetPassword': widget.resetPassword
                                    //     });

                                    Navigator.pop(context);
                                    Navigator.pop(context);
                                    Navigator.pop(context);

                                    // setState(() {});
                                    // Navigator.of(context)
                                    //     .pushReplacementNamed(Routes.homeScreen);
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
                                }

                                setState(() {
                                  loading = false;
                                });
                              } else {
                                Scaffold.of(context).showSnackBar(SnackBar(
                                  content: Text(
                                      AppLocalizations.of(context).invalidOtp),
                                ));
                              }
                            }),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 25,
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
                            final success = await Provider.of<AuthApi>(context,
                                    listen: false)
                                .verifyOtp(widget.mobileNumber, pin);
                            if (success) {
                              // Navigator.of(context).pushReplacementNamed(
                              //     Routes.signupScreen,
                              //     arguments: {
                              //       'mobile': widget.mobileNumber,
                              //       '_id': widget.id,
                              //       'resetPassword': widget.resetPassword
                              //     });

                              Navigator.pop(context);
                              Navigator.pop(context);
                              Navigator.pop(context);

                              // Navigator.of(context)
                              //     .pushReplacementNamed(Routes.getcash);
                            } else {
                              showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                        title: Text(AppLocalizations.of(context)
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
                                      content: Text(AppLocalizations.of(context)
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
                  UIHelper.verticalSpaceMedium(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    // _pinController.dispose();
    super.dispose();
  }
}
