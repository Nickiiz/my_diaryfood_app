// ignore_for_file: prefer_const_constructors, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class AddDiaryFoodUI extends StatefulWidget {
  const AddDiaryFoodUI({super.key});

  @override
  State<AddDiaryFoodUI> createState() => _AddDiaryFoodUIState();
}

class _AddDiaryFoodUIState extends State<AddDiaryFoodUI> {
  //ตัวแปรใช้กับ GroupValue ของแต่ละ Radio
  int meal = 1;
  //ประกาศ/สร้างตัวแปรเพื่อเก็บข้อมูลรายการที่จะเอาไปใช้กับ DropdownButton
  //items เก็บตัวแปรจังหวัด
  List<DropdownMenuItem<String>> items = [
    'กรุงเทพมหานคร',
    'กระบี่',
    'กาญจนบุรี',
    'กาฬสินธุ์',
    'กำแพงเพชร',
    'ขอนแก่น',
    'จันทบุรี',
    'ฉะเชิงเทรา',
    'ชลบุรี',
    'ชัยนาท',
    'ชัยภูมิ',
    'ชุมพร',
    'เชียงราย',
    'เชียงใหม่',
    'ตรัง',
    'ตราด',
    'ตาก',
    'นครนายก',
    'นครปฐม',
    'นครพนม',
    'นครราชสีมา',
    'นครศรีธรรมราช',
    'นครสวรรค์',
    'นนทบุรี',
    'นราธิวาส',
    'น่าน',
    'บึงกาฬ',
    'บุรีรัมย์',
    'ปทุมธานี',
    'ประจวบคีรีขันธ์',
    'ปราจีนบุรี',
    'ปัตตานี',
    'พระนครศรีอยุธยา',
    'พะเยา',
    'พังงา',
    'พัทลุง',
    'พิจิตร',
    'พิษณุโลก',
    'เพชรบุรี',
    'เพชรบูรณ์',
    'แพร่',
    'ภูเก็ต',
    'มหาสารคาม',
    'มุกดาหาร',
    'แม่ฮ่องสอน',
    'ยโสธร',
    'ยะลา',
    'ร้อยเอ็ด',
    'ระนอง',
    'ระยอง',
    'ราชบุรี',
    'ลพบุรี',
    'ลำปาง',
    'ลำพูน',
    'เลย',
    'ศรีสะเกษ',
    'สกลนคร',
    'สงขลา',
    'สตูล',
    'สมุทรปราการ',
    'สมุทรสงคราม',
    'สมุทรสาคร',
    'สระแก้ว',
    'สระบุรี',
    'สิงห์บุรี',
    'สุโขทัย',
    'สุพรรณบุรี',
    'สุราษฎร์ธานี',
    'สุรินทร์',
    'หนองคาย',
    'หนองบัวลำภู',
    'อ่างทอง',
    'อำนาจเจริญ',
    'อุดรธานี',
    'อุตรดิตถ์',
    'อุทัยธานี',
    'อุบลราชธานี'
  ]
      .map((e) => DropdownMenuItem<String>(
            value: e,
            child: Text(e),
          ))
      .toList();
  //ตัวแปร foodProvine เก็บตัวแปรจังหวัดที่ User เลือก
  String foodProvine = 'กรุงเทพมหานคร';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[50],
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text(
          'เพิ่มข้อมูล My Diary Food',
          style: GoogleFonts.kanit(),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios_new,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(
          left: MediaQuery.of(context).size.width * 0.1,
          right: MediaQuery.of(context).size.width * 0.1,
        ),
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.width * 0.075,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.5,
                      height: MediaQuery.of(context).size.width * 0.5,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(width: 4, color: Colors.green),
                        image: DecorationImage(
                            image: AssetImage(
                              'assets/images/banner.png',
                            ),
                            fit: BoxFit.cover),
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.camera_alt_rounded,
                        color: Colors.green,
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.width * 0.045,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'ร้านอาหาร',
                    style: GoogleFonts.kanit(
                        color: Colors.grey[800],
                        fontSize: MediaQuery.of(context).size.height * 0.02),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.width * 0.02,
                    bottom: MediaQuery.of(context).size.width * 0.025,
                  ),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'ป้อนชื่อร้านอาหารด้วย',
                      hintStyle: GoogleFonts.kanit(),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.green),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.green),
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'ค่าใช้จ่าย',
                    style: GoogleFonts.kanit(
                        color: Colors.grey[800],
                        fontSize: MediaQuery.of(context).size.height * 0.02),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.width * 0.02,
                    bottom: MediaQuery.of(context).size.width * 0.025,
                  ),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'ป้อนค่าใช้จ่าย',
                      hintStyle: GoogleFonts.kanit(),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.green),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.green),
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'อาหารมื้อ',
                    style: GoogleFonts.kanit(
                        color: Colors.grey[800],
                        fontSize: MediaQuery.of(context).size.height * 0.02),
                  ),
                ),
                Row(
                  children: [
                    Radio(
                      activeColor: Colors.green,
                      onChanged: (int? value) {
                        setState(() {
                          meal = value!;
                        });
                      },
                      value: 1,
                      groupValue: meal,
                    ),
                    Text(
                      'เช้า',
                      style: GoogleFonts.kanit(),
                    ),
                    Radio(
                      activeColor: Colors.green,
                      onChanged: (int? value) {
                        setState(() {
                          meal = value!;
                        });
                      },
                      value: 2,
                      groupValue: meal,
                    ),
                    Text(
                      'กลางวัน',
                      style: GoogleFonts.kanit(),
                    ),
                    Radio(
                      activeColor: Colors.green,
                      onChanged: (int? value) {
                        setState(() {
                          meal = value!;
                        });
                      },
                      value: 3,
                      groupValue: meal,
                    ),
                    Text(
                      'เย็น',
                      style: GoogleFonts.kanit(),
                    ),
                    Radio(
                      activeColor: Colors.green,
                      onChanged: (int? value) {
                        setState(() {
                          meal = value!;
                        });
                      },
                      value: 4,
                      groupValue: meal,
                    ),
                    Text(
                      'ว่าง',
                      style: GoogleFonts.kanit(),
                    ),
                  ],
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 10),
                    child: Text(
                      'วันที่กิน',
                      style: GoogleFonts.kanit(
                          color: Colors.grey[800],
                          fontSize: MediaQuery.of(context).size.height * 0.02),
                    ),
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(right: 15),
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: 'เลือกวันที่ด้วย',
                            hintStyle: GoogleFonts.kanit(),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.green),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.green),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Icon(
                      Icons.calendar_month,
                      color: Colors.green,
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'จังหวัด',
                      style: GoogleFonts.kanit(
                          color: Colors.grey[800],
                          fontSize: MediaQuery.of(context).size.height * 0.02),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: 15,
                  ),
                  child: Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.green),
                    ),
                    child: DropdownButton(
                      isExpanded: true,
                      items: items,
                      onChanged: (String? value) {
                        setState(() {
                          foodProvine = value!;
                        });
                      },
                      value: foodProvine,
                      style: GoogleFonts.kanit(
                          color: Colors.grey[800],
                          fontSize: MediaQuery.of(context).size.height * 0.02),
                      underline: SizedBox(),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'ตำแหน่งที่ตั้ง',
                      style: GoogleFonts.kanit(
                          color: Colors.grey[800],
                          fontSize: MediaQuery.of(context).size.height * 0.02),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.02,
                  ),
                  child: Container(
                    height: MediaQuery.of(context).size.width * 0.55,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.green,
                      ),
                    ),
                    child: GoogleMap(
                      initialCameraPosition: CameraPosition(
                        target: LatLng(0.0, 0.0),
                        zoom: 12.0,
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                      onPressed: () {},
                      child: Text(
                        'บันทึกการกิน',
                        style: GoogleFonts.kanit(),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      child: Text(
                        'ยกเลิก',
                        style: GoogleFonts.kanit(),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red[400],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
