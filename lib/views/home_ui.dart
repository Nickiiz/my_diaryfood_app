// ignore_for_file: prefer_const_constructors, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_diaryfood_app/model/diaryfood.dart';
import 'package:my_diaryfood_app/services/call_api.dart';
import 'package:my_diaryfood_app/views/add_diaryfood_ui.dart';

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
      diaryfoodDataList = CallApi.callAPIGetAllDiaryfood();
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
            //แสดงข้อมูลรายการที่ Get มาจาก db ที่ Server ในรูปแบบของ ListView
            Expanded(
              child: FutureBuilder(
                  future: CallApi.callAPIGetAllDiaryfood(),
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
                              leading: Image.network(
                                'http://192.168.1.51/mydiaryapi/images/',
                                fit: BoxFit.cover,
                              ),
                              title: Text(
                                snapshot.data[index].foodShopname,
                              ),
                              subtitle: Text(
                                snapshot.data[index].foodDate,
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
