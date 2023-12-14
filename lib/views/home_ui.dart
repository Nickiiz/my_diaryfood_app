// ignore_for_file: prefer_const_constructors, sort_child_properties_last, prefer_interpolation_to_compose_strings

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_diaryfood_app/model/diaryfood.dart';
import 'package:my_diaryfood_app/services/call_api.dart';
import 'package:my_diaryfood_app/utils/env.dart';
import 'package:my_diaryfood_app/views/add_diaryfood_ui.dart';
import 'package:my_diaryfood_app/views/login_ui.dart';
import 'package:my_diaryfood_app/views/modify_diaryfood_ui.dart';

class HomeUI extends StatefulWidget {
  const HomeUI({super.key});

  @override
  State<HomeUI> createState() => _HomeUIState();
}

class _HomeUIState extends State<HomeUI> {
  //สร้างตัวแปรเก็บข้อมูลที่ได้จากการเรียกใช้ API
  Future<List<Diaryfood>>? diaryfoodDataList;

  //สร้างเมธอดที่เรียกใช้ API
  getAllDiaryfood() {
    setState(() {
      diaryfoodDataList = callApi.callAPIGetAllDiaryfood();
    });
  }

  @override
  void initState() {
    getAllDiaryfood();
    super.initState();
  }

  //อะไรก็ตามที่อยู่ในเมธอด initState จะทำงานทุกครั้งที่หน้าจอเปิดขึ้นมา
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
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LogInUI(),
                  ));
            },
            icon: Icon(Icons.exit_to_app),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddDiaryFoodUI(),
              )).then((value) => getAllDiaryfood());
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        backgroundColor: Colors.green,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
      body: Center(
        child: Column(
          children: [
            Image.asset(
              'assets/images/banner.png',
              fit: BoxFit.cover,
            ),
            //แสดงข้อมูลรายการที่ Get มาจาก db ที่ Server ในรูปแบบของ ListView
            Expanded(
              child: FutureBuilder(
                  future: callApi.callAPIGetAllDiaryfood(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.connectionState == ConnectionState.done &&
                        snapshot.hasData) {
                      //เอาข้อมูลใส่ ListView โดยการตรวจสอบ message
                      if (snapshot.data[0].message == '0') {
                        return Center(
                          child: Text(
                            'ยังไม่มีข้อมูล',
                            style: GoogleFonts.kanit(),
                          ),
                        );
                      } else {
                        return ListView.builder(
                          //นับจำนวนข้อมูลที่จะแสดงใน List
                          itemCount: snapshot.data.length,
                          //layout ของ ListView ที่จะนำข้อมูลมาแสดง
                          itemBuilder: (context, index) {
                            return ListTile(
                              onTap: () {
                                //เอาข้อมูลที่ได้มาจาก server เก็บไว้ในตัวแปร
                                Diaryfood diaryfood = Diaryfood(
                                  foodId: snapshot.data[index].foodId,
                                  foodShopname:
                                      snapshot.data[index].foodShopname,
                                  foodImage: snapshot.data[index].foodImage,
                                  foodPay: snapshot.data[index].foodPay,
                                  foodMeal: snapshot.data[index].foodMeal,
                                  foodDate: snapshot.data[index].foodDate,
                                  foodProvince:
                                      snapshot.data[index].foodProvince,
                                );

                                //เปิดหน้าจอ modify พร้อมกับส่งข้อมูลในตัวแปรไปแสดงด้วย
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ModifyDiaryFoodUI(
                                      diaryfood: diaryfood,
                                    ),
                                  ),
                                ).then((value) => getAllDiaryfood());
                              },
                              leading: ClipOval(
                                child: Image.network(
                                  // Env.domainURL +
                                  //     '/mydiaryapi/images/pic1702281660252.jpg',
                                  Env.domainURL +
                                      '/mydiaryapi/images/' +
                                      snapshot.data[index].foodImage,
                                  fit: BoxFit.cover,
                                  height: 50,
                                  width: 50,
                                ),
                              ),
                              title: Text(
                                snapshot.data[index].foodShopname,
                                style: GoogleFonts.kanit(),
                              ),
                              subtitle: Text(
                                snapshot.data[index].foodDate,
                                style: GoogleFonts.kanit(),
                              ),
                            );
                          },
                        );
                      }
                    } else if (snapshot.hasError) {
                      return Center(
                        child: Text(
                          'ข้อผิดพลาดเกิิดขึ้น',
                          style: GoogleFonts.kanit(),
                        ),
                      );
                    }
                    return Center(
                      child: CircularProgressIndicator(
                        color: Colors.green,
                      ),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
