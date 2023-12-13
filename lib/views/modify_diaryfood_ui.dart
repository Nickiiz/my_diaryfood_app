// ignore_for_file: prefer_const_constructors, prefer_interpolation_to_compose_strings, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:flutter_holo_date_picker/date_picker.dart';
import 'package:flutter_holo_date_picker/i18n/date_picker_i18n.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:my_diaryfood_app/model/diaryfood.dart';
import 'package:my_diaryfood_app/utils/env.dart';

class ModifyDiaryFoodUI extends StatefulWidget {
  //ตัวแปร หรือ object ที่เก็บข้อมูลที่ส่งมาจากหน้า Home ที่ผู้ใช้ได้เลือกรายการที่จะดูเพื่อแก้ไขหรือลบ
  Diaryfood? diaryfood;

  ModifyDiaryFoodUI({super.key, this.diaryfood});

  @override
  State<ModifyDiaryFoodUI> createState() => _ModifyDiaryFoodUIState();
}

class _ModifyDiaryFoodUIState extends State<ModifyDiaryFoodUI> {
  TextEditingController foodShopCtrl = TextEditingController(text: '');
  TextEditingController foodPayCtrl = TextEditingController(text: '');
  TextEditingController foodDateCtrl = TextEditingController(text: '');

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
  String foodProvince = 'กรุงเทพมหานคร';

  @override
  void initState() {
    foodShopCtrl.text = widget.diaryfood!.foodShopname!;
    foodPayCtrl.text = widget.diaryfood!.foodPay!;
    meal = int.parse(widget.diaryfood!.foodMeal!);
    foodDateCtrl.text = widget.diaryfood!.foodDate!;
    foodProvince = widget.diaryfood!.foodProvince!;
    super.initState();
  }

  showCalendar() async {
    DateTime? foodDatePicker = await DatePicker.showSimpleDatePicker(context,
        initialDate: DateTime(
          DateTime.now().year,
          DateTime.now().month,
          DateTime.now().day,
        ),
        firstDate: DateTime(1900),
        lastDate: DateTime(2100),
        dateFormat: 'dd MMMM yyyy',
        locale: DateTimePickerLocale.th,
        looping: true,
        confirmText: 'ตกลง',
        cancelText: 'ยกเลิก',
        titleText: 'เลือกวันที่กิน',
        itemTextStyle: GoogleFonts.kanit(),
        textColor: Colors.green);

    //ทำให้เลือกวันที่แล้วจะมาแสดงที่ Textfild (แต่ยังแสดงค่าที่เป็น Standart อยู่ ต้องสร้างเมธอดแปลงวันที่)
    setState(() {
      foodDateCtrl.text = foodDatePicker != null
          ? ConvertToThaiDate(foodDatePicker)
          : foodDateCtrl.text;
    });
  }

  //เมธอดแปลงวันที่ต่อจาก setState ข้างบน จะทำจาก (ปี เดือน วัน)เป็น(วัน เดือน ปี)
  ConvertToThaiDate(date) {
    String day = date.toString().substring(8, 10);
    String year = (int.parse(date.toString().substring(0, 4)) + 543).toString();
    String month = '';
    int monthTemp = int.parse(date.toString().substring(5, 7));
    switch (monthTemp) {
      case 1:
        month = 'มกราคม';
        break;
      case 2:
        month = 'กุมภาพันธ์';
        break;
      case 3:
        month = 'มีนาคม';
        break;
      case 4:
        month = 'เมษายน';
        break;
      case 5:
        month = 'พฤษภาคม';
        break;
      case 6:
        month = 'มิถุนายน';
        break;
      case 7:
        month = 'กรกฎาคม';
        break;
      case 8:
        month = 'สิงหาคาม';
        break;
      case 9:
        month = 'กันยายน';
        break;
      case 10:
        month = 'ตุลาคม';
        break;
      case 11:
        month = 'พฤศจิกายน';
        break;
      default:
        month = 'ธันวาคม';
    }
    return day + '  ' + month + year;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[50],
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text(
          'แก้ไข-ลบ ข้อมูล My Diary Food',
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
                          image: NetworkImage(Env.domainURL +
                              'mydiaryapi/images/' +
                              widget.diaryfood!.foodImage!),
                          fit: BoxFit.cover),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (context) => Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ListTile(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              leading: Icon(
                                Icons.camera_alt,
                                color: Colors.red,
                              ),
                              title: Text(
                                'Open Camera...',
                              ),
                            ),
                            Divider(
                              color: Colors.grey,
                              height: 5.0,
                            ),
                            ListTile(
                              onTap: () {},
                              leading: Icon(
                                Icons.browse_gallery,
                                color: Colors.blue,
                              ),
                              title: Text(
                                'Open Gallery...',
                              ),
                            ),
                          ],
                        ),
                      );
                    },
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
                  controller: foodShopCtrl,
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
                  controller: foodPayCtrl,
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
                        controller: foodDateCtrl,
                        enabled: false,
                        decoration: InputDecoration(
                          hintText: 'เลือกวันที่ด้วย',
                          hintStyle: GoogleFonts.kanit(color: Colors.grey[400]),
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
                  IconButton(
                    onPressed: () {
                      showCalendar();
                    },
                    icon: Icon(
                      Icons.calendar_month,
                      color: Colors.green,
                    ),
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
                        foodProvince = value!;
                      });
                    },
                    value: foodProvince,
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
                    onPressed: () {
                      //validate หน้าจอก่อนส่งข้อมูลไปบันทึกเก็บไว้ที่ Server
                    },
                    child: Text(
                      'แก้ไขการกิน',
                      style: GoogleFonts.kanit(),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    child: Text(
                      'ลบ',
                      style: GoogleFonts.kanit(),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red[400],
                    ),
                  ),
                ],
              ),
            ],
          )),
        ),
      ),
    );
  }
}
