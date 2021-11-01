import 'dart:async';
import 'dart:io';

import 'package:adoodlz/blocs/providers/auth_provider.dart';
import 'package:adoodlz/ui/widgets/avatar_image.dart';
import 'package:adoodlz/ui/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:adoodlz/helpers/ui/ui_helpers.dart';
import 'package:adoodlz/ui/widgets/custom_raised_button.dart';
import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class EditAccountScreen extends StatefulWidget {
  const EditAccountScreen();

  @override
  _EditAccountScreenState createState() => _EditAccountScreenState();
}

class _EditAccountScreenState extends State<EditAccountScreen>
    with SingleTickerProviderStateMixin {
  final GlobalKey<FormState> _editAccountFormkey = GlobalKey<FormState>();

  bool loading;
  Map<String, dynamic> _editAccountInfo;
  AnimationController _editAccountButtonController;
  Animation<double> buttonSqueezeAnimation;

  File image;

  @override
  void initState() {
    _editAccountButtonController = AnimationController(
        duration: const Duration(milliseconds: 300), vsync: this);
    buttonSqueezeAnimation = Tween(
      begin: 320.0,
      end: 70.0,
    ).animate(
      CurvedAnimation(
        parent: _editAccountButtonController,
        curve: Curves.easeIn,
      ),
    );

    _editAccountButtonController.addListener(() {
      setState(() {});
    });

    loading = false;
    _editAccountInfo = {};
    super.initState();
  }

  @override
  void dispose() {
    _editAccountButtonController.dispose();
    _editAccountInfo = {};
    super.dispose();
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
        _editAccountInfo['image'] = imageFile;
        image = File(pickedFile.path);
      });
    } else {
      error = true;
    }
    return error;
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
            AppLocalizations.of(context).editYourData,
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
      body: Builder(
        builder: (context) => SingleChildScrollView(
          child: Column(
            children: [
              if (image == null)
                Align(
                  child: Material(
                    elevation: 5.0,
                    borderRadius: BorderRadius.circular(50.0),
                    color: Theme.of(context).primaryColor,
                    // ignore: sized_box_for_whitespace
                    child: Container(
                      height: 100.0,
                      width: 100.0,
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(70.0),
                          child:
                              Provider.of<AuthProvider>(context, listen: false)
                                          .user
                                          .image !=
                                      null
                                  ? Image.network(
                                      // 'assets/images/user_profile.png',
                                      Provider.of<AuthProvider>(context,
                                              listen: false)
                                          .user
                                          .image,
                                      fit: BoxFit.cover,
                                    )
                                  : Image.asset(
                                      'assets/images/user_profile.png',
                                      fit: BoxFit.cover,
                                    )),
                    ),
                  ),
                )
              else
                Align(
                  child: Material(
                    elevation: 5.0,
                    borderRadius: BorderRadius.circular(50.0),
                    // ignore: sized_box_for_whitespace
                    child: Container(
                      height: 100.0,
                      width: 100.0,
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(70.0),
                          child: Image.file(
                            image,
                            fit: BoxFit.cover,
                          )),
                    ),
                  ),
                ),
              const SizedBox(
                height: 15.0,
              ),
              CustomRaisedButton(
                onPressed: () async {
                  final error = await pickImage();
                  Scaffold.of(context).showSnackBar(SnackBar(
                    content: Text(error
                        ? AppLocalizations.of(context).pictureFailure
                        : AppLocalizations.of(context).pictureSuccess),
                  ));
                },
                label: AppLocalizations.of(context).upload,
                width: 100.0,
                colors: const Color(0xFFDE608F),
              ),
              const SizedBox(
                height: 24,
              ),
              Form(
                key: _editAccountFormkey,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
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
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                            CustomTextFormField(
                              initialValue: Provider.of<AuthProvider>(context,
                                      listen: false)
                                  .user
                                  .name,
                              filledColor: Colors.white,
                              textInputType: TextInputType.name,
                              onSaved: (value) => setState(() {
                                _editAccountInfo['name'] = value;
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
                      const SizedBox(
                        height: 25,
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
                                AppLocalizations.of(context).mobilePhone,
                                style: const TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                            CustomTextFormField(
                              enable: false,
                              initialValue:
                                  '+${Provider.of<AuthProvider>(context, listen: false).user.mobile}',
                              filledColor: Colors.grey.shade100,
                              textInputType: TextInputType.name,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      CustomRaisedButton(
                        onPressed: () async {
                          if (_editAccountFormkey.currentState.validate() &&
                              !loading) {
                            _editAccountButtonController.forward();
                            setState(() {
                              loading = true;
                            });
                            _editAccountFormkey.currentState.save();

                            try {
                              final success = await Provider.of<AuthProvider>(
                                      context,
                                      listen: false)
                                  .editUserData(_editAccountInfo);
                              if (success) {
                                Navigator.of(context).pop();
                              } else {
                                _editAccountButtonController.reverse();
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
                              _editAccountButtonController.reverse();
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

                            Timer(const Duration(milliseconds: 150), () {
                              setState(() {
                                loading = false;
                              });
                            });
                          }
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
            ],
          ),
        ),
      ),
    );
  }
}
