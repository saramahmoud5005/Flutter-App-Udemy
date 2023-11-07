import 'package:flutter/material.dart';
import 'package:flutter_app/bmi_result_screen.dart';
import 'package:flutter_app/bmi_screen.dart';
import 'package:flutter_app/home_screen.dart';
import 'package:flutter_app/login_screen.dart';
import 'package:flutter_app/messenger_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BmiResultScreen(),
    );
  }
}

