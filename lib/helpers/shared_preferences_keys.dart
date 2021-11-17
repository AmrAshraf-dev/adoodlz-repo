import 'package:adoodlz/blocs/providers/auth_provider.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

const String savedLocaleKey = 'saved_locale';
const String savedTokenDataKey = 'saved_token_data';
const String savedUserKey = 'saved_user';
const String savedShowCoachKey = 'show_coach';
const String resetPasswordTokenKey = 'resetPasswordKey';
const String countryIp = 'country_ip';
const String country = 'country';
const String resetPasswordIdKey = 'RPID-Key';
String whatsappNumber = '';
bool registerStatus;
const String registerStatusKey = 'register_Token_key ';
const String whatsappNumberKey = 'whatsapp_Token_key ';
String version;
String registerVersion;

dynamic userId;
String resetPasswordToken = '';
int resetPasswordId;
dynamic countryCodeLocation;
String userCoordinates;
String city;
String firebasetoken = '';
const String firebasetokenKey = 'firebase_token_key ';

bool forgetPasswordloading = false;

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${this.substring(1)}";
  }
}

void onLoading({@required BuildContext context}) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return Dialog(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircularProgressIndicator(),
            Text("Loading"),
          ],
        ),
      );
    },
  );
  new Future.delayed(new Duration(seconds: 3), () {
    Navigator.pop(context); //pop dialog
  });
}

displayDialog(BuildContext context, image) {
  showGeneralDialog(
    context: context,
    barrierDismissible: false,
    transitionDuration: Duration(milliseconds: 200),
    transitionBuilder: (context, animation, secondaryAnimation, child) {
      return FadeTransition(
        opacity: animation,
        child: ScaleTransition(
          scale: animation,
          child: child,
        ),
      );
    },
    pageBuilder: (
      context,
      animation,
      secondaryAnimation,
    ) {
      return SafeArea(
        child: Material(
          child: Stack(
            alignment: Alignment.topRight,
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                //padding: EdgeInsets.all(20),
                color: Colors.black,
                child: Center(
                  child: Column(
                    // mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Container(
                          child: Image(
                            image: NetworkImage(
                              image.toString(),
                            ),
                            height: MediaQuery.of(context).size.height - 50,
                            width: MediaQuery.of(context).size.width,
                            fit: BoxFit.fitHeight,
                          ),
                        ),
                      ),
                      //   ElevatedButton(
                      //     onPressed: () {
                      //       Navigator.of(context).pop();
                      //     },
                      //     child: Text(
                      //       "DISMISS",
                      //       style: TextStyle(color: Colors.white),
                      //     ),
                      //     style: ButtonStyle(
                      //         backgroundColor:
                      //             MaterialStateProperty.all(Color(0xff39a397))),
                      //   )
                    ],
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(top: 15, right: 15),
                child: IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(
                      Icons.close,
                      color: Colors.white,
                      size: 30,
                    )),
              )
            ],
          ),
        ),
      );
    },
  );
}

// Future<void> getTokenFireBasee() async {
//   final FirebaseMessaging _fcm = FirebaseMessaging.instance;

//   final String test2 = await _fcm.getToken();
//   print('gimyyyyyyyyyy $test2');
//   return test2;
//   // final bool success = await Provider.of<AuthProvider>(context, listen: false)
//   //     .addUserFireBaseToken(test2);
//   // if (success) {
//   //   // ignore: avoid_print
//   //   print('trueee');
//   // } else {
//   //   // ignore: avoid_print
//   //   print('falseeeeeee');
//   // }
// }
