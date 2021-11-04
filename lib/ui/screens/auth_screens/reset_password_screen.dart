import 'dart:async';

import 'package:adoodlz/blocs/providers/auth_provider.dart';
import 'package:adoodlz/data/remote/apis/reset_password_api.dart';
import 'package:adoodlz/feature/change_passwrod/providers/change_password_provider.dart';
import 'package:adoodlz/helpers/shared_preferences_keys.dart';
import 'package:adoodlz/helpers/ui/app_colors.dart';
import 'package:adoodlz/helpers/ui/ui_helpers.dart';
import 'package:adoodlz/ui/widgets/custom_raised_button.dart';
import 'package:adoodlz/ui/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class ResetPasswordScreen extends StatefulWidget {
  @override
  _ResetPasswordScreenState createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen>
    with SingleTickerProviderStateMixin {
  final GlobalKey<FormState> _changePasswordFormKey = GlobalKey<FormState>();
  bool loading;
  AnimationController _changePasswordButtonController;
  Animation<double> buttonSqueezeAnimation;
  String _newPassword;
  String _confirmNewPassword;
  final _newPasswordController = TextEditingController();
  bool obscurePassword;
  bool obscurePassword2;
  bool _autoValidate = false;

  @override
  void initState() {
    _changePasswordButtonController = AnimationController(
        duration: const Duration(milliseconds: 300), vsync: this);
    buttonSqueezeAnimation = Tween(
      begin: 320.0,
      end: 70.0,
    ).animate(
      CurvedAnimation(
        parent: _changePasswordButtonController,
        curve: Curves.easeIn,
      ),
    );

    _changePasswordButtonController.addListener(() {
      setState(() {});
    });
    loading = false;
    obscurePassword = true;
    obscurePassword2 = true;
    super.initState();
  }

  @override
  void dispose() {
    _changePasswordButtonController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100.0,
        elevation: 0.0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        centerTitle: true,
        title: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Text(
            AppLocalizations.of(context).changePassword,
            style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600),
          ),
        ),
        leading: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: IconButton(
              icon: const Icon(
                Icons.arrow_back_ios,
                color: Colors.black,
                size: 20.0,
              ),
              onPressed: () {
                Navigator.pop(context);
              }),
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          autovalidate: _autoValidate,
          key: _changePasswordFormKey,
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              children: [
                /// new password
                Text(
                  AppLocalizations.of(context).changePassword,
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                Container(
                  margin: const EdgeInsets.only(top: 15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(
                            bottom: 5.0, left: 10.0, right: 10.0),
                        child: Text(
                          AppLocalizations.of(context).newPassword,
                          style: const TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      CustomTextFormField(
                        filledColor: Colors.white,
                        //textDirection: TextDirection.ltr,
                        textEditingController: _newPasswordController,
                        maxLines: 1,
                        textInputType: TextInputType.visiblePassword,
                        isPassword: obscurePassword,
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
                        onSaved: (value) {
                          _newPassword = value;
                        },
                        validator: (value) {
                          if (value.isEmpty) {
                            return AppLocalizations.of(context).fieldRequired;
                          } else if (value.length < 6) {
                            return AppLocalizations.of(context).fieldMinimum(6);
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),

                /// confirm new password ]

                Container(
                  margin: const EdgeInsets.only(top: 15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(
                            bottom: 5.0, left: 10.0, right: 10.0),
                        child: Text(
                          AppLocalizations.of(context).confirmPassword,
                          style: const TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      CustomTextFormField(
                        filledColor: Colors.white,
                        maxLines: 1,
                        textInputType: TextInputType.visiblePassword,
                        isPassword: obscurePassword2,
                        suffixIcon: IconButton(
                          icon: Icon(
                            obscurePassword2
                                ? FontAwesomeIcons.eye
                                : FontAwesomeIcons.eyeSlash,
                            color:
                                Theme.of(context).accentColor.withOpacity(0.45),
                          ),
                          onPressed: () {
                            setState(() {
                              obscurePassword2 = !obscurePassword2;
                            });
                          },
                        ),
                        onSaved: (value) {
                          _confirmNewPassword = value;
                        },
                        validator: (value) {
                          if (value.isEmpty) {
                            return AppLocalizations.of(context).fieldRequired;
                          } else if (value.length < 6) {
                            return AppLocalizations.of(context).fieldMinimum(6);
                          } else if (value != _newPasswordController.text) {
                            return AppLocalizations.of(context)
                                .passwordMismatch;
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),

                /// ///////////////////////////////
                const SizedBox(
                  height: 40,
                ),
                CustomRaisedButton(
                  onPressed: () async {
                    ResetPasswordApi reset = ResetPasswordApi();
                    if (_changePasswordFormKey.currentState.validate() &&
                        !loading) {
                      _changePasswordButtonController.forward();
                      setState(() {
                        loading = true;
                      });
                    }
                    _changePasswordFormKey.currentState.save();

                    reset.requestNewPassword(
                        context: context,
                        password: _newPasswordController.text,
                        token: resetPasswordToken);

                    // if (_changePasswordFormKey.currentState.validate() &&
                    //     !loading) {
                    //   _changePasswordButtonController.forward();
                    //   setState(() {
                    //     loading = true;
                    //   });
                    //   _changePasswordFormKey.currentState.save();

                    //   try {
                    //     final userId =
                    //         Provider.of<AuthProvider>(context, listen: false)
                    //             .user
                    //             .id;
                    //     final Map<String, dynamic> formData = {
                    //       'id': userId,
                    //       'password': _newPassword,
                    //     };
                    //     final success =
                    //         await Provider.of<ChangePasswordProvider>(context,
                    //                 listen: false)
                    //             .changePassword(formData);

                    //     print('this result $success');

                    //     if (success) {
                    //       Navigator.of(context).pop();
                    //     } else {
                    //       _changePasswordButtonController.reverse();
                    //       showDialog(
                    //           context: context,
                    //           builder: (context) => AlertDialog(
                    //                 title: Text(AppLocalizations.of(context)
                    //                     .processFailure),
                    //                 content: Text(AppLocalizations.of(context)
                    //                     .somethingWentWrong),
                    //               ));
                    //     }
                    //   } catch (e) {
                    //     _changePasswordButtonController.reverse();
                    //     showDialog(
                    //         context: context,
                    //         builder: (context) => AlertDialog(
                    //               title: Text(AppLocalizations.of(context)
                    //                   .processFailure),
                    //               content: Text(AppLocalizations.of(context)
                    //                   .somethingWentWrong),
                    //             ));
                    //   }

                    //   Timer(const Duration(milliseconds: 150), () {
                    //     setState(() {
                    //       loading = false;
                    //     });
                    //   });
                    // } else {
                    //   setState(() {
                    //     _autoValidate = true;
                    //   });
                    // }
                  },
                  label: AppLocalizations.of(context).confirm,
                  loading: loading,
                  width: buttonSqueezeAnimation.value,
                ),
                UIHelper.verticalSpaceMedium(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
