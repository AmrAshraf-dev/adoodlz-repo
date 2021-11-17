import 'dart:ui';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PenddingScreen extends StatefulWidget {
  const PenddingScreen({Key key}) : super(key: key);

  @override
  _PenddingScreenState createState() => _PenddingScreenState();
}

class _PenddingScreenState extends State<PenddingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Column(
            children: [
              // ignore: sized_box_for_whitespace
              SizedBox(
                height: MediaQuery.of(context).size.height * .09,
              ),
              Center(
                child: Container(
                    height: MediaQuery.of(context).size.height * .4,
                    child: Image.asset('assets/images/waiting.png')),
              ),
              Center(
                child: Text(
                  AppLocalizations.of(context).waitingMessage,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.black45,
                      fontWeight: FontWeight.w500,
                      fontSize: 18,
                      height: 1.4),
                ),
              ),
              //mom
            ],
          ),
        ),
      ),
    );
  }
}
