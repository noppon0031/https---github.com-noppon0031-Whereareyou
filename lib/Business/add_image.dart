import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:noppon/Model/place.dart';
import 'package:noppon/dropdown.dart';
import 'package:path/path.dart' as Path;
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';

class AddImage extends StatefulWidget {
  @override
  _AddImageState createState() => _AddImageState();
}

class _AddImageState extends State<AddImage> {
  bool uploading = false;
  double val = 0;
  late CollectionReference imgRef;
  late firebase_storage.Reference ref;
  late TimeOfDay timeopen;

  final business_name_Controller = TextEditingController();
  final business_name1_Controller = TextEditingController();
  final business_name2_Controller = TextEditingController();
  final business_name3_Controller = TextEditingController();
  final business_name_english_Controller = TextEditingController();
  final tel_Controller = TextEditingController();
  final day_Controller = TextEditingController();
  final time_Controller = TextEditingController();
  final price_Controller = TextEditingController();
  final website_Controller = TextEditingController();
  final facebook_Controller = TextEditingController();
  final instagram_Controller = TextEditingController();
  final line_Controller = TextEditingController();
  final email_Controller = TextEditingController();
  final address_Controller = TextEditingController();
  final detail_Controller = TextEditingController();
  final google_map_Controller = TextEditingController();
  final latitude_Controller = TextEditingController();
  final longitude_Controller = TextEditingController();
  final latitude2_Controller = TextEditingController();
  final longitude2_Controller = TextEditingController();
  final longitude3_Controller = TextEditingController();
  final latitude3_Controller = TextEditingController();
  final longitude4_Controller = TextEditingController();
  final latitude4_Controller = TextEditingController();
  final latitude5_Controller = TextEditingController();
  final longitude5_Controller = TextEditingController();
  final check_Controller = TextEditingController();
  final photo_Detaii_Controller = TextEditingController();
  final time_open_Controller = TextEditingController();
  final time_close_Controller = TextEditingController();

