import 'package:flutter/material.dart';
import 'package:adoodlz/helpers/ui/app_colors.dart';
import 'package:adoodlz/helpers/ui/text_styles.dart';

// TODO: Add theme data depending on design
final ThemeData appTheme = ThemeData(
  fontFamily: 'Almarai',
  accentColor: accentColor,
  primaryColor: primaryColor,
  primaryColorLight: Colors.cyan[300],
  secondaryHeaderColor: Colors.black54,
  backgroundColor: backgroundColor,
  cardColor: Colors.white,
  cardTheme: const CardTheme(shadowColor: Colors.black26),
  bottomAppBarColor: Colors.white,
  dividerColor: textColor,
  hintColor: primaryColor,
  disabledColor: Colors.grey,
  scaffoldBackgroundColor: Colors.pink[20],
  iconTheme: IconThemeData(color: textColor.withOpacity(0.45)),
  tabBarTheme: TabBarTheme(
    labelColor: textColor,
    //labelStyle: ,
    unselectedLabelColor: textColor,
    indicator: BoxDecoration(
      color: textColor.withOpacity(0.1),
    ),
  ),
  primaryIconTheme: const IconThemeData(color: Colors.black54),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(),
  appBarTheme: const AppBarTheme(
    elevation: 0,
  ),
  inputDecorationTheme: InputDecorationTheme(
    contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
    enabledBorder: UnderlineInputBorder(
      borderRadius: BorderRadius.zero,
      borderSide: BorderSide(color: textColor.withOpacity(0.5)),
    ),
    border: const UnderlineInputBorder(
      borderRadius: BorderRadius.zero,
    ),
    labelStyle: TextStyle(
      fontSize: 12,
      color: textColor.withOpacity(0.7),
    ),
  ),
  bottomAppBarTheme: const BottomAppBarTheme(color: Colors.white, elevation: 2),
  textTheme: const TextTheme(
    subtitle1: subtitle1,
    subtitle2: subtitle2,
    headline3: headline3,
    headline4: headline4,
    headline5: headline5,
    headline6: headline6,
    
    button: button,
    caption: caption,
  ),
);
