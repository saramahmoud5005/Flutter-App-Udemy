import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_app/modules/counter/counter_screen.dart';
import 'package:flutter_app/modules/login/login_screen.dart';

import 'layout/home_layout.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CounterScreen(),
    );
  }
}