  List<File> _image = [];
  List<String> url_image = [];
  final picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    imgRef = FirebaseFirestore.instance.collection('place');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('เพิ่มสถานที่'),
      ),
      body: ListView(
        children: [
          Stack(alignment: Alignment.center, children: [
            GridView.builder(
                shrinkWrap: true,
                itemCount: _image.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4),
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.all(3),
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: FileImage(_image[index]),
                            fit: BoxFit.cover)),
                  );
                }),
            (_image.length == 0
                ? Text("กรุณาเลือกรูป")
                : Visibility(child: Text("data"), visible: false)),
            uploading
                ? Center(
                    child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CircularProgressIndicator(
                        value: val,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
                      )
                    ],
                  ))
                : Container(),
          ]),
          Container(
            height: 40,
            margin: EdgeInsets.all(10),
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.green,
                  padding: EdgeInsets.all(8),
                  textStyle: TextStyle(fontSize: 20),
                ),
                child: Text(
                  'เลือกรูป',
                  style: new TextStyle(fontSize: 16.0),
                ),
                onPressed: () => !uploading ? chooseImage() : null),
          ),
          Container(
              margin: EdgeInsets.all(10),
              child: ListView(
                physics: ClampingScrollPhysics(),
                shrinkWrap: true,
                children: [
                  Text(
                    "คำอธิบายรูปภาพ",
                    style: new TextStyle(fontSize: 16.0, color: Colors.black),
                  ),
                  TextFormField(
                    maxLines: 3,
                    autofocus: false,
                    controller: photo_Detaii_Controller,
                    decoration: new InputDecoration(
                      hintText: 'เขียนอธิบายรูปภาพของคุณ',
                    ),
                  ),
                  SizedBox(height: 10.0),
                  Text(
                    "ชื่อ",
                    style: new TextStyle(fontSize: 16.0, color: Colors.black),
                  ),
                  TextFormField(
                    maxLines: 1,
                    autofocus: false,
                    controller: business_name_Controller,
                    decoration: new InputDecoration(
                      hintText: 'กรุณาใส่ชื่อ',
                    ),
                  ),
                  SizedBox(height: 10.0),
                  Text(
                    "ชื่อแฝง 1 (Alias Name)",
                    style: new TextStyle(fontSize: 16.0),
                  ),
                  TextFormField(
                    maxLines: 1,
                    autofocus: false,
                    controller: business_name1_Controller,
                    decoration: new InputDecoration(
                      hintText: 'กรุณาใส่ชื่อแฝง 1',
                    ),
                  ),
                  SizedBox(height: 10.0),
                  Text(
                    "ชื่อแฝง 2 (Alias Name)",
                    style: new TextStyle(fontSize: 16.0),
                  ),
                  TextFormField(
                    maxLines: 1,
                    autofocus: false,
                    controller: business_name2_Controller,
                    decoration: new InputDecoration(
                      hintText: 'กรุณาใส่ชื่อแฝง 2',
                    ),
                  ),
                  SizedBox(height: 10.0),
                  Text(
                    "ชื่อแฝง 3 (Alias Name)",
                    style: new TextStyle(fontSize: 16.0),
                  ),
                  TextFormField(
                    maxLines: 1,
                    autofocus: false,
                    controller: business_name3_Controller,
                    keyboardType: TextInputType.text,
                    decoration:
                        new InputDecoration(hintText: 'กรุณาใส่ชื่อแฝง 3'),
                  ),
                  SizedBox(height: 10.0),
                  Text(
                    "English",
                    style: new TextStyle(fontSize: 16.0),
                  ),
                  TextFormField(
                    maxLines: 1,
                    autofocus: false,
                    controller: business_name_english_Controller,
                    keyboardType: TextInputType.text,
                    decoration:
                        new InputDecoration(hintText: 'กรุณาใส่ English'),
                  ),
                  // SizedBox(height: 10.0),
                  // Text(
                  //   "หมวดหมู่สถานที่",
                  //   style: new TextStyle(fontSize: 16.0),
                  // ),
                  // Padding(
                  //   padding: EdgeInsets.only(left: 10),
                  //   child: DropdownButton<String>(
                  //     value: dropdownValue,
                  //     icon: Icon(Icons.arrow_drop_down),
                  //     iconSize: 24,
                  //     elevation: 16,
                  //     style: TextStyle(color: Colors.black, fontSize: 18),
                  //     underline: Container(
                  //       height: 2,
                  //     ),
                  //     onChanged: (data) {
                  //       setState(() {
                  //         dropdownValue = data!;
                  //       });
                  //     },
                  //     items: business_type
                  //         .map<DropdownMenuItem<String>>((String value) {
                  //       return DropdownMenuItem<String>(
                  //         value: value,
                  //         child: Text(value, textAlign: TextAlign.center),
                  //       );
                  //     }).toList(),
                  //   ),
                  // ),
                  SizedBox(height: 10.0),
                  Text(
                    "หมวดหมู่สถานที่",
                    style: new TextStyle(fontSize: 16.0),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: DropdownButton<String>(
                      value: dropdownValue,
                      icon: Icon(Icons.arrow_drop_down),
                      iconSize: 24,
                      elevation: 16,
                      style: TextStyle(color: Colors.black, fontSize: 15),
                      underline: Container(
                        height: 2,
                      ),
                      onChanged: (data) {
                        setState(() {
                          dropdownValue = data!;
                        });
                      },
                      items: business_type
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value, textAlign: TextAlign.center),
                        );
                      }).toList(),
                    ),
                  ),

                  Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: DropdownButton<String>(
                      value: dropdownValue2,
                      icon: Icon(Icons.arrow_drop_down),
                      iconSize: 24,
                      elevation: 16,
                      style: TextStyle(color: Colors.black, fontSize: 15),
                      underline: Container(
                        height: 2,
                      ),
                      onChanged: (data) {
                        setState(() {
                          dropdownValue2 = data!;
                        });
                      },
                      items: business_type2
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value, textAlign: TextAlign.center),
                        );
                      }).toList(),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: DropdownButton<String>(
                      value: dropdownValue3,
                      icon: Icon(Icons.arrow_drop_down),
                      iconSize: 24,
                      elevation: 16,
                      style: TextStyle(color: Colors.black, fontSize: 15),
                      underline: Container(
                        height: 2,
                      ),
                      onChanged: (data) {
                        setState(() {
                          dropdownValue3 = data!;
                        });
                      },
                      items: business_type3
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value, textAlign: TextAlign.center),
                        );
                      }).toList(),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: DropdownButton<String>(
                      value: dropdownValue4,
                      icon: Icon(Icons.arrow_drop_down),
                      iconSize: 24,
                      elevation: 16,
                      style: TextStyle(color: Colors.black, fontSize: 15),
                      underline: Container(
                        height: 2,
                      ),
                      onChanged: (data) {
                        setState(() {
                          dropdownValue4 = data!;
                        });
                      },
                      items: business_type4
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value, textAlign: TextAlign.center),
                        );
                      }).toList(),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: DropdownButton<String>(
                      value: dropdownValue5,
                      icon: Icon(Icons.arrow_drop_down),
                      iconSize: 24,
                      elevation: 16,
                      style: TextStyle(color: Colors.black, fontSize: 15),
                      underline: Container(
                        height: 2,
                      ),
                      onChanged: (data) {
                        setState(() {
                          dropdownValue5 = data!;
                        });
                      },
                      items: business_type5
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value, textAlign: TextAlign.center),
                        );
                      }).toList(),
                    ),
                  ),
                  SizedBox(height: 20.0),
                  Text(
                    "หมวดหมู่ย่อย",
                    style: new TextStyle(fontSize: 16.0),
                  ),
                  SizedBox(height: 10.0),
                  Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: DropdownButton<String>(
                      value: dropdownValue6,
                      icon: Icon(Icons.arrow_drop_down),
                      iconSize: 24,
                      elevation: 16,
                      style: TextStyle(color: Colors.black, fontSize: 15),
                      underline: Container(
                        height: 2,
                      ),
                      onChanged: (data) {
                        setState(() {
                          dropdownValue6 = data!;
                        });
                      },
                      items: business_type6
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value, textAlign: TextAlign.center),
                        );
                      }).toList(),
                    ),
                  ),

                  Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: DropdownButton<String>(
                      value: dropdownValue7,
                      icon: Icon(Icons.arrow_drop_down),
                      iconSize: 24,
                      elevation: 16,
                      style: TextStyle(color: Colors.black, fontSize: 15),
                      underline: Container(
                        height: 2,
                      ),
                      onChanged: (data) {
                        setState(() {
                          dropdownValue7 = data!;
                        });
                      },
                      items: business_type7
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value, textAlign: TextAlign.center),
                        );
                      }).toList(),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: DropdownButton<String>(
                      value: dropdownValue8,
                      icon: Icon(Icons.arrow_drop_down),
                      iconSize: 24,
                      elevation: 16,
                      style: TextStyle(color: Colors.black, fontSize: 15),
                      underline: Container(
                        height: 2,
                      ),
                      onChanged: (data) {
                        setState(() {
                          dropdownValue8 = data!;
                        });
                      },
                      items: business_type8
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value, textAlign: TextAlign.center),
                        );
                      }).toList(),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: DropdownButton<String>(
                      value: dropdownValue9,
                      icon: Icon(Icons.arrow_drop_down),
                      iconSize: 24,
                      elevation: 16,
                      style: TextStyle(color: Colors.black, fontSize: 15),
                      underline: Container(
                        height: 2,
                      ),
                      onChanged: (data) {
                        setState(() {
                          dropdownValue9 = data!;
                        });
                      },
                      items: business_type9
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value, textAlign: TextAlign.center),
                        );
                      }).toList(),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: DropdownButton<String>(
                      value: dropdownValue10,
                      icon: Icon(Icons.arrow_drop_down),
                      iconSize: 24,
                      elevation: 16,
                      style: TextStyle(color: Colors.black, fontSize: 15),
                      underline: Container(
                        height: 2,
                      ),
                      onChanged: (data) {
                        setState(() {
                          dropdownValue10 = data!;
                        });
                      },
                      items: business_type10
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value, textAlign: TextAlign.center),
                        );
                      }).toList(),
                    ),
                  ),
                  // RaisedButton(
                  //   child: Text('เลือก'),
                  //   onPressed: () => business_type,
                  // ),
                  SizedBox(height: 10.0),
                  Text(
                    "เบอร์โทร",
                    style: new TextStyle(fontSize: 16.0),
                  ),
                  TextFormField(
                    maxLines: 1,
                    autofocus: false,
                    controller: tel_Controller,
                    keyboardType: TextInputType.number,
                    decoration:
                        new InputDecoration(hintText: 'กรุณาใส่เบอร์โทร'),
                  ),
                  SizedBox(height: 10.0),
                  Text(
                    "วันที่เปิดทำการ",
                    style: new TextStyle(fontSize: 16.0),
                  ),
                  TextFormField(
                    maxLines: 1,
                    autofocus: false,
                    controller: day_Controller,
                    keyboardType: TextInputType.text,
                    decoration:
                        new InputDecoration(hintText: 'กรุณาใส่วันที่เปิด'),
                  ),
                  SizedBox(height: 10.0),
                  Text(
                    "เวลาเปิด-ปิด",
                    style: new TextStyle(fontSize: 16.0),
                  ),
                  TextFormField(
                    maxLines: 1,
                    autofocus: false,
                    controller: time_Controller,
                    keyboardType: TextInputType.text,
                    decoration:
                        new InputDecoration(hintText: 'กรุณาใส่เวลาเปิดปิด'),
                  ),
                  SizedBox(height: 40.0),
                  Text(
                    "ตั้งค่าเวลาเปิด-ปิด อัตโนมัติ",
                    style: new TextStyle(fontSize: 16.0),
                  ),
                  SizedBox(height: 10.0),
                  Text(
                    "(ยกตัวอย่างเช่น แปดโมงครึ่งให้กรอก 8.30)",
                    style: new TextStyle(fontSize: 12.0),
                  ),
                  SizedBox(height: 5.0),
                  Text(
                    "(ยกตัวอย่างเช่น เปิดตลอดให้กรอก 0.01 - 23.59 )",
                    style: new TextStyle(fontSize: 12.0),
                  ),
                  TextFormField(
                    maxLines: 1,
                    autofocus: false,
                    controller: time_open_Controller,
                    keyboardType: TextInputType.number,
                    decoration:
                        new InputDecoration(hintText: 'กรุณาใส่เวลาเปิด'),
                  ),
                  TextFormField(
                    maxLines: 1,
                    autofocus: false,
                    controller: time_close_Controller,
                    keyboardType: TextInputType.number,
                    decoration:
                        new InputDecoration(hintText: 'กรุณาใส่เวลาปิด'),
                  ),
                  SizedBox(height: 40.0),
                  // RaisedButton(
                  //     child: Text('timeopen'),
                  //     onPressed: () {
                  //       showTimePicker(
                  //         context: context,
                  //         initialTime: TimeOfDay.now(),
                  //       ).then((value) {
                  //         setState(() {
                  //           timeopen = value!;
                  //           print(value);
                  //         });
                  //       });
                  //     }),
                  Text(
                    "ช่วงราคา",
                    style: new TextStyle(fontSize: 16.0),
                  ),
                  TextFormField(
                    maxLines: 1,
                    autofocus: false,
                    controller: price_Controller,
                    keyboardType: TextInputType.text,
                    decoration:
                        new InputDecoration(hintText: 'กรุณาใส่ช่วงราคา'),
                  ),
                  SizedBox(height: 10.0),
                  Text(
                    "เว็บไซต์",
                    style: new TextStyle(fontSize: 16.0),
                  ),
                  TextFormField(
                    maxLines: 1,
                    autofocus: false,
                    controller: website_Controller,
                    keyboardType: TextInputType.text,
                    decoration:
                        new InputDecoration(hintText: 'กรุณาใส่เว็บไซต์'),
                  ),
                  SizedBox(height: 10.0),
                  Text(
                    "Facebook",
                    style: new TextStyle(fontSize: 16.0),
                  ),
                  TextFormField(
                    maxLines: 1,
                    autofocus: false,
                    controller: facebook_Controller,
                    keyboardType: TextInputType.text,
                    decoration:
                        new InputDecoration(hintText: 'กรุณาใส่ Facebook'),
                  ),
                  SizedBox(height: 10.0),
                  Text(
                    "Instagram",
                    style: new TextStyle(fontSize: 16.0),
                  ),
                  TextFormField(
                    maxLines: 1,
                    autofocus: false,
                    controller: instagram_Controller,
                    keyboardType: TextInputType.text,
                    decoration:
                        new InputDecoration(hintText: 'กรุณาใส่ Instagram'),
                  ),
                  SizedBox(height: 10.0),
                  Text(
                    "อีเมล",
                    style: new TextStyle(fontSize: 16.0),
                  ),
                  TextFormField(
                    maxLines: 1,
                    autofocus: false,
                    controller: email_Controller,
                    keyboardType: TextInputType.text,
                    decoration: new InputDecoration(hintText: 'กรุณาใส่อีเมล'),
                  ),
                  SizedBox(height: 10.0),
                  Text(
                    "Line",
                    style: new TextStyle(fontSize: 16.0),
                  ),
                  TextFormField(
                    maxLines: 1,
                    autofocus: false,
                    controller: line_Controller,
                    keyboardType: TextInputType.text,
                    decoration: new InputDecoration(hintText: 'กรุณาใส่ Line'),
                  ),
                  SizedBox(height: 10.0),
                  Text(
                    "ที่อยู่",
                    style: new TextStyle(fontSize: 16.0),
                  ),
                  TextFormField(
                    maxLines: 1,
                    autofocus: false,
                    controller: address_Controller,
                    keyboardType: TextInputType.text,
                    decoration:
                        new InputDecoration(hintText: 'กรุณาใส่ที่อยู่'),
                  ),
                  SizedBox(height: 20.0),
                  Text(
                    "ตำแหน่งสถานที่ของคุณ",
                    style: new TextStyle(fontSize: 16.0),
                  ),
                  TextFormField(
                    maxLines: 1,
                    autofocus: false,
                    controller: latitude_Controller,
                    keyboardType: TextInputType.number,
                    decoration:
                        new InputDecoration(hintText: 'กรุณาใส่ละติจูด'),
                  ),

                  TextFormField(
                    maxLines: 1,
                    autofocus: false,
                    controller: longitude_Controller,
                    keyboardType: TextInputType.number,
                    decoration:
                        new InputDecoration(hintText: 'กรุณาใส่ลองจิจูด'),
                  ),
                  SizedBox(height: 5.0),
                  // Text(
                  //   "ตำแหน่งสถานที่ 2",
                  //   style: new TextStyle(fontSize: 16.0),
                  // ),
                  // TextFormField(
                  //   maxLines: 1,
                  //   autofocus: false,
                  //   controller: latitude2_Controller,
                  //   keyboardType: TextInputType.number,
                  //   decoration: new InputDecoration(
                  //       hintText: 'กรุณาใส่ละติจูด (ถ้าไม่มีให้ใส่ 1.1)'),
                  // ),

                  // TextFormField(
                  //   maxLines: 1,
                  //   autofocus: false,
                  //   controller: longitude2_Controller,
                  //   keyboardType: TextInputType.number,
                  //   decoration: new InputDecoration(
                  //       hintText: 'กรุณาใส่ลองจิจูด (ถ้าไม่มีให้ใส่ 1.1)'),
                  // ),
                  // SizedBox(height: 5.0),
                  // Text(
                  //   "ตำแหน่งสถานที่ 3",
                  //   style: new TextStyle(fontSize: 16.0),
                  // ),
                  // TextFormField(
                  //   maxLines: 1,
                  //   autofocus: false,
                  //   controller: latitude3_Controller,
                  //   keyboardType: TextInputType.number,
                  //   decoration: new InputDecoration(
                  //       hintText: 'กรุณาใส่ละติจูด (ถ้าไม่มีให้ใส่ 1.1)'),
                  // ),

                  // TextFormField(
                  //   maxLines: 1,
                  //   autofocus: false,
                  //   controller: longitude3_Controller,
                  //   keyboardType: TextInputType.number,
                  //   decoration: new InputDecoration(
                  //       hintText: 'กรุณาใส่ลองจิจูด (ถ้าไม่มีให้ใส่ 1.1)'),
                  // ),
                  // SizedBox(height: 5.0),
                  // Text(
                  //   "ตำแหน่งสถานที่ 4",
                  //   style: new TextStyle(fontSize: 16.0),
                  // ),
                  // TextFormField(
                  //   maxLines: 1,
                  //   autofocus: false,
                  //   controller: latitude4_Controller,
                  //   keyboardType: TextInputType.number,
                  //   decoration: new InputDecoration(
                  //       hintText: 'กรุณาใส่ละติจูด (ถ้าไม่มีให้ใส่ 1.1)'),
                  // ),

                  // TextFormField(
                  //   maxLines: 1,
                  //   autofocus: false,
                  //   controller: longitude4_Controller,
                  //   keyboardType: TextInputType.number,
                  //   decoration: new InputDecoration(
                  //       hintText: 'กรุณาใส่ลองจิจูด (ถ้าไม่มีให้ใส่ 1.1)'),
                  // ),
                  // SizedBox(height: 5.0),
                  // Text(
                  //   "ตำแหน่งสถานที่ 5",
                  //   style: new TextStyle(fontSize: 16.0),
                  // ),
                  // TextFormField(
                  //   maxLines: 1,
                  //   autofocus: false,
                  //   controller: latitude5_Controller,
                  //   keyboardType: TextInputType.number,
                  //   decoration: new InputDecoration(
                  //       hintText: 'กรุณาใส่ละติจูด (ถ้าไม่มีให้ใส่ 1.1)'),
                  // ),

                  // TextFormField(
                  //   maxLines: 1,
                  //   autofocus: false,
                  //   controller: longitude5_Controller,
                  //   keyboardType: TextInputType.number,
                  //   decoration: new InputDecoration(
                  //       hintText: 'กรุณาใส่ลองจิจูด (ถ้าไม่มีให้ใส่ 1.1)'),
                  // ),

                  SizedBox(height: 10.0),
                  Text(
                    "รายละเอียดร้าน",
                    style: new TextStyle(fontSize: 16.0),
                  ),
                  TextFormField(
                    maxLines: 1,
                    autofocus: false,
                    controller: detail_Controller,
                    keyboardType: TextInputType.text,
                  ),

                  SizedBox(height: 10.0),
                  Text(
                    "ตำแหน่งสถานที่",
                    style: new TextStyle(fontSize: 16.0),
                  ),
                  TextFormField(
                    maxLines: 1,
                    autofocus: false,
                    controller: google_map_Controller,
                    keyboardType: TextInputType.text,
                    decoration: new InputDecoration(
                        hintText: 'เช่น www.google.co.th/maps/place/test'),
                  ),
                  SizedBox(height: 10.0),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.green,
                        padding: EdgeInsets.all(8),
                        textStyle: TextStyle(fontSize: 20),
                      ),
                      child: Text(
                        'เพิ่มสถานที่',
                        style: new TextStyle(fontSize: 20.0),
                      ),
                      onPressed: () {
                        uploadFile();
                      }),
                ],
              )),
        ],
      ),
    );
  }

  chooseImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      if (_image.length == 10) {
        Toast.show("เพิ่มรูปได้ 10 รูปเท่านั้น", context,
            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
        return;
      } else {
        _image.add(File(pickedFile!.path));
      }
    });
    if (pickedFile!.path == null) retrieveLostData();
  }

  Future<void> retrieveLostData() async {
    final LostData response = await picker.getLostData();
    if (response.isEmpty) {
      return;
    }
    if (response.file != null) {
      setState(() {
        _image.add(File(response.file!.path));
      });
    } else {
      print(response.file);
    }
  }

  Future uploadFile() async {
    FocusScope.of(context).unfocus();
    var Business_name = business_name_Controller.text.trim();
    var Business_name1 = business_name1_Controller.text.trim();
    var Business_name2 = business_name2_Controller.text.trim();
    var Business_name3 = business_name3_Controller.text.trim();
    var Business_name_english = business_name_english_Controller.text.trim();
    var Tel = tel_Controller.text.trim();
    var Day = day_Controller.text.trim();
    var Time = time_Controller.text.trim();
    var Price = price_Controller.text.trim();
    var Website = website_Controller.text.trim();
    var Facebook = facebook_Controller.text.trim();
    var Instagram = instagram_Controller.text.trim();
    var Line = line_Controller.text.trim();
    var Email = email_Controller.text.trim();
    var Address = address_Controller.text.trim();
    var Latitude = latitude_Controller.text.trim();
    var Longitude = longitude_Controller.text.trim();
    var Latitude2 = latitude2_Controller.text.trim();
    var Longitude2 = longitude2_Controller.text.trim();
    var Latitude3 = latitude3_Controller.text.trim();
    var Longitude3 = longitude3_Controller.text.trim();
    var Latitude4 = latitude4_Controller.text.trim();
    var Longitude4 = longitude4_Controller.text.trim();
    var Latitude5 = latitude5_Controller.text.trim();
    var Longitude5 = longitude5_Controller.text.trim();
    var Detail = detail_Controller.text.trim();
    var Google_map = google_map_Controller.text.trim();
    var type = dropdownValue;
    var Type2 = dropdownValue2;
    var Type3 = dropdownValue3;
    var Type4 = dropdownValue4;
    var Type5 = dropdownValue5;
    var Type6 = dropdownValue6;
    var Type7 = dropdownValue7;
    var Type8 = dropdownValue8;
    var Type9 = dropdownValue9;
    var type10 = dropdownValue10;
    var photodetail = photo_Detaii_Controller.text.trim();
    var time_open = time_open_Controller.text.trim();
    var time_close = time_close_Controller.text.trim();

    if (validateEmail(Email) == false) {
      Toast.show('กรุณาตรวจสอบอีเมลให้ถูกต้อง', context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      return;
    }
    if (Email.length > 100) {
      Toast.show("ต้องไม่เกิน 100 ตัว", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      return;
    }
    if (Business_name.isEmpty) {
      Toast.show("กรุณาใส่ชื่อสถานที่ของคุณก่อน", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      return;
    }
    if (Business_name.length > 50) {
      Toast.show("ชื่อสถานที่ต้องไม่เกิน 50 ตัว", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      return;
    }

    if (Business_name1.length > 50) {
      Toast.show("ชื่อสถานที่รอง1ต้องไม่เกิน 50 ตัว", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      return;
    }

    if (Business_name2.length > 50) {
      Toast.show("ชื่อสถานที่รอง2ต้องไม่เกิน 50 ตัว", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      return;
    }

    if (Business_name3.length > 50) {
      Toast.show("ชื่อสถานที่รอง3ต้องไม่เกิน 50 ตัว", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      return;
    }
    if (Business_name_english.length > 50) {
      Toast.show("ชื่อภาษาอังกฤษสถานที่ต้องไม่เกิน 50 ตัว", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      return;
    }
    if (Latitude.isEmpty) {
      Toast.show("กรุณาใส่ละติจูดของคุณก่อน", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      return;
    }
    if (Longitude.isEmpty) {
      Toast.show("กรุณาใส่ลองจิจูดของคุณก่อน", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      return;
    }
    if (Google_map.isEmpty) {
      Toast.show("กรุณาใส่ลิงก์ map ของคุณก่อน", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      return;
    }

    if (time_open.isEmpty) {
      Toast.show("กรุณาใส่เวลาเปิดสถานที่อัตโนมัติของคุณก่อน", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      return;
    }
    if (time_close.isEmpty) {
      Toast.show("กรุณาใส่เวลาปิดสถานที่อัตโนมัติของคุณก่อน", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      return;
    }
    if (Tel.isEmpty) {
      Toast.show("กรุณาเบอร์โทรศัพท์ของคุณก่อน", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      return;
    }
    if (Tel.length > 15) {
      Toast.show("เบอร์โทรศัพท์ต้องไม่เกิน 15 ตัว", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      return;
    }
    if (Day.isEmpty) {
      Toast.show("กรุณาใส่วันเปิดสถานที่ของคุณก่อน", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      return;
    }
    if (Day.length > 30) {
      Toast.show("วันเปิด/ปิดทำการต้องไม่เกิน 30 ตัว", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      return;
    }
    if (Time.isEmpty) {
      Toast.show("กรุณาใส่เวลา เปิด/ปิด สถานที่ของคุณก่อน", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      return;
    }
    if (Time.length > 30) {
      Toast.show("เวลา เปิด/ปิด สถานที่ต้องไม่เกิน 30 ตัว", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      return;
    }
    if (Price.length > 30) {
      Toast.show("ช่วงราคาสถานที่ต้องไม่เกิน 30 ตัว", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      return;
    }
    if (Address.isEmpty) {
      Toast.show("กรุณาใส่ที่อยู่ของคุณก่อน", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      return;
    }
    if (Address.length > 100) {
      Toast.show("ที่อยุ่สถานที่ต้องไม่เกิน 100 ตัว", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      return;
    }
    if (Website.length > 100) {
      Toast.show("เว็บไซต์การต้องไม่เกิน 30 ตัว", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      return;
    }
    if (Line.length > 100) {
      Toast.show("Line ต้องไม่เกิน 100 ตัว", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      return;
    }
    if (Facebook.length > 100) {
      Toast.show("Facebook ต้องไม่เกิน 100 ตัว", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      return;
    }
    if (Instagram.length > 100) {
      Toast.show("Instagram ต้องไม่เกิน 100 ตัว", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      return;
    }
    if (photodetail.length > 50) {
      Toast.show("Instagram ต้องไม่เกิน 50 ตัว", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      return;
    }

    int i = 0;

    final ProgressDialog pr = ProgressDialog(context,
        type: ProgressDialogType.Download,
        isDismissible: false,
        showLogs: false);
    for (var img in _image) {
      setState(() {
        val = i / _image.length;

        pr.update(
            message: 'กรุณารอสักครู่ ...',
            progressWidget: Container(
                margin: EdgeInsets.all(10.0),
                child: CircularProgressIndicator()),
            progress: double.parse((val * 100).toStringAsFixed(0)),
            maxProgress: 100,
            progressTextStyle: TextStyle(
                color: Colors.black,
                fontSize: 13.0,
                fontWeight: FontWeight.w400));
        pr.show();
      });
      ref = firebase_storage.FirebaseStorage.instance
          .ref()
          .child('images/${Path.basename(img.path)}');

      await ref.putFile(img).whenComplete(() async {
        await ref.getDownloadURL().then((value) {
          url_image.add(value);
          i++;
        });
      });
    }

    print(i);
    var photo10,
        photo9,
        photo8,
        photo7,
        photo6,
        photo5,
        photo4,
        photo3,
        photo2,
        photo1;

    if (i == 10) {
      photo10 = url_image[9];
      photo9 = url_image[8];
      photo8 = url_image[7];
      photo7 = url_image[6];
      photo6 = url_image[5];
      photo5 = url_image[4];
      photo4 = url_image[3];
      photo3 = url_image[2];
      photo2 = url_image[1];
      photo1 = url_image[0];
    } else if (i == 9) {
      photo10 = "";
      photo9 = url_image[8];
      photo8 = url_image[7];
      photo7 = url_image[6];
      photo6 = url_image[5];
      photo5 = url_image[4];
      photo4 = url_image[3];
      photo3 = url_image[2];
      photo2 = url_image[1];
      photo1 = url_image[0];
    } else if (i == 8) {
      photo10 = "";
      photo9 = "";
      photo8 = url_image[7];
      photo7 = url_image[6];
      photo6 = url_image[5];
      photo5 = url_image[4];
      photo4 = url_image[3];
      photo3 = url_image[2];
      photo2 = url_image[1];
      photo1 = url_image[0];
    } else if (i == 7) {
      photo10 = "";
      photo9 = "";
      photo8 = "";
      photo7 = url_image[6];
      photo6 = url_image[5];
      photo5 = url_image[4];
      photo4 = url_image[3];
      photo3 = url_image[2];
      photo2 = url_image[1];
      photo1 = url_image[0];
    } else if (i == 6) {
      photo10 = "";
      photo9 = "";
      photo8 = "";
      photo7 = "";
      photo6 = url_image[5];
      photo5 = url_image[4];
      photo4 = url_image[3];
      photo3 = url_image[2];
      photo2 = url_image[1];
      photo1 = url_image[0];
    } else if (i == 5) {
      photo10 = "";
      photo9 = "";
      photo8 = "";
      photo7 = "";
      photo6 = "";
      photo5 = url_image[4];
      photo4 = url_image[3];
      photo3 = url_image[2];
      photo2 = url_image[1];
      photo1 = url_image[0];
    } else if (i == 4) {
      photo10 = "";
      photo9 = "";
      photo8 = "";
      photo7 = "";
      photo6 = "";
      photo5 = "";
      photo4 = url_image[3];
      photo3 = url_image[2];
      photo2 = url_image[1];
      photo1 = url_image[0];
    } else if (i == 3) {
      photo10 = "";
      photo9 = "";
      photo8 = "";
      photo7 = "";
      photo6 = "";
      photo5 = "";
      photo4 = "";
      photo3 = url_image[2];
      photo2 = url_image[1];
      photo1 = url_image[0];
    } else if (i == 2) {
      photo10 = "";
      photo9 = "";
      photo8 = "";
      photo7 = "";
      photo6 = "";
      photo5 = "";
      photo4 = "";
      photo3 = "";
      photo2 = url_image[1];
      photo1 = url_image[0];
    } else if (i == 1) {
      photo10 = "";
      photo9 = "";
      photo8 = "";
      photo7 = "";
      photo6 = "";
      photo5 = "";
      photo4 = "";
      photo3 = "";
      photo2 = "";
      photo1 = url_image[0];
    }

    SharedPreferences prefs = await SharedPreferences.getInstance();
    var User_id = prefs.getString('user_id').toString();

    int array = 0;
    final snapshot = await FirebaseFirestore.instance.collection("place").get();
    if (snapshot.docs.length == 0) {
      array = 0;

      imgRef
          .add({
            'address': Address,
            'array': array,
            'business_name': Business_name,
            'business_name1': Business_name1,
            'business_name2': Business_name2,
            'business_name3': Business_name3,
            'business_name_english': Business_name_english,
            'day': Day,
            'detail': Detail,
            'email': Email,
            'facebook': Facebook,
            'instagram': Instagram,
            'latitude': double.parse('$Latitude'),
            'line': Line,
            'longitude': double.parse('$Longitude'),
            'latitude2': 0.1,
            'longitude2': 0.1,
            'latitude3': 0.1,
            'longitude3': 0.1,
            'latitude4': 0.1,
            'longitude4': 0.1,
            'latitude5': 0.1,
            'longitude5': 0.1,
            'map': Google_map,
            'open': "false",
            'auto': "true",
            'photo1': photo1,
            'photo2': photo2,
            'photo3': photo3,
            'photo4': photo4,
            'photo5': photo5,
            'photo6': photo6,
            'photo7': photo7,
            'photo8': photo8,
            'photo9': photo9,
            'photo10': photo10,
            'place_id': "",
            'price': Price,
            'rating': 0,
            'view': 0,
            'status': "true",
            'tel': Tel,
            'time': Time,
            'type': type,
            'type2': Type2,
            'type3': Type3,
            'type4': Type4,
            'type5': Type5,
            'type6': Type6,
            'type7': Type7,
            'type8': Type8,
            'type9': Type9,
            'type10': type10,
            'user_id': User_id,
            'website': Website,
            'check': false,
            'photodetail': photodetail,
            'time_open': double.parse('$time_open'),
            'time_close': double.parse('$time_close'),
          })
          .then((value) => FirebaseFirestore.instance
              .collection('place')
              .doc(value.id)
              .update({'place_id': value.id}))
          .whenComplete(() async {
            pr.hide();
            print("complete");
            Navigator.of(context).pop();
          });
    } else {
      FirebaseFirestore.instance
          .collection('place')
          .orderBy('array', descending: true)
          .limit(1)
          .get()
          .then((querySnapshot) {
        querySnapshot.docs.forEach((result) async {
          array = result.data()['array'] + 1;

          imgRef
              .add({
                'address': Address,
                'array': array,
                'business_name': Business_name,
                'business_name1': Business_name1,
                'business_name2': Business_name2,
                'business_name3': Business_name3,
                'business_name_english': Business_name_english,
                'day': Day,
                'detail': Detail,
                'email': Email,
                'facebook': Facebook,
                'instagram': Instagram,
                'latitude': double.parse('$Latitude'),
                'line': Line,
                'longitude': double.parse('$Longitude'),
                'latitude2': 0.1,
                'longitude2': 0.1,
                'latitude3': 0.1,
                'longitude3': 0.1,
                'latitude4': 0.1,
                'longitude4': 0.1,
                'latitude5': 0.1,
                'longitude5': 0.1,
                'map': Google_map,
                'open': "false",
                'auto': "true",
                'photo1': photo1,
                'photo2': photo2,
                'photo3': photo3,
                'photo4': photo4,
                'photo5': photo5,
                'photo6': photo6,
                'photo7': photo7,
                'photo8': photo8,
                'photo9': photo9,
                'photo10': photo10,
                'place_id': "",
                'price': Price,
                'rating': 0,
                'view': 0,
                'status': "true",
                'tel': Tel,
                'time': Time,
                'type': type,
                'type2': Type2,
                'type3': Type3,
                'type4': Type4,
                'type5': Type5,
                'type6': Type6,
                'type7': Type7,
                'type8': Type8,
                'type9': Type9,
                'type10': type10,
                'user_id': User_id,
                'website': Website,
                'check': false,
                'photodetail': photodetail,
                'time_open': double.parse('$time_open'),
                'time_close': double.parse('$time_close'),
              })
              .then((value) => FirebaseFirestore.instance
                  .collection('place')
                  .doc(value.id)
                  .update({'place_id': value.id}))
              .whenComplete(() async {
                pr.hide();
                print("complete");
                Navigator.of(context).pop();
              });
        });
      });
    }
  }

  bool validateEmail(String email) {
    bool emailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
    return emailValid;
  }

  String dropdownValue = 'โปรดระบุหมวดหมู่';
  List<String> business_type = [
    'โปรดระบุหมวดหมู่',
    'ร้านอาหาร',
    'ร้านกาแฟ',
    'ร้านเครื่องเขียน',
    'ร้านเสริมสวย',
    'คลินิก/ขายยา',
    'ร้านทั่วไป',
    'สถานที่ใน Rmutt',
    'สถานที่ทั่วไป'
  ];
  String dropdownValue2 = 'โปรดระบุหมวดหมู่';
  List<String> business_type2 = [
    'โปรดระบุหมวดหมู่',
    'ร้านอาหาร',
    'ร้านกาแฟ',
    'ร้านเครื่องเขียน',
    'ร้านเสริมสวย',
    'คลินิก/ขายยา',
    'ร้านทั่วไป',
    'สถานที่ใน Rmutt',
    'สถานที่ทั่วไป'
  ];
  String dropdownValue3 = 'โปรดระบุหมวดหมู่';
  List<String> business_type3 = [
    'โปรดระบุหมวดหมู่',
    'ร้านอาหาร',
    'ร้านกาแฟ',
    'ร้านเครื่องเขียน',
    'ร้านเสริมสวย',
    'คลินิก/ขายยา',
    'ร้านทั่วไป',
    'สถานที่ใน Rmutt',
    'สถานที่ทั่วไป'
  ];
  String dropdownValue4 = 'โปรดระบุหมวดหมู่';
  List<String> business_type4 = [
    'โปรดระบุหมวดหมู่',
    'ร้านอาหาร',
    'ร้านกาแฟ',
    'ร้านเครื่องเขียน',
    'ร้านเสริมสวย',
    'คลินิก/ขายยา',
    'ร้านทั่วไป',
    'สถานที่ใน Rmutt',
    'สถานที่ทั่วไป'
  ];
  String dropdownValue5 = 'โปรดระบุหมวดหมู่';
  List<String> business_type5 = [
    'โปรดระบุหมวดหมู่',
    'ร้านอาหาร',
    'ร้านกาแฟ',
    'ร้านเครื่องเขียน',
    'ร้านเสริมสวย',
    'คลินิก/ขายยา',
    'ร้านทั่วไป',
    'สถานที่ใน Rmutt',
    'สถานที่ทั่วไป'
  ];
  String dropdownValue6 = 'โปรดระบุประเภท';
  List<String> business_type6 = [
    'โปรดระบุประเภท',
    'ชาบู/ปิ้งย่าง',
    'ตามสั่ง',
    'จานด่วน',
    'เกาหลี',
    'ญี่ปุ่น',
    'ไทย',
    'ของหวาน',
    'ฟาสต์ฟูด',
    'อื่นๆ'
  ];
  String dropdownValue7 = 'โปรดระบุประเภท';
  List<String> business_type7 = [
    'โปรดระบุประเภท',
    'ชาบู/ปิ้งย่าง',
    'ตามสั่ง',
    'จานด่วน',
    'เกาหลี',
    'ญี่ปุ่น',
    'ไทย',
    'ของหวาน',
    'ฟาสต์ฟูด',
    'อื่นๆ'
  ];
  String dropdownValue8 = 'โปรดระบุประเภท';
  List<String> business_type8 = [
    'โปรดระบุประเภท',
    'ชาบู/ปิ้งย่าง',
    'ตามสั่ง',
    'จานด่วน',
    'เกาหลี',
    'ญี่ปุ่น',
    'ไทย',
    'ของหวาน',
    'ฟาสต์ฟูด',
    'อื่นๆ'
  ];
  String dropdownValue9 = 'โปรดระบุประเภท';
  List<String> business_type9 = [
    'โปรดระบุประเภท',
    'ชาบู/ปิ้งย่าง',
    'ตามสั่ง',
    'จานด่วน',
    'เกาหลี',
    'ญี่ปุ่น',
    'ไทย',
    'ของหวาน',
    'ฟาสต์ฟูด',
    'อื่นๆ'
  ];
  String dropdownValue10 = 'โปรดระบุประเภท';
  List<String> business_type10 = [
    'โปรดระบุประเภท',
    'ชาบู/ปิ้งย่าง',
    'ตามสั่ง',
    'จานด่วน',
    'เกาหลี',
    'ญี่ปุ่น',
    'ไทย',
    'ของหวาน',
    'ฟาสต์ฟูด',
    'อื่นๆ'
  ];
}
