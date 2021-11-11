import 'package:flutter/material.dart';

const String savedLocaleKey = 'saved_locale';
const String savedTokenDataKey = 'saved_token_data';
const String savedUserKey = 'saved_user';
const String savedShowCoachKey = 'show_coach';
const String resetPasswordTokenKey = 'resetPasswordKey';
const String countryIp = 'country_ip';
const String country = 'country';
const String resetPasswordIdKey = 'RPID-Key';
String whatsappNumber = '';
const String whatsappNumberKey = 'whatsapp_Token_key ';
String version;
String registerVersion;

dynamic userId;
String resetPasswordToken = '';
int resetPasswordId;
dynamic countryCodeLocation;
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
