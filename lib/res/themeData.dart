import 'package:flutter/material.dart';

VisualDensity kVisualDensity = VisualDensity.adaptivePlatformDensity;

ThemeData kLightTheme = ThemeData(
  visualDensity: kVisualDensity,
  brightness: Brightness.light,
  primaryColor: Colors.green[200],
  accentColor: Colors.blue[400],
  scaffoldBackgroundColor: Colors.grey[50],
  focusColor: Colors.blue[400],
  primaryColorBrightness: Brightness.dark,
  textTheme: TextTheme(
    bodyText1: TextStyle(color: Colors.black87, fontSize: 18),
    bodyText2: TextStyle(color: Colors.black87, fontSize: 16),
  ),
  buttonTheme: ButtonThemeData(
    buttonColor: Colors.amber,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20),
    ),
    // padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
  ),
  // dialogTheme: DialogTheme(),
  // iconTheme: IconThemeData(),
  // snackBarTheme: SnackBarThemeData(),
);
