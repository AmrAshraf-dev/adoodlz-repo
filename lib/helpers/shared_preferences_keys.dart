import 'package:flutter/material.dart';

const String savedLocaleKey = 'saved_locale';
const String savedTokenDataKey = 'saved_token_data';
const String savedUserKey = 'saved_user';
const String savedShowCoachKey = 'show_coach';
const String resetPasswordTokenKey = 'resetPasswordKey';
const String countryIp = 'country_ip';
const String country = 'country';
const String resetPasswordIdKey = 'RPID-Key';

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
        child: new Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            new CircularProgressIndicator(),
            new Text("Loading"),
          ],
        ),
      );
    },
  );
  new Future.delayed(new Duration(seconds: 3), () {
    Navigator.pop(context); //pop dialog
  });
}
