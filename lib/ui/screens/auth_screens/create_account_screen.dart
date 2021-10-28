import 'dart:io';
import 'package:adoodlz/blocs/providers/auth_provider.dart';
import 'package:adoodlz/blocs/providers/change_ip_country_provider.dart';
import 'package:adoodlz/data/remote/constants/endpoints.dart' as endpoints;

import 'package:adoodlz/routes/router.dart';
import 'package:adoodlz/ui/widgets/custom_raised_button.dart';
import 'package:adoodlz/ui/widgets/custom_text_form_field.dart';
import 'package:adoodlz/ui/widgets/picked_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:validators/validators.dart' as validator;

class CreateAccountScreen extends StatefulWidget {
  // ignore: avoid_positional_boolean_parameters
  const CreateAccountScreen(this.resetPassword);

  final bool resetPassword;

  @override
  _CreateAccountScreenState createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen> {
  OutlineInputBorder outLineBorder = const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(5.0)),
      borderSide: BorderSide(width: 0.2, color: Colors.black));

  final GlobalKey<FormState> _signupFormKey = GlobalKey<FormState>();
  bool obscurePassword;
  bool obscurePassword2;
  bool _autoValidate = false;
  bool agree = false;
  bool loading;
  Map<String, dynamic> _signupInfo;
  File image;
  final _passwordController = TextEditingController();
  String _countryCode;

  @override
  void initState() {
    loading = false;
    _signupInfo = {};
    _countryCode = '';
    obscurePassword = true;
    obscurePassword2 = true;

    super.initState();
  }

  Future<bool> pickImage() async {
    final picker = ImagePicker();
    bool error = false;
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      final String fileName = pickedFile.path.split('/').last;

      final imageFile = await MultipartFile.fromFile(pickedFile.path,
          filename: fileName,
          contentType: MediaType('image', fileName.split('.').last));
      setState(() {
        _signupInfo['image'] = imageFile;
        image = File(pickedFile.path);
      });
    } else {
      error = true;
    }
    return error;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: Builder(
          builder: (context) => SingleChildScrollView(
            child: Container(
              width: MediaQuery.of(context).size.width,
              margin:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 50.0),
              child: Form(
                key: _signupFormKey,
                autovalidate: _autoValidate,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    IconButton(
                      icon: const Icon(
                        Icons.arrow_back_ios,
                        color: Colors.black,
                        size: 24.0,
                      ),
                      onPressed: () {
                        Navigator.of(context).pushReplacementNamed(
                          Routes.signinScreen0,
                        );
                      },
                    ),
                    if (image == null)
                      Align(
                        child: Material(
                          elevation: 5.0,
                          borderRadius: BorderRadius.circular(50.0),
                          child: GestureDetector(
                            onTap: () async {
                              final error = await pickImage();
                              Scaffold.of(context).showSnackBar(SnackBar(
                                content: Text(error
                                    ? AppLocalizations.of(context)
                                        .pictureFailure
                                    : AppLocalizations.of(context)
                                        .pictureSuccess),
                              ));
                            },
                            child: Container(
                              alignment: Alignment.center,
                              height: 100.0,
                              width: 100.0,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(70.0),
                                color: Colors.grey,
                              ),
                              child: const Icon(
                                Icons.camera_alt_outlined,
                                color: Colors.white,
                                size: 30.0,
                              ),
                            ),
                          ),
                        ),
                      )
                    else
                      Align(
                        child: PickedImage(
                          file: image,
                          onPressed: () async {
                            final error = await pickImage();
                            Scaffold.of(context).showSnackBar(SnackBar(
                              content: Text(error
                                  ? AppLocalizations.of(context).pictureFailure
                                  : AppLocalizations.of(context)
                                      .pictureSuccess),
                            ));
                          },
                        ),
                      ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 15.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(
                                bottom: 5.0, left: 10.0, right: 10.0),
                            child: Text(
                              AppLocalizations.of(context).userName,
                              style: const TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                          CustomTextFormField(
                            textInputType: TextInputType.name,
                            onSaved: (value) => setState(() {
                              _signupInfo['name'] = value;
                            }),
                            validator: (value) {
                              if (value.isEmpty) {
                                return AppLocalizations.of(context)
                                    .fieldRequired;
                              } else if (value.length < 4) {
                                return AppLocalizations.of(context)
                                    .fieldMinimum(4);
                              }
                              return null;
                            },
                          ),
                        ],
                      ),
                    ),
                    // Container(
                    //   margin: const EdgeInsets.only(top: 15.0),
                    //   child: Column(
                    //     crossAxisAlignment: CrossAxisAlignment.start,
                    //     children: [
                    //       Container(
                    //         margin: const EdgeInsets.only(
                    //             bottom: 5.0, left: 10.0, right: 10.0),
                    //         child: Text(
                    //           AppLocalizations.of(context).eMail,
                    //           style: const TextStyle(
                    //             fontSize: 16.0,
                    //             fontWeight: FontWeight.w400,
                    //           ),
                    //         ),
                    //       ),
                    //       CustomTextFormField(
                    //         textInputType: TextInputType.emailAddress,
                    //         onSaved: (value) => setState(() {
                    //           _signupInfo['email'] = value;
                    //         }),
                    //         validator: (value) {
                    //           // ignore: unnecessary_parenthesis
                    //           if (value.isEmpty ||
                    //               !(validator.isEmail(value))) {
                    //             return AppLocalizations.of(context)
                    //                 .fieldRequired;
                    //           } else if (value.length < 4) {
                    //             return AppLocalizations.of(context)
                    //                 .fieldMinimum(4);
                    //           }
                    //           return null;
                    //         },
                    //       ),
                    //     ],
                    //   ),
                    // ),
                    Container(
                      margin: const EdgeInsets.only(top: 15.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(
                                bottom: 5.0, left: 10.0, right: 10.0),
                            child: Text(
                              AppLocalizations.of(context).mobilePhone,
                              style: const TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                          Directionality(
                            textDirection: TextDirection.ltr,
                            child: IntlPhoneField(
                              onSaved: (value) => setState(() {
                                _signupInfo['mobile'] = value.completeNumber;
                              }),
                              onChanged: (value) => setState(() {
                                _countryCode = value.countryISOCode;
                                // print("Country Code ${value.countryISOCode}");
                                // print("Complete Number ${value.completeNumber}");
                              }),
                              initialCountryCode: 'EG',
                              autoValidate: false,
                              style: const TextStyle(
                                fontSize: 22,
                                color: Colors.black,
                              ),
                              decoration: InputDecoration(
                                hintText: '1xxxxxxxxx',
                                hintStyle:
                                    TextStyle(color: Colors.grey.shade300),
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
                                  return AppLocalizations.of(context)
                                      .invalidPhone;
                                }
                                return null;
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Container(
                    //   margin: const EdgeInsets.only(top: 15.0),
                    //   child: Column(
                    //     crossAxisAlignment: CrossAxisAlignment.start,
                    //     children: [
                    //       Container(
                    //         margin: const EdgeInsets.only(
                    //             bottom: 5.0, left: 10.0, right: 10.0),
                    //         child: Text(
                    //           AppLocalizations.of(context).address,
                    //           style: const TextStyle(
                    //             fontSize: 16.0,
                    //             fontWeight: FontWeight.w400,
                    //           ),
                    //         ),
                    //       ),
                    //       CustomTextFormField(
                    //         textInputType: TextInputType.streetAddress,
                    //         onSaved: (value) => setState(() {
                    //           _signupInfo['address'] = value;
                    //         }),
                    //         validator: (value) {
                    //           if (value.isEmpty) {
                    //             return AppLocalizations.of(context)
                    //                 .fieldRequired;
                    //           } else if (value.length < 6) {
                    //             return AppLocalizations.of(context)
                    //                 .fieldMinimum(6);
                    //           }
                    //           return null;
                    //         },
                    //       ),
                    //     ],
                    //   ),
                    // ),
                    Container(
                      margin: const EdgeInsets.only(top: 15.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(
                                bottom: 5.0, left: 10.0, right: 10.0),
                            child: Text(
                              AppLocalizations.of(context).password,
                              style: const TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                          CustomTextFormField(
                            //textDirection: TextDirection.ltr,
                            textEditingController: _passwordController,
                            maxLines: 1,

                            textInputType: TextInputType.visiblePassword,
                            isPassword: obscurePassword,
                            suffixIcon: IconButton(
                              icon: Icon(
                                obscurePassword
                                    ? FontAwesomeIcons.eye
                                    : FontAwesomeIcons.eyeSlash,
                                color: Theme.of(context)
                                    .accentColor
                                    .withOpacity(0.45),
                              ),
                              onPressed: () {
                                setState(() {
                                  obscurePassword = !obscurePassword;
                                });
                              },
                            ),
                            onSaved: (value) => setState(() {
                              _signupInfo['password'] = value;
                            }),
                            validator: (value) {
                              if (value.isEmpty) {
                                return AppLocalizations.of(context)
                                    .fieldRequired;
                              } else if (value.length < 4) {
                                return AppLocalizations.of(context)
                                    .fieldMinimum(4);
                              }
                              return null;
                            },
                          ),
                        ],
                      ),
                    ),
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
                                fontSize: 18.0,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                          CustomTextFormField(
                            maxLines: 1,
                            textInputType: TextInputType.visiblePassword,
                            isPassword: obscurePassword2,
                            suffixIcon: IconButton(
                              icon: Icon(
                                obscurePassword2
                                    ? FontAwesomeIcons.eye
                                    : FontAwesomeIcons.eyeSlash,
                                color: Theme.of(context)
                                    .accentColor
                                    .withOpacity(0.45),
                              ),
                              onPressed: () {
                                setState(() {
                                  obscurePassword2 = !obscurePassword2;
                                });
                              },
                            ),
                            onSaved: (value) => setState(() {
                              _signupInfo['password_confirmation'] = value;
                            }),
                            validator: (value) {
                              if (value.isEmpty) {
                                return AppLocalizations.of(context)
                                    .fieldRequired;
                              } else if (value.length < 4) {
                                return AppLocalizations.of(context)
                                    .fieldMinimum(4);
                              } else if (value != _passwordController.text) {
                                return AppLocalizations.of(context)
                                    .passwordMismatch;
                              }
                              return null;
                            },
                          ),
                        ],
                      ),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Material(
                          child: Checkbox(
                            value: agree,
                            onChanged: (value) {
                              setState(() {
                                agree = value;
                                print(agree);
                              });
                            },
                          ),
                        ),
                        Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: AppLocalizations.of(context).readTerms,
                                style: const TextStyle(color: Colors.grey),
                              ),
                              TextSpan(
                                  text: AppLocalizations.of(context)
                                      .termsAndConditions,
                                  style: const TextStyle(color: Colors.blue),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () => Navigator.of(context)
                                        .pushNamed(Routes.termsScreen)),
                              TextSpan(
                                text:
                                    '\n${AppLocalizations.of(context).agreeTheTerms}',
                                style: const TextStyle(color: Colors.grey),
                              ),
                            ],
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 30.0),
                      child: CustomRaisedButton(
                        onPressed: () async {
                          if (agree) {
                            if (_signupFormKey.currentState.validate() &&
                                !loading) {
                              _signupFormKey.currentState.save();
                              FocusManager.instance.primaryFocus.unfocus();
                              if (_signupInfo['password'] ==
                                  _signupInfo['password_confirmation']) {
                                // if (_countryCode == 'SA') {
                                setState(() {
                                  loading = true;
                                });

                                /// ///////////

                                try {
                                  /// change ip country
                                  if (_countryCode == 'EG') {
                                    await Provider.of<ChangeCountryIpProvider>(
                                            context,
                                            listen: false)
                                        .changeToEgypt();
                                  } else if (_countryCode == 'SA') {
                                    await Provider.of<ChangeCountryIpProvider>(
                                            context,
                                            listen: false)
                                        .changeToSaudi();
                                  } else {
                                    await Provider.of<ChangeCountryIpProvider>(
                                            context,
                                            listen: false)
                                        .changeToSaudi();
                                  }
                                  final id = await Provider.of<AuthProvider>(
                                          context,
                                          listen: false)
                                      //.toString();
                                      .signUpUser(_signupInfo);
                                  if (id != null || id.isEmpty) {
                                    Navigator.of(context).pushReplacementNamed(
                                        Routes.verifyAccountScreen,
                                        arguments: <String, dynamic>{
                                          'number': _signupInfo['mobile'],
                                          'password': _signupInfo['password'],
                                          '_id': id,
                                          'resetPassword': false,
                                        });
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

                                setState(() {
                                  loading = false;
                                });
                                print(
                                    '==========================================');
                                print(
                                    'this is nameeeeeeeeeeeeeeeeee ${_signupInfo['name']}');

                                print(endpoints.generateOtp);
                                print(_signupInfo['email']);
                                print(_signupInfo['mobile']);
                                print(_signupInfo['password']);
                                print(
                                    '==========================================');
                                // } else {
                                //   showDialog(
                                //       context: context,
                                //       builder: (context) => AlertDialog(
                                //             title: Text(
                                //                 AppLocalizations.of(context)
                                //                     .processFailure),
                                //             content: Text(
                                //                 AppLocalizations.of(context)
                                //                     .availableInKSA),
                                //           ));
                                // }
                              } else {
                                setState(() {
                                  loading = false;
                                });
                              }
                            } else {
                              setState(() {
                                _autoValidate = true;
                              });
                            }
                          } else {
                            Scaffold.of(context).showSnackBar(SnackBar(
                              content:
                                  Text(AppLocalizations.of(context).agreeTerms),
                            ));
                          }
                        },
                        loading: loading,
                        label: AppLocalizations.of(context).signupShort,
                        lightFont: true,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushReplacementNamed(
                          Routes.signinScreen0,
                        );
                      },
                      child: Align(
                        child: Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                  text:
                                      AppLocalizations.of(context).haveAccount,
                                  style: const TextStyle(color: Colors.grey)),
                              TextSpan(
                                text: AppLocalizations.of(context).signIn,
                                style: const TextStyle(
                                  color: Colors.blue,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ],
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
