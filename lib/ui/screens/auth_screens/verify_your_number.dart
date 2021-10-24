import 'package:adoodlz/data/remote/apis/auth_api.dart';
import 'package:adoodlz/routes/router.dart';
import 'package:dio/dio.dart';
import 'package:flag/flag.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:adoodlz/helpers/ui/ui_helpers.dart';
import 'package:adoodlz/ui/widgets/custom_raised_button.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:adoodlz/helpers/ui/app_colors.dart';
import 'package:adoodlz/ui/widgets/floating_support_button.dart';
import 'package:provider/provider.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class CreateAccountScreen extends StatefulWidget {
  // ignore: avoid_positional_boolean_parameters
  const CreateAccountScreen(this.resetPassword);

  final bool resetPassword;

  @override
  _CreateAccountScreenState createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen> {
  final GlobalKey<FormState> _createAccountFormKey = GlobalKey<FormState>();

  bool loading;
  String _mobileNumber;
  String _countryCode;

  @override
  void initState() {
    loading = false;
    _mobileNumber = '';
    _countryCode = '';
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
              AppLocalizations.of(context).createAccount,
              style: Theme.of(context).textTheme.headline4,
            ),
            const SizedBox(
              height: 54,
            ),
            Center(child: Image.asset('assets/images/send-otp.png')),
            const SizedBox(
              height: 24,
            ),
            Form(
              key: _createAccountFormKey,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    const SizedBox(
                      height: 16,
                    ),
                    Text(AppLocalizations.of(context).enterMobileNumber,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.headline5),
                    const SizedBox(
                      height: 24,
                    ),
                    Text(AppLocalizations.of(context).weWillSendOtp,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.headline6),
                    const SizedBox(
                      height: 24,
                    ),
                    Row(
                      //  crossAxisAlignment: CrossAxisAlignment.baseline,
                      children: [
                        if (_countryCode.isNotEmpty)
                          ClipRRect(
                            borderRadius: BorderRadius.circular(24.0),
                            child: Flag(
                              _countryCode,
                              height: 48,
                              width: 48,
                            ),
                          ),
                        const SizedBox(
                          width: 8,
                        ),
                        Directionality(
                          textDirection: TextDirection.ltr,
                          child: Flexible(
                            child: IntlPhoneField(
                              // onSaved: (value) => setState(() {
                              //   print(value.countryCode);
                              //   _countryCode = value.countryISOCode;
                              //   _mobileNumber = value.completeNumber;
                              // }),
                              onChanged: (value) => setState(() {
                                _countryCode = value.countryISOCode;
                                _mobileNumber = value.completeNumber;
                                // print("Country Code ${value.countryISOCode}");
                                // print("Complete Number ${value.completeNumber}");
                              }),
                              autoValidate: false,
                              initialCountryCode: 'SA',
                              keyboardType: TextInputType.phone,
                              decoration: InputDecoration(
                                labelText:
                                    AppLocalizations.of(context).mobileNumber,
                                prefixIcon: Icon(LineAwesomeIcons.phone,
                                    size: 16,
                                    color: textColor.withOpacity(0.7)),
                              ),
                              validator: (value) {
                                if (value.length > 12 || value.length < 8) {
                                  return AppLocalizations.of(context)
                                      .invalidPhone;
                                }
                                return null;
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    CustomRaisedButton(
                      onPressed: () async {
                        // print("Country Code in Raised Button $_countryCode");
                        if (_countryCode == 'SA') {
                          if (_createAccountFormKey.currentState.validate() &&
                              !loading) {
                            _createAccountFormKey.currentState.save();
                            setState(() {
                              loading = true;
                            });
                            _mobileNumber = _mobileNumber.trim();
                            if (_mobileNumber.length == 14) {
                              _mobileNumber =
                                  _mobileNumber.replaceFirst('0', '');
                            }
                            debugPrint(_mobileNumber);
                            try {
                              final id = await Provider.of<AuthApi>(context,
                                      listen: false)
                                  //.toString();
                                  .sendOtp(_mobileNumber);
                              if (id != null || id.isEmpty) {
                                Navigator.of(context).pushReplacementNamed(
                                    Routes.verifyAccountScreen,
                                    arguments: <String, dynamic>{
                                      'number': _mobileNumber,
                                      '_id': id,
                                      'resetPassword': widget.resetPassword
                                    });
                                // Navigator.of(context).pushReplacementNamed(
                                //     Routes.signupScreen,
                                //     arguments: <String, dynamic>{
                                //       'mobile': _mobileNumber,
                                //       '_id': id,
                                //       'resetPassword': widget.resetPassword
                                //     });
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
                                        title: Text(AppLocalizations.of(context)
                                            .processFailure),
                                        content: Text(
                                            AppLocalizations.of(context)
                                                .somethingWentWrong),
                                      ));
                            }

                            setState(() {
                              loading = false;
                            });
                          }
                        } else {
                          showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                    title: Text(AppLocalizations.of(context)
                                        .processFailure),
                                    content: Text(AppLocalizations.of(context)
                                        .availableInKSA),
                                  ));
                        }
                      },
                      label: AppLocalizations.of(context).send,
                      loading: loading,
                    ),
                    UIHelper.verticalSpaceMedium(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: SupportButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
    );
  }
}
