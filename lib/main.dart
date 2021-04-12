import 'package:flutter/material.dart';
import 'package:todotimer/views/home_screen.dart';
import 'package:todotimer/res/themeData.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: kLightTheme,
      home: HomeScreen(),
    );
  }
}
