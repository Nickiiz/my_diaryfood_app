// ignore_for_file: prefer_const_constructors, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_diaryfood_app/views/add_diaryfood_ui.dart';

class HomeUI extends StatefulWidget {
  const HomeUI({super.key});

  @override
  State<HomeUI> createState() => _HomeUIState();
}

class _HomeUIState extends State<HomeUI> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[50],
      appBar: AppBar(
        title: Text(
          'My Diary Food',
          style: GoogleFonts.kanit(),
        ),
        centerTitle: true,
        backgroundColor: Colors.green,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddDiaryFoodUI(),
              ));
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        backgroundColor: Colors.green,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: Center(
        child: Column(
          children: [
            Image.asset(
              'assets/images/banner.png',
              fit: BoxFit.cover,
            ),
          ],
        ),
      ),
    );
  }
}
