import 'dart:io';

import 'package:adoodlz/helpers/shared_preferences_keys.dart';
import 'package:connectivity/connectivity.dart';
import 'package:device_info/device_info.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

String deviceId;
Future<List<String>> getDeviceDetails() async {
  String deviceName;
  String deviceVersion;

  final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
  try {
    if (Platform.isAndroid) {
      var build = await deviceInfoPlugin.androidInfo;
      deviceName = build.model;
      deviceVersion = build.version.toString();
      deviceId = build.androidId;
      print('Androidddd IDDDDDDD');
      print(deviceId); //UUID for Android
    } else if (Platform.isIOS) {
      var data = await deviceInfoPlugin.iosInfo;
      deviceName = data.name;
      deviceVersion = data.systemVersion;
      deviceId = data.identifierForVendor; //UUID for iOS
    }
  } on PlatformException {
    print('Failed to get platform version');
  }

//if (!mounted) return;
  return [deviceName, deviceVersion, deviceId];
}

final FirebaseMessaging _fcm = FirebaseMessaging.instance;
Future<void> getTokenFireBasee() async {
  firebasetoken = await _fcm.getToken();
  SharedPreferences pref = await SharedPreferences.getInstance();
  pref.setString(firebasetokenKey, firebasetoken);
  print('------------------------------------------');
  print(pref.getString(firebasetokenKey));
  firebasetoken = pref.getString(firebasetokenKey);

  print(firebasetoken);
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

// Remove sharedprefrencedata

// void removeshared() async {
//   SharedPreferences preferences = await SharedPreferences.getInstance();
//   await preferences.remove(resetPasswordTokenKey);
//   await preferences.remove(resetPasswordIdKey);
//   print(preferences.getString(resetPasswordTokenKey));
// }

Future<String> getCountryName() async {
  LocationPermission permission;
  permission = await Geolocator.checkPermission();
  print(permission);
  Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high);
  debugPrint('location: ${position.latitude}');
  final coordinates = Coordinates(position.latitude, position.longitude);
  final addresses =
      await Geocoder.local.findAddressesFromCoordinates(coordinates);
  final first = addresses.first;
  countryCodeLocation = first.countryName;
  city = first.adminArea ?? '';
  userCoordinates = first.coordinates.toString() ?? '';
  print('/////////////////////////////////////////////');
  print(city);
  print(userCoordinates);
  //print(first.addressLine);
  return first.countryName;
}
