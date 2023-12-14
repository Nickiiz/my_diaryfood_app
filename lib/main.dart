// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:my_diaryfood_app/views/add_diaryfood_ui.dart';
import 'package:my_diaryfood_app/views/home_ui.dart';
import 'package:my_diaryfood_app/views/login_ui.dart';
import 'package:my_diaryfood_app/views/splash_screen_ui.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreenUI(),
    ),
  );
}
