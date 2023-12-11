//ไฟล์นี้ใช้ในการเรียกใช้ Api ต่างๆ มีทั้งหมด 4 ฟังก์ชั่น

import 'dart:convert';

import 'package:my_diaryfood_app/model/diaryfood.dart';
import 'package:http/http.dart' as http;

class CallApi {
//เมธอดเรียกใช้ Api Getall-------------------------------------------
  static Future<List<Diaryfood>> callAPIGetAllDiaryfood() async {
    //เรียกใช้ Api ส่วนที่ 1
    final response = await http.get(
      //ใน Thunder เราใช้Get ในนี้ก็ต้องใช้ Getเหมือนกัน
      Uri.parse('http://192.168.1.51/mydiaryapi/getall'),
      headers: {'Content-Type': 'application/json'},
    );
    //ส่วนที่ 2
    if (response.statusCode == 200) {
      //เอาข้อมูลที่ส่งกลับมาเป็น Json แปลงเป็นข้อมูลที่จะนำมาใช้ในแอป เก็บตัวแปร
      final responseData =
          jsonDecode(response.body); //response.body คือข้อมูล Jasonที่เอามา

      //แปลงข้อมูลให้เป็น List และเก็บในตัวแปร List ในที่นี้คือ diaryfoodDataList
      final diaryfoodDataList = await responseData.map<Diaryfood>((json) {
        return Diaryfood.fromJson(json);
      }).toList();

      //ส่งค่าข้อมูลที่เก็บตัวแปร List กลับไป ณ จุดที่เรียกใช้เมทธอดนี้ เพื่อนำข้อมูลกลับมาใช้งาน
      return diaryfoodDataList;
    } else {
      throw Exception('Faild to fetch data');
    }
  }

//insert update delete จะใช้ทุกอย่างเหมือนกัน จะต่างกันแค่ Uri
//เรียกใช้ Api insert-------------------------------------------
//สร้างตัวแปร Diaryfood diaryfood เพราะเวลาใช้ Insert ต้องส่งข้อมูลไป
  static Future<List<Diaryfood>> callAPIInsertDiaryfood(
      Diaryfood diaryfood) async {
    //เรียกใช้ Api
    final respones = await http.post(
      Uri.parse('http://192.168.1.51/mydiaryapi/insert'),
      body: jsonEncode(diaryfood.toJson()),
      headers: {'Content-Type': 'application/json'},
    );
    if (respones.statusCode == 200) {
      //เอาข้อมูลที่ส่งกลับมาเป็น Json แปลงเป็นข้อมูลที่จะนำมาใช้ในแอป เก็บตัวแปร
      final responseData = jsonDecode(respones.body);

      //ส่งค่ากลับไปที่จุดเรียกใช้เมธอด
      return responseData['message'];
    } else {
      throw Exception('Faild to fetch data');
    }
  }

//เรียกใช้ Api update-------------------------------------------
  static Future<List<Diaryfood>> callAPIUpdateDiaryfood(
      Diaryfood diaryfood) async {
    //เรียกใช้ Api
    final respones = await http.post(
      Uri.parse('http://192.168.1.51/mydiaryapi/update'),
      body: jsonEncode(diaryfood.toJson()),
      headers: {'Content-Type': 'application/json'},
    );
    if (respones.statusCode == 200) {
      //เอาข้อมูลที่ส่งกลับมาเป็น Json แปลงเป็นข้อมูลที่จะนำมาใช้ในแอป เก็บตัวแปร
      final responseData = jsonDecode(respones.body);

      //ส่งค่ากลับไปที่จุดเรียกใช้เมธอด
      return responseData['message'];
    } else {
      throw Exception('Faild to fetch data');
    }
  }

//เรียกใช้ Api delete-------------------------------------------
  static Future<List<Diaryfood>> callAPIDeleteDiaryfood(
      Diaryfood diaryfood) async {
    //เรียกใช้ Api
    final respones = await http.post(
      Uri.parse('http://192.168.1.51/mydiaryapi/delete'),
      body: jsonEncode(diaryfood.toJson()),
      headers: {'Content-Type': 'application/json'},
    );
    if (respones.statusCode == 200) {
      //เอาข้อมูลที่ส่งกลับมาเป็น Json แปลงเป็นข้อมูลที่จะนำมาใช้ในแอป เก็บตัวแปร
      final responseData = jsonDecode(respones.body);

      //ส่งค่ากลับไปที่จุดเรียกใช้เมธอด
      return responseData['message'];
    } else {
      throw Exception('Faild to fetch data');
    }
  }
}
