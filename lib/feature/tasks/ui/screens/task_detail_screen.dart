import 'dart:async';
import 'dart:io';
import 'package:adoodlz/blocs/providers/auth_provider.dart';
import 'package:adoodlz/feature/tasks/data/models/field_setting_model.dart';
import 'package:adoodlz/feature/tasks/data/models/task_model.dart';
import 'package:adoodlz/feature/tasks/providers/task_provider.dart';
import 'package:adoodlz/feature/tasks/ui/screens/tasks_screen.dart';
import 'package:adoodlz/helpers/shared_preferences_keys.dart';
import 'package:adoodlz/ui/screens/home_screen/home_screen.dart';
import 'package:adoodlz/ui/screens/task_example.dart';
import 'package:adoodlz/ui/widgets/success_dialog.dart';
import 'package:linkable/linkable.dart';
import 'package:path/path.dart';
import 'package:adoodlz/ui/widgets/custom_raised_button.dart';
import 'package:adoodlz/ui/widgets/custom_text_form_field.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:validators/validators.dart' as validator;
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TaskDetailScreen extends StatefulWidget {
  final TaskModel task;

  const TaskDetailScreen({Key key, this.task}) : super(key: key);

  @override
  _TaskDetailScreenState createState() => _TaskDetailScreenState();
}

class _TaskDetailScreenState extends State<TaskDetailScreen> {
  final GlobalKey<FormState> _taskDetailFormKey = GlobalKey<FormState>();
  final List<Map<String, dynamic>> _listOfFields = [];
  Map<String, dynamic> _taskInfo = {};
  MultipartFile _multipartFile;
  bool _autoValidate = false;
  var userName;
  bool loading;

  String text;

  File image;
  String picName;

  String firstHalf;
  String secondHalf;
  String example;
  bool flag = true;

