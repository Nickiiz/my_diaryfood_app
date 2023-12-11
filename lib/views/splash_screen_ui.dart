// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_diaryfood_app/utils/gradient_text.dart';
import 'package:my_diaryfood_app/views/home_ui.dart';

class SplashScreenUI extends StatefulWidget {
  const SplashScreenUI({super.key});

  @override
  State<SplashScreenUI> createState() => _SplashScreenUIState();
}

class _SplashScreenUIState extends State<SplashScreenUI> {
  @override
  void initState() {
    Future.delayed(
      Duration(
        seconds: 3,
      ),
      () => Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => HomeUI(),
        ),
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 114, 236, 118),
      body: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  FontAwesomeIcons.bowlFood,
                  size: MediaQuery.of(context).size.width * 0.35,
                  color: Colors.amber,
                ),
                Text(
                  "My Diary Food",
                  style: GoogleFonts.kanit(
                    fontSize: MediaQuery.of(context).size.width * 0.05,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.width * 0.02,
                ),
                Text(
                  "บันทึกการกิน V.1.0",
                  style: GoogleFonts.kanit(
                    fontSize: MediaQuery.of(context).size.width * 0.04,
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.width * 0.05,
                ),
                CircularProgressIndicator(
                  color: Colors.white,
                ),
              ],
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GradientText(
                  "Create By Nickiiz",
                  style: GoogleFonts.kanit(
                    fontSize: MediaQuery.of(context).size.width * 0.06,
                  ),
                  gradient: LinearGradient(colors: [
                    Colors.black,
                    Colors.amber,
                    Colors.green,
                    Colors.pink,
                    Colors.blue,
                  ]),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.03,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