  FieldSettingModel userFieldSetting;
  FieldSettingModel refFieldSetting;
  FieldSettingModel smFieldSetting;
  FieldSettingModel noteFieldSetting;
  FieldSettingModel imageFieldSetting;

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
        _listOfFields.add({'field_id': 'image', 'value': 'image'});
        _multipartFile = imageFile;
        print(_listOfFields.toString());
        image = File(pickedFile.path);
        picName = basename(pickedFile.path);
      });
    } else {
      error = true;
    }
    return error;
  }

  @override
  void initState() {
    super.initState();
    loading = false;
  }

  @override
  Widget build(BuildContext context) {
    example = widget.task.example;
    text = AppLocalizations.of(context).localeName == 'ar'
        ? widget.task.content.ar.description
        : widget.task.content.en.description;
    if (text.length > 100) {
      firstHalf = text.substring(0, 100);
      secondHalf = text.substring(100, text.length);
    } else {
      firstHalf = text;
      secondHalf = "";
    }

    if (AppLocalizations.of(context).localeName == 'ar') {
      userFieldSetting = widget.task.content.ar.fieldSetting.firstWhere(
          (element) => 'username' == element.fieldId,
          orElse: () => null);
      refFieldSetting = widget.task.content.ar.fieldSetting.firstWhere(
          (element) => 'refernce' == element.fieldId,
          orElse: () => null);
      smFieldSetting = widget.task.content.ar.fieldSetting
          .firstWhere((element) => 'sm' == element.fieldId, orElse: () => null);
      noteFieldSetting = widget.task.content.ar.fieldSetting.firstWhere(
          (element) => 'note' == element.fieldId,
          orElse: () => null);
      imageFieldSetting = widget.task.content.ar.fieldSetting.firstWhere(
          (element) => 'image' == element.fieldId,
          orElse: () => null);
    } else if (AppLocalizations.of(context).localeName == 'en') {
      userFieldSetting = widget.task.content.en.fieldSetting.firstWhere(
          (element) => 'username' == element.fieldId,
          orElse: () => null);
      refFieldSetting = widget.task.content.en.fieldSetting.firstWhere(
          (element) => 'refernce' == element.fieldId,
          orElse: () => null);
      smFieldSetting = widget.task.content.en.fieldSetting
          .firstWhere((element) => 'sm' == element.fieldId, orElse: () => null);
      noteFieldSetting = widget.task.content.en.fieldSetting.firstWhere(
          (element) => 'note' == element.fieldId,
          orElse: () => null);
      imageFieldSetting = widget.task.content.en.fieldSetting.firstWhere(
          (element) => 'image' == element.fieldId,
          orElse: () => null);
    }

    return Scaffold(
        appBar: AppBar(
          title: Text(AppLocalizations.of(context).localeName == 'ar'
              ? widget.task.content.ar.title
              : widget.task.content.en.title),
          elevation: 0.0,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          centerTitle: true,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              size: 20.0,
              color: Colors.black,
            ),
          ),
        ),
        body: Builder(
          builder: (context) => SingleChildScrollView(
            child: Container(
              margin:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
              child: Form(
                autovalidate: _autoValidate,
                key: _taskDetailFormKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppLocalizations.of(context).description,
                      style: const TextStyle(
                          fontSize: 20.0, fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    if (secondHalf.isEmpty)
                      Linkable(text: firstHalf)
                    else
                      Wrap(
                        children: <Widget>[
                          // Linkable(
                          //   text: flag
                          //       ? ("$firstHalf...")
                          //       : (firstHalf + secondHalf),
                          // ),
                          Linkable(
                            text: (firstHalf + secondHalf),
                          ),

                          Center(
                            child: CustomRaisedButton(
                                width: 90,
                                height: 35,
                                colors: const Color(0xFFDE608F),
                                onPressed: () {
                                  // Navigator.push(
                                  //   context,
                                  //   MaterialPageRoute(
                                  //     builder: (builder) => ExampleScreen(
                                  //       image: example,
                                  //     ),
                                  //   ),
                                  // );
                                  displayDialog(context, example);
                                },
                                label:
                                    AppLocalizations.of(context).taskExample),
                          ) // InkWell(
                          //   onTap: () {
                          //     setState(() {
                          //       flag = !flag;
                          //     });
                          //   },
                          //   child: Row(
                          //     mainAxisAlignment: MainAxisAlignment.end,
                          //     children: <Widget>[
                          //       Text(
                          //         flag
                          //             ? AppLocalizations.of(context).showMore
                          //             : AppLocalizations.of(context).showLess,
                          //         style: const TextStyle(color: Colors.red),
                          //       ),
                          //     ],
                          //   ),
                          // ),
                        ],
                      ),
                    if (userFieldSetting != null)
                      if (userFieldSetting.status == 'mandatory' ||
                          userFieldSetting.status == 'optional')
                        Container(
                          margin: const EdgeInsets.only(top: 15.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: const EdgeInsets.only(
                                    bottom: 5.0, left: 10.0, right: 10.0),
                                child: Text(
                                  AppLocalizations.of(context).localeName ==
                                          'ar'
                                      ? userFieldSetting.name
                                      : userFieldSetting.name,
                                  style: const TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                              CustomTextFormField(
                                hintStyle: const TextStyle(color: Colors.grey),
                                hintText:
                                    AppLocalizations.of(context).localeName ==
                                            'ar'
                                        ? userFieldSetting.info
                                        : userFieldSetting.info,
                                filledColor: Colors.white,
                                textInputType: TextInputType.name,
                                onSaved: (value) => setState(() {
                                  userName = value;

                                  _listOfFields.add(
                                      {'field_id': 'username', 'value': value});
                                }),
                                validator: (value) {
                                  // ignore: unnecessary_parenthesis
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

                    /// /////////////////////////
                    if (refFieldSetting != null)
                      if (refFieldSetting.status == 'mandatory' ||
                          refFieldSetting.status == 'optional')
                        Container(
                          margin: const EdgeInsets.only(top: 15.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: const EdgeInsets.only(
                                    bottom: 5.0, left: 10.0, right: 10.0),
                                child: Text(
                                  AppLocalizations.of(context).localeName ==
                                          'ar'
                                      ? refFieldSetting.name
                                      : refFieldSetting.name,
                                  style: const TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                              CustomTextFormField(
                                hintStyle: const TextStyle(color: Colors.grey),
                                hintText:
                                    AppLocalizations.of(context).localeName ==
                                            'ar'
                                        ? refFieldSetting.info
                                        : refFieldSetting.info,
                                filledColor: Colors.white,
                                textInputType: TextInputType.url,
                                onSaved: (value) => setState(() {
                                  _listOfFields.add({
                                    'field_id': 'reference',
                                    'value': value
                                  });
                                }),
                                validator: (value) {
                                  // ignore: unnecessary_parenthesis
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

                    /// ////////////////////////

                    if (smFieldSetting != null)
                      if (smFieldSetting.status == 'mandatory' ||
                          smFieldSetting.status == 'optional')
                        Container(
                          margin: const EdgeInsets.only(top: 15.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: const EdgeInsets.only(
                                    bottom: 5.0, left: 10.0, right: 10.0),
                                child: Text(
                                  AppLocalizations.of(context).localeName ==
                                          'ar'
                                      ? smFieldSetting.name
                                      : smFieldSetting.name,
                                  style: const TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                              CustomTextFormField(
                                hintStyle: const TextStyle(color: Colors.grey),
                                hintText:
                                    AppLocalizations.of(context).localeName ==
                                            'ar'
                                        ? smFieldSetting.info
                                        : smFieldSetting.info,
                                filledColor: Colors.white,
                                textInputType: TextInputType.url,
                                onSaved: (value) => setState(() {
                                  _listOfFields
                                      .add({'field_id': 'sm', 'value': value});
                                }),
                                validator: (value) {
                                  // ignore: unnecessary_parenthesis
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

                    /// /////////
                    if (noteFieldSetting != null)
                      if (noteFieldSetting.status == 'mandatory' ||
                          noteFieldSetting.status == 'optional')
                        Container(
                          margin: const EdgeInsets.only(top: 15.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: const EdgeInsets.only(
                                    bottom: 5.0, left: 10.0, right: 10.0),
                                child: Text(
                                  AppLocalizations.of(context).localeName ==
                                          'ar'
                                      ? noteFieldSetting.name
                                      : noteFieldSetting.name,
                                  style: const TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                              CustomTextFormField(
                                hintStyle: const TextStyle(color: Colors.grey),
                                hintText:
                                    AppLocalizations.of(context).localeName ==
                                            'ar'
                                        ? noteFieldSetting.info
                                        : noteFieldSetting.info,
                                filledColor: Colors.white,
                                textInputType: TextInputType.text,
                                onSaved: (value) => setState(() {
                                  _listOfFields.add(
                                      {'field_id': 'note', 'value': value});
                                }),
                                validator: (value) {
                                  // ignore: unnecessary_parenthesis
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
                      height: 20.0,
                    ),

                    /// /////////////////////
                    if (imageFieldSetting != null)
                      if (imageFieldSetting.status == 'mandatory' ||
                          imageFieldSetting.status == 'optional')
                        Container(
                          margin: const EdgeInsets.only(top: 15.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: const EdgeInsets.only(
                                    bottom: 5.0, left: 10.0, right: 10.0),
                                child: Text(
                                  AppLocalizations.of(context).localeName ==
                                          'ar'
                                      ? imageFieldSetting.name
                                      : imageFieldSetting.name,
                                  style: const TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: Container(
                                      height: 45,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: AppLocalizations.of(
                                                        context)
                                                    .localeName ==
                                                'ar'
                                            ? const BorderRadius.only(
                                                bottomRight: Radius.circular(5),
                                                topRight: Radius.circular(5),
                                              )
                                            : const BorderRadius.only(
                                                bottomLeft: Radius.circular(5),
                                                topLeft: Radius.circular(5)),
                                        border: Border.all(
                                            color: const Color(0xFF707070)),
                                      ),
                                      child: Container(
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 5, vertical: 12.0),
                                        child: ListView(
                                          scrollDirection: Axis.horizontal,
                                          children: [
                                            Text(
                                              picName ??
                                                  (AppLocalizations.of(context)
                                                              .localeName ==
                                                          'ar'
                                                      ? imageFieldSetting.info
                                                      : imageFieldSetting.info),
                                              style: TextStyle(
                                                fontSize: 13.0,
                                                color: Colors.grey[700],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  CustomRaisedButton(
                                    colors: const Color(0xFFDE608F),
                                    onPressed: () async {
                                      //_multipartFile = null;
                                      final error = await pickImage();
                                      Scaffold.of(context)
                                          .showSnackBar(SnackBar(
                                        backgroundColor: Colors.green,
                                        content: Text(
                                          error
                                              ? AppLocalizations.of(context)
                                                  .pictureFailure
                                              : AppLocalizations.of(context)
                                                  .pictureSuccess,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                      ));
                                    },
                                    label: AppLocalizations.of(context).upload,
                                    width: 70,
                                    //height: 47,
                                    borderRadius: AppLocalizations.of(context)
                                                .localeName ==
                                            'ar'
                                        ? const BorderRadius.only(
                                            topLeft: Radius.circular(6),
                                            bottomLeft: Radius.circular(6))
                                        : const BorderRadius.only(
                                            topRight: Radius.circular(6),
                                            bottomRight: Radius.circular(6)),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),

                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 40.0),
                      child: CustomRaisedButton(
                        onPressed: () async {
                          if (_taskDetailFormKey.currentState.validate() &&
                              image != null &&
                              !loading) {
                            _taskDetailFormKey.currentState.save();
                            FocusManager.instance.primaryFocus.unfocus();
                            setState(() {
                              loading = true;
                            });
                            print('=====================================');
                            print(userName);
                            _taskInfo = {
                              'userId': Provider.of<AuthProvider>(context,
                                      listen: false)
                                  .user
                                  .id,
                              'taskId': widget.task.id,
                              'username': userName,
                              // 'status': 'pending',
                              // 'createdAt':DateTime.now().toIso8601String(),
                              'image': _multipartFile,
                              'fields': _listOfFields,
                            };

                            try {
                              final finishSubmitTask =
                                  await Provider.of<TaskProvider>(context,
                                          listen: false)
                                      .submitTask(_taskInfo);

                              if (finishSubmitTask) {
                                print('==================================');
                                print(_multipartFile);
                                Timer timer =
                                    Timer(const Duration(seconds: 1), () {
                                  Navigator.of(context, rootNavigator: true)
                                      .pop();
                                  Navigator.pop(context);
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (builder) => HomeScreen(),
                                    ),
                                  );
                                });
                                showDialog(
                                    barrierDismissible: false,
                                    context: context,
                                    builder: (context) {
                                      return const SuccessDialog();
                                    }).then((value) {
                                  // dispose the timer in case something else has triggered the dismiss.
                                  timer?.cancel();
                                  timer = null;
                                });
                              } else {
                                showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    title: Text(AppLocalizations.of(context)
                                        .processFailure),
                                    content: const Text(
                                        "This user already submmited this task with this name ,try with another name"),
                                  ),
                                );
                              }
                            } catch (e) {
                              print(
                                  '=========================================');
                              print((e as DioError).response.data.toString());
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
                          } else {
                            setState(() {
                              _autoValidate = true;
                            });
                            Scaffold.of(context).showSnackBar(SnackBar(
                              content: Text(
                                  AppLocalizations.of(context).fieldsRequired),
                            ));
                          }
                        },
                        loading: loading,
                        label: AppLocalizations.of(context).submitTask,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
