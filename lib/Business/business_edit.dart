import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:noppon/Entrepreneur/launcher%20copy.dart';
import 'package:noppon/Entrepreneur/launcher.dart';
import 'package:noppon/Model/place.dart';
import 'package:path/path.dart' as Path;
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';

import '../full_image.dart';

class BusinessEdit extends StatefulWidget {
  var place_id,
      address,
      business_name,
      business_name1,
      business_name2,
      business_name3,
      business_name_english,
      day,
      detail,
      email,
      facebook,
      instagram,
      line,
      latitude,
      longitude,
      latitude2,
      longitude2,
      latitude3,
      longitude3,
      latitude4,
      longitude4,
      latitude5,
      longitude5,
      map,
      photo1,
      photo2,
      photo3,
      photo4,
      photo5,
      photo6,
      photo7,
      photo8,
      photo9,
      photo10,
      price,
      rating,
      tel,
      time,
      time_open,
      time_close,
      type,
      type2,
      type3,
      type4,
      type5,
      type6,
      type7,
      type8,
      type9,
      type10,
      user_id,
      website,
      photodetail;

  BusinessEdit({
    this.place_id,
    this.address,
    this.business_name,
    this.business_name1,
    this.business_name2,
    this.business_name3,
    this.business_name_english,
    this.day,
    this.detail,
    this.email,
    this.facebook,
    this.instagram,
    this.line,
    this.latitude,
    this.longitude,
    this.latitude2,
    this.longitude2,
    this.latitude3,
    this.longitude3,
    this.latitude4,
    this.longitude4,
    this.latitude5,
    this.longitude5,
    this.map,
    this.photo1,
    this.photo2,
    this.photo3,
    this.photo4,
    this.photo5,
    this.photo6,
    this.photo7,
    this.photo8,
    this.photo9,
    this.photo10,
    this.price,
    this.rating,
    this.tel,
    this.time,
    this.type,
    this.type2,
    this.type3,
    this.type4,
    this.type5,
    this.type6,
    this.type7,
    this.type8,
    this.type9,
    this.type10,
    this.user_id,
    this.website,
    this.photodetail,
    this.time_open,
    this.time_close,
  });
  @override
  _BusinessEdit createState() => _BusinessEdit();
}

class _BusinessEdit extends State<BusinessEdit> {
  bool uploading = false;
  double val = 0;
  late CollectionReference imgRef;
  late firebase_storage.Reference ref;

  TextEditingController business_name_Controller = TextEditingController();
  TextEditingController business_name1_Controller = TextEditingController();
  TextEditingController business_name2_Controller = TextEditingController();
  TextEditingController business_name3_Controller = TextEditingController();
  TextEditingController business_name_english_Controller =
      TextEditingController();
  TextEditingController tel_Controller = TextEditingController();
  TextEditingController day_Controller = TextEditingController();
  TextEditingController time_Controller = TextEditingController();
  TextEditingController price_Controller = TextEditingController();
  TextEditingController website_Controller = TextEditingController();
  TextEditingController facebook_Controller = TextEditingController();
  TextEditingController instagram_Controller = TextEditingController();
  TextEditingController line_Controller = TextEditingController();
  TextEditingController email_Controller = TextEditingController();
  TextEditingController address_Controller = TextEditingController();
  TextEditingController detail_Controller = TextEditingController();
  TextEditingController google_map_Controller = TextEditingController();

  TextEditingController latitude_Controller = TextEditingController();
  TextEditingController longitude_Controller = TextEditingController();

  TextEditingController latitude2_Controller = TextEditingController();
  TextEditingController longitude2_Controller = TextEditingController();

  TextEditingController latitude3_Controller = TextEditingController();
  TextEditingController longitude3_Controller = TextEditingController();

  TextEditingController latitude4_Controller = TextEditingController();
  TextEditingController longitude4_Controller = TextEditingController();

  TextEditingController latitude5_Controller = TextEditingController();

  TextEditingController longitude5_Controller = TextEditingController();
  TextEditingController photodetail_Controller = TextEditingController();
  TextEditingController type_Controller = TextEditingController();
  TextEditingController type2_Controller = TextEditingController();
  TextEditingController type3_Controller = TextEditingController();
  TextEditingController type4_Controller = TextEditingController();
  TextEditingController type5_Controller = TextEditingController();
  TextEditingController type6_Controller = TextEditingController();
  TextEditingController type7_Controller = TextEditingController();
  TextEditingController type8_Controller = TextEditingController();
  TextEditingController type9_Controller = TextEditingController();
  TextEditingController type10_Controller = TextEditingController();
  TextEditingController check_Controller = TextEditingController();
  TextEditingController photo1_Controller = TextEditingController();
  TextEditingController photo2_Controller = TextEditingController();
  TextEditingController photo3_Controller = TextEditingController();
  TextEditingController photo4_Controller = TextEditingController();
  TextEditingController photo5_Controller = TextEditingController();
  TextEditingController photo6_Controller = TextEditingController();
  TextEditingController photo7_Controller = TextEditingController();
  TextEditingController photo8_Controller = TextEditingController();
  TextEditingController photo9_Controller = TextEditingController();
  TextEditingController photo10_Controller = TextEditingController();
  TextEditingController time_open_Controller = TextEditingController();
  TextEditingController time_close_Controller = TextEditingController();

  List<File> _image = [];
  List<String> url_image = [];
  final picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    imgRef = FirebaseFirestore.instance.collection('place');
    business_name_Controller.text = widget.business_name;
    business_name1_Controller.text = widget.business_name1;
    business_name2_Controller.text = widget.business_name2;
    business_name3_Controller.text = widget.business_name3;
    business_name_english_Controller.text = widget.business_name_english;
    tel_Controller.text = widget.tel;
    day_Controller.text = widget.day;
    time_Controller.text = widget.time;
    price_Controller.text = widget.price;
    website_Controller.text = widget.website;
    facebook_Controller.text = widget.facebook;
    instagram_Controller.text = widget.instagram;
    line_Controller.text = widget.line;
    email_Controller.text = widget.email;
    address_Controller.text = widget.address;
    detail_Controller.text = widget.detail;
    google_map_Controller.text = widget.map;
    latitude_Controller.text = widget.latitude;
    longitude_Controller.text = widget.longitude;
    latitude2_Controller.text = widget.latitude2;
    longitude2_Controller.text = widget.longitude2;
    latitude3_Controller.text = widget.latitude3;
    longitude3_Controller.text = widget.longitude3;
    latitude4_Controller.text = widget.latitude4;
    longitude4_Controller.text = widget.longitude4;
    latitude5_Controller.text = widget.latitude5;
    longitude5_Controller.text = widget.longitude5;
    photodetail_Controller.text = widget.photodetail;
    type_Controller.text = widget.type;
    type2_Controller.text = widget.type2;
    type3_Controller.text = widget.type3;
    type4_Controller.text = widget.type4;
    type5_Controller.text = widget.type5;
    type6_Controller.text = widget.type6;
    type7_Controller.text = widget.type7;
    type8_Controller.text = widget.type8;
    type9_Controller.text = widget.type9;
    type10_Controller.text = widget.type10;
    photo1_Controller.text = widget.photo1;
    photo2_Controller.text = widget.photo2;
    photo3_Controller.text = widget.photo3;
    photo4_Controller.text = widget.photo4;
    photo5_Controller.text = widget.photo5;
    photo6_Controller.text = widget.photo6;
    photo7_Controller.text = widget.photo7;
    photo8_Controller.text = widget.photo8;
    photo9_Controller.text = widget.photo9;
    photo10_Controller.text = widget.photo10;
    time_open_Controller.text = widget.time_open;
    time_close_Controller.text = widget.time_close;
  }

  GetPhotoArray(photo1, photo2, photo3, photo4, photo5, photo6, photo7, photo8,
      photo9, photo10) {
    int check_index = 0;
    List<String> photo_array = [
      photo1,
      photo2,
      photo3,
      photo4,
      photo5,
      photo6,
      photo7,
      photo8,
      photo9,
      photo10
    ];
    if (photo10.isNotEmpty) {
      return InkWell(
          child: ImageSlideshow(
            width: double.infinity,
            height: 200,
            initialPage: 0,
            indicatorColor: Colors.blue,
            indicatorBackgroundColor: Colors.grey,
            onPageChanged: (value) {
              check_index = value;
            },
            autoPlayInterval: 6000,
            isLoop: true,
            children: [
              Image.network(
                photo1,
                fit: BoxFit.cover,
              ),
              Image.network(
                photo2,
                fit: BoxFit.cover,
              ),
              Image.network(
                photo3,
                fit: BoxFit.cover,
              ),
              Image.network(
                photo4,
                fit: BoxFit.cover,
              ),
              Image.network(
                photo5,
                fit: BoxFit.cover,
              ),
              Image.network(
                photo6,
                fit: BoxFit.cover,
              ),
              Image.network(
                photo7,
                fit: BoxFit.cover,
              ),
              Image.network(
                photo8,
                fit: BoxFit.cover,
              ),
              Image.network(
                photo9,
                fit: BoxFit.cover,
              ),
              Image.network(
                photo10,
                fit: BoxFit.cover,
              ),
            ],
          ),
          onTap: () {
            showDialog(
                context: context,
                barrierDismissible: true,
                builder: (BuildContext context) {
                  return SimpleDialog(
                    title: Row(
                      children: [Text('กรุณาเลือกคำสั่ง')],
                    ),
                    children: [
                      SimpleDialogOption(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => FullImage(
                                  photo: photo_array[check_index],
                                ),
                              ));
                        },
                        child: const Text('ดูรูปภาพ'),
                      ),
                      SimpleDialogOption(
                        onPressed: () {
                          firebase_storage.FirebaseStorage.instance
                              .refFromURL(widget.photo1)
                              .delete()
                              .then(
                            (value) {
                              FirebaseFirestore.instance
                                  .collection('place')
                                  .doc(widget.place_id)
                                  .update({'photo1': ''});
                              Navigator.of(context, rootNavigator: true)
                                  .pop('dialog');
                              Toast.show("ลบสำเร็จ", context,
                                  duration: Toast.LENGTH_LONG,
                                  gravity: Toast.BOTTOM);
                            },
                          );
                        },
                        child: const Text('ลบรูปภาพ (1)'),
                      ),
                      SimpleDialogOption(
                        onPressed: () {
                          firebase_storage.FirebaseStorage.instance
                              .refFromURL(widget.photo2)
                              .delete()
                              .then(
                            (value) {
                              FirebaseFirestore.instance
                                  .collection('place')
                                  .doc(widget.place_id)
                                  .update({'photo2': ''});
                              Navigator.of(context, rootNavigator: true)
                                  .pop('dialog');
                              Toast.show("ลบสำเร็จ", context,
                                  duration: Toast.LENGTH_LONG,
                                  gravity: Toast.BOTTOM);
                            },
                          );
                        },
                        child: const Text('ลบรูปภาพ (2)'),
                      ),
                      SimpleDialogOption(
                        onPressed: () {
                          firebase_storage.FirebaseStorage.instance
                              .refFromURL(widget.photo3)
                              .delete()
                              .then(
                            (value) {
                              FirebaseFirestore.instance
                                  .collection('place')
                                  .doc(widget.place_id)
                                  .update({'photo3': ''});
                              Navigator.of(context, rootNavigator: true)
                                  .pop('dialog');
                              Toast.show("ลบสำเร็จ", context,
                                  duration: Toast.LENGTH_LONG,
                                  gravity: Toast.BOTTOM);
                            },
                          );
                        },
                        child: const Text('ลบรูปภาพ (3)'),
                      ),
                      SimpleDialogOption(
                        onPressed: () {
                          firebase_storage.FirebaseStorage.instance
                              .refFromURL(widget.photo4)
                              .delete()
                              .then(
                            (value) {
                              FirebaseFirestore.instance
                                  .collection('place')
                                  .doc(widget.place_id)
                                  .update({'photo4': ''});
                              Navigator.of(context, rootNavigator: true)
                                  .pop('dialog');
                              Toast.show("ลบสำเร็จ", context,
                                  duration: Toast.LENGTH_LONG,
                                  gravity: Toast.BOTTOM);
                            },
                          );
                        },
                        child: const Text('ลบรูปภาพ (4)'),
                      ),
                      SimpleDialogOption(
                        onPressed: () {
                          firebase_storage.FirebaseStorage.instance
                              .refFromURL(widget.photo5)
                              .delete()
                              .then(
                            (value) {
                              FirebaseFirestore.instance
                                  .collection('place')
                                  .doc(widget.place_id)
                                  .update({'photo5': ''});
                              Navigator.of(context, rootNavigator: true)
                                  .pop('dialog');
                              Toast.show("ลบสำเร็จ", context,
                                  duration: Toast.LENGTH_LONG,
                                  gravity: Toast.BOTTOM);
                            },
                          );
                        },
                        child: const Text('ลบรูปภาพ (5)'),
                      ),
                      SimpleDialogOption(
                        onPressed: () {
                          firebase_storage.FirebaseStorage.instance
                              .refFromURL(widget.photo6)
                              .delete()
                              .then(
                            (value) {
                              FirebaseFirestore.instance
                                  .collection('place')
                                  .doc(widget.place_id)
                                  .update({'photo6': ''});
                              Navigator.of(context, rootNavigator: true)
                                  .pop('dialog');
                              Toast.show("ลบสำเร็จ", context,
                                  duration: Toast.LENGTH_LONG,
                                  gravity: Toast.BOTTOM);
                            },
                          );
                        },
                        child: const Text('ลบรูปภาพ (6)'),
                      ),
                      SimpleDialogOption(
                        onPressed: () {
                          firebase_storage.FirebaseStorage.instance
                              .refFromURL(widget.photo7)
                              .delete()
                              .then(
                            (value) {
                              FirebaseFirestore.instance
                                  .collection('place')
                                  .doc(widget.place_id)
                                  .update({'photo7': ''});
                              Navigator.of(context, rootNavigator: true)
                                  .pop('dialog');
                              Toast.show("ลบสำเร็จ", context,
                                  duration: Toast.LENGTH_LONG,
                                  gravity: Toast.BOTTOM);
                            },
                          );
                        },
                        child: const Text('ลบรูปภาพ (7)'),
                      ),
                      SimpleDialogOption(
                        onPressed: () {
                          firebase_storage.FirebaseStorage.instance
                              .refFromURL(widget.photo8)
                              .delete()
                              .then(
                            (value) {
                              FirebaseFirestore.instance
                                  .collection('place')
                                  .doc(widget.place_id)
                                  .update({'photo8': ''});
                              Navigator.of(context, rootNavigator: true)
                                  .pop('dialog');
                              Toast.show("ลบสำเร็จ", context,
                                  duration: Toast.LENGTH_LONG,
                                  gravity: Toast.BOTTOM);
                            },
                          );
                        },
                        child: const Text('ลบรูปภาพ (8)'),
                      ),
                      SimpleDialogOption(
                        onPressed: () {
                          firebase_storage.FirebaseStorage.instance
                              .refFromURL(widget.photo9)
                              .delete()
                              .then(
                            (value) {
                              FirebaseFirestore.instance
                                  .collection('place')
                                  .doc(widget.place_id)
                                  .update({'photo9': ''});
                              Navigator.of(context, rootNavigator: true)
                                  .pop('dialog');
                              Toast.show("ลบสำเร็จ", context,
                                  duration: Toast.LENGTH_LONG,
                                  gravity: Toast.BOTTOM);
                            },
                          );
                        },
                        child: const Text('ลบรูปภาพ (9)'),
                      ),
                      SimpleDialogOption(
                        onPressed: () {
                          firebase_storage.FirebaseStorage.instance
                              .refFromURL(widget.photo10)
                              .delete()
                              .then(
                            (value) {
                              FirebaseFirestore.instance
                                  .collection('place')
                                  .doc(widget.place_id)
                                  .update({'photo10': ''});
                              Navigator.of(context, rootNavigator: true)
                                  .pop('dialog');
                              Toast.show("ลบสำเร็จ", context,
                                  duration: Toast.LENGTH_LONG,
                                  gravity: Toast.BOTTOM);
                            },
                          );
                        },
                        child: const Text('ลบรูปภาพ (10)'),
                      ),
                    ],
                  );
                });
          });
    } else if (photo9.isNotEmpty) {
      return InkWell(
          child: ImageSlideshow(
            width: double.infinity,
            height: 200,
            initialPage: 0,
            indicatorColor: Colors.blue,
            indicatorBackgroundColor: Colors.grey,
            onPageChanged: (value) {
              check_index = value;
            },
            autoPlayInterval: 6000,
            isLoop: true,
            children: [
              Image.network(
                photo1,
                fit: BoxFit.cover,
              ),
              Image.network(
                photo2,
                fit: BoxFit.cover,
              ),
              Image.network(
                photo3,
                fit: BoxFit.cover,
              ),
              Image.network(
                photo4,
                fit: BoxFit.cover,
              ),
              Image.network(
                photo5,
                fit: BoxFit.cover,
              ),
              Image.network(
                photo6,
                fit: BoxFit.cover,
              ),
              Image.network(
                photo7,
                fit: BoxFit.cover,
              ),
              Image.network(
                photo8,
                fit: BoxFit.cover,
              ),
              Image.network(
                photo9,
                fit: BoxFit.cover,
              ),
            ],
          ),
          onTap: () {
            showDialog(
                context: context,
                barrierDismissible: true,
                builder: (BuildContext context) {
                  return SimpleDialog(
                    title: Row(
                      children: [Text('กรุณาเลือกคำสั่ง')],
                    ),
                    children: [
                      SimpleDialogOption(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => FullImage(
                                  photo: photo_array[check_index],
                                ),
                              ));
                        },
                        child: const Text('ดูรูปภาพ'),
                      ),
                      SimpleDialogOption(
                        onPressed: () {
                          firebase_storage.FirebaseStorage.instance
                              .refFromURL(widget.photo1)
                              .delete()
                              .then(
                            (value) {
                              FirebaseFirestore.instance
                                  .collection('place')
                                  .doc(widget.place_id)
                                  .update({'photo1': ''});
                              Navigator.of(context, rootNavigator: true)
                                  .pop('dialog');
                              Toast.show("ลบสำเร็จ", context,
                                  duration: Toast.LENGTH_LONG,
                                  gravity: Toast.BOTTOM);
                            },
                          );
                        },
                        child: const Text('ลบรูปภาพ (1)'),
                      ),
                      SimpleDialogOption(
                        onPressed: () {
                          firebase_storage.FirebaseStorage.instance
                              .refFromURL(widget.photo2)
                              .delete()
                              .then(
                            (value) {
                              FirebaseFirestore.instance
                                  .collection('place')
                                  .doc(widget.place_id)
                                  .update({'photo2': ''});
                              Navigator.of(context, rootNavigator: true)
                                  .pop('dialog');
                              Toast.show("ลบสำเร็จ", context,
                                  duration: Toast.LENGTH_LONG,
                                  gravity: Toast.BOTTOM);
                            },
                          );
                        },
                        child: const Text('ลบรูปภาพ (2)'),
                      ),
                      SimpleDialogOption(
                        onPressed: () {
                          firebase_storage.FirebaseStorage.instance
                              .refFromURL(widget.photo3)
                              .delete()
                              .then(
                            (value) {
                              FirebaseFirestore.instance
                                  .collection('place')
                                  .doc(widget.place_id)
                                  .update({'photo3': ''});
                              Navigator.of(context, rootNavigator: true)
                                  .pop('dialog');
                              Toast.show("ลบสำเร็จ", context,
                                  duration: Toast.LENGTH_LONG,
                                  gravity: Toast.BOTTOM);
                            },
                          );
                        },
                        child: const Text('ลบรูปภาพ (3)'),
                      ),
                      SimpleDialogOption(
                        onPressed: () {
                          firebase_storage.FirebaseStorage.instance
                              .refFromURL(widget.photo4)
                              .delete()
                              .then(
                            (value) {
                              FirebaseFirestore.instance
                                  .collection('place')
                                  .doc(widget.place_id)
                                  .update({'photo4': ''});
                              Navigator.of(context, rootNavigator: true)
                                  .pop('dialog');
                              Toast.show("ลบสำเร็จ", context,
                                  duration: Toast.LENGTH_LONG,
                                  gravity: Toast.BOTTOM);
                            },
                          );
                        },
                        child: const Text('ลบรูปภาพ (4)'),
                      ),
                      SimpleDialogOption(
                        onPressed: () {
                          firebase_storage.FirebaseStorage.instance
                              .refFromURL(widget.photo5)
                              .delete()
                              .then(
                            (value) {
                              FirebaseFirestore.instance
                                  .collection('place')
                                  .doc(widget.place_id)
                                  .update({'photo5': ''});
                              Navigator.of(context, rootNavigator: true)
                                  .pop('dialog');
                              Toast.show("ลบสำเร็จ", context,
                                  duration: Toast.LENGTH_LONG,
                                  gravity: Toast.BOTTOM);
                            },
                          );
                        },
                        child: const Text('ลบรูปภาพ (5)'),
                      ),
                      SimpleDialogOption(
                        onPressed: () {
                          firebase_storage.FirebaseStorage.instance
                              .refFromURL(widget.photo6)
                              .delete()
                              .then(
                            (value) {
                              FirebaseFirestore.instance
                                  .collection('place')
                                  .doc(widget.place_id)
                                  .update({'photo6': ''});
                              Navigator.of(context, rootNavigator: true)
                                  .pop('dialog');
                              Toast.show("ลบสำเร็จ", context,
                                  duration: Toast.LENGTH_LONG,
                                  gravity: Toast.BOTTOM);
                            },
                          );
                        },
                        child: const Text('ลบรูปภาพ (6)'),
                      ),
                      SimpleDialogOption(
                        onPressed: () {
                          firebase_storage.FirebaseStorage.instance
                              .refFromURL(widget.photo7)
                              .delete()
                              .then(
                            (value) {
                              FirebaseFirestore.instance
                                  .collection('place')
                                  .doc(widget.place_id)
                                  .update({'photo7': ''});
                              Navigator.of(context, rootNavigator: true)
                                  .pop('dialog');
                              Toast.show("ลบสำเร็จ", context,
                                  duration: Toast.LENGTH_LONG,
                                  gravity: Toast.BOTTOM);
                            },
                          );
                        },
                        child: const Text('ลบรูปภาพ (7)'),
                      ),
                      SimpleDialogOption(
                        onPressed: () {
                          firebase_storage.FirebaseStorage.instance
                              .refFromURL(widget.photo8)
                              .delete()
                              .then(
                            (value) {
                              FirebaseFirestore.instance
                                  .collection('place')
                                  .doc(widget.place_id)
                                  .update({'photo8': ''});
                              Navigator.of(context, rootNavigator: true)
                                  .pop('dialog');
                              Toast.show("ลบสำเร็จ", context,
                                  duration: Toast.LENGTH_LONG,
                                  gravity: Toast.BOTTOM);
                            },
                          );
                        },
                        child: const Text('ลบรูปภาพ (8)'),
                      ),
                      SimpleDialogOption(
                        onPressed: () {
                          firebase_storage.FirebaseStorage.instance
                              .refFromURL(widget.photo9)
                              .delete()
                              .then(
                            (value) {
                              FirebaseFirestore.instance
                                  .collection('place')
                                  .doc(widget.place_id)
                                  .update({'photo9': ''});
                              Navigator.of(context, rootNavigator: true)
                                  .pop('dialog');
                              Toast.show("ลบสำเร็จ", context,
                                  duration: Toast.LENGTH_LONG,
                                  gravity: Toast.BOTTOM);
                            },
                          );
                        },
                        child: const Text('ลบรูปภาพ (9)'),
                      ),
                    ],
                  );
                });
          });
    } else if (photo8.isNotEmpty) {
      return InkWell(
          child: ImageSlideshow(
            width: double.infinity,
            height: 200,
            initialPage: 0,
            indicatorColor: Colors.blue,
            indicatorBackgroundColor: Colors.grey,
            onPageChanged: (value) {
              check_index = value;
            },
            autoPlayInterval: 6000,
            isLoop: true,
            children: [
              Image.network(
                photo1,
                fit: BoxFit.cover,
              ),
              Image.network(
                photo2,
                fit: BoxFit.cover,
              ),
              Image.network(
                photo3,
                fit: BoxFit.cover,
              ),
              Image.network(
                photo4,
                fit: BoxFit.cover,
              ),
              Image.network(
                photo5,
                fit: BoxFit.cover,
              ),
              Image.network(
                photo6,
                fit: BoxFit.cover,
              ),
              Image.network(
                photo7,
                fit: BoxFit.cover,
              ),
              Image.network(
                photo8,
                fit: BoxFit.cover,
              ),
            ],
          ),
          onTap: () {
            showDialog(
                context: context,
                barrierDismissible: true,
                builder: (BuildContext context) {
                  return SimpleDialog(
                    title: Row(
                      children: [Text('กรุณาเลือกคำสั่ง')],
                    ),
                    children: [
                      SimpleDialogOption(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => FullImage(
                                  photo: photo_array[check_index],
                                ),
                              ));
                        },
                        child: const Text('ดูรูปภาพ'),
                      ),
                      SimpleDialogOption(
                        onPressed: () {
                          firebase_storage.FirebaseStorage.instance
                              .refFromURL(widget.photo1)
                              .delete()
                              .then(
                            (value) {
                              FirebaseFirestore.instance
                                  .collection('place')
                                  .doc(widget.place_id)
                                  .update({'photo1': ''});
                              Navigator.of(context, rootNavigator: true)
                                  .pop('dialog');
                              Toast.show("ลบสำเร็จ", context,
                                  duration: Toast.LENGTH_LONG,
                                  gravity: Toast.BOTTOM);
                            },
                          );
                        },
                        child: const Text('ลบรูปภาพ (1)'),
                      ),
                      SimpleDialogOption(
                        onPressed: () {
                          firebase_storage.FirebaseStorage.instance
                              .refFromURL(widget.photo2)
                              .delete()
                              .then(
                            (value) {
                              FirebaseFirestore.instance
                                  .collection('place')
                                  .doc(widget.place_id)
                                  .update({'photo2': ''});
                              Navigator.of(context, rootNavigator: true)
                                  .pop('dialog');
                              Toast.show("ลบสำเร็จ", context,
                                  duration: Toast.LENGTH_LONG,
                                  gravity: Toast.BOTTOM);
                            },
                          );
                        },
                        child: const Text('ลบรูปภาพ (2)'),
                      ),
                      SimpleDialogOption(
                        onPressed: () {
                          firebase_storage.FirebaseStorage.instance
                              .refFromURL(widget.photo3)
                              .delete()
                              .then(
                            (value) {
                              FirebaseFirestore.instance
                                  .collection('place')
                                  .doc(widget.place_id)
                                  .update({'photo3': ''});
                              Navigator.of(context, rootNavigator: true)
                                  .pop('dialog');
                              Toast.show("ลบสำเร็จ", context,
                                  duration: Toast.LENGTH_LONG,
                                  gravity: Toast.BOTTOM);
                            },
                          );
                        },
                        child: const Text('ลบรูปภาพ (3)'),
                      ),
                      SimpleDialogOption(
                        onPressed: () {
                          firebase_storage.FirebaseStorage.instance
                              .refFromURL(widget.photo4)
                              .delete()
                              .then(
                            (value) {
                              FirebaseFirestore.instance
                                  .collection('place')
                                  .doc(widget.place_id)
                                  .update({'photo4': ''});
                              Navigator.of(context, rootNavigator: true)
                                  .pop('dialog');
                              Toast.show("ลบสำเร็จ", context,
                                  duration: Toast.LENGTH_LONG,
                                  gravity: Toast.BOTTOM);
                            },
                          );
                        },
                        child: const Text('ลบรูปภาพ (4)'),
                      ),
                      SimpleDialogOption(
                        onPressed: () {
                          firebase_storage.FirebaseStorage.instance
                              .refFromURL(widget.photo5)
                              .delete()
                              .then(
                            (value) {
                              FirebaseFirestore.instance
                                  .collection('place')
                                  .doc(widget.place_id)
                                  .update({'photo5': ''});
                              Navigator.of(context, rootNavigator: true)
                                  .pop('dialog');
                              Toast.show("ลบสำเร็จ", context,
                                  duration: Toast.LENGTH_LONG,
                                  gravity: Toast.BOTTOM);
                            },
                          );
                        },
                        child: const Text('ลบรูปภาพ (5)'),
                      ),
                      SimpleDialogOption(
                        onPressed: () {
                          firebase_storage.FirebaseStorage.instance
                              .refFromURL(widget.photo6)
                              .delete()
                              .then(
                            (value) {
                              FirebaseFirestore.instance
                                  .collection('place')
                                  .doc(widget.place_id)
                                  .update({'photo6': ''});
                              Navigator.of(context, rootNavigator: true)
                                  .pop('dialog');
                              Toast.show("ลบสำเร็จ", context,
                                  duration: Toast.LENGTH_LONG,
                                  gravity: Toast.BOTTOM);
                            },
                          );
                        },
                        child: const Text('ลบรูปภาพ (6)'),
                      ),
                      SimpleDialogOption(
                        onPressed: () {
                          firebase_storage.FirebaseStorage.instance
                              .refFromURL(widget.photo7)
                              .delete()
                              .then(
                            (value) {
                              FirebaseFirestore.instance
                                  .collection('place')
                                  .doc(widget.place_id)
                                  .update({'photo7': ''});
                              Navigator.of(context, rootNavigator: true)
                                  .pop('dialog');
                              Toast.show("ลบสำเร็จ", context,
                                  duration: Toast.LENGTH_LONG,
                                  gravity: Toast.BOTTOM);
                            },
                          );
                        },
                        child: const Text('ลบรูปภาพ (7)'),
                      ),
                      SimpleDialogOption(
                        onPressed: () {
                          firebase_storage.FirebaseStorage.instance
                              .refFromURL(widget.photo8)
                              .delete()
                              .then(
                            (value) {
                              FirebaseFirestore.instance
                                  .collection('place')
                                  .doc(widget.place_id)
                                  .update({'photo8': ''});
                              Navigator.of(context, rootNavigator: true)
                                  .pop('dialog');
                              Toast.show("ลบสำเร็จ", context,
                                  duration: Toast.LENGTH_LONG,
                                  gravity: Toast.BOTTOM);
                            },
                          );
                        },
                        child: const Text('ลบรูปภาพ (8)'),
                      ),
                    ],
                  );
                });
          });
    } else if (photo7.isNotEmpty) {
      return InkWell(
          child: ImageSlideshow(
            width: double.infinity,
            height: 200,
            initialPage: 0,
            indicatorColor: Colors.blue,
            indicatorBackgroundColor: Colors.grey,
            onPageChanged: (value) {
              check_index = value;
            },
            autoPlayInterval: 6000,
            isLoop: true,
            children: [
              Image.network(
                photo1,
                fit: BoxFit.cover,
              ),
              Image.network(
                photo2,
                fit: BoxFit.cover,
              ),
              Image.network(
                photo3,
                fit: BoxFit.cover,
              ),
              Image.network(
                photo4,
                fit: BoxFit.cover,
              ),
              Image.network(
                photo5,
                fit: BoxFit.cover,
              ),
              Image.network(
                photo6,
                fit: BoxFit.cover,
              ),
              Image.network(
                photo7,
                fit: BoxFit.cover,
              ),
            ],
          ),
          onTap: () {
            showDialog(
                context: context,
                barrierDismissible: true,
                builder: (BuildContext context) {
                  return SimpleDialog(
                    title: Row(
                      children: [Text('กรุณาเลือกคำสั่ง')],
                    ),
                    children: [
                      SimpleDialogOption(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => FullImage(
                                  photo: photo_array[check_index],
                                ),
                              ));
                        },
                        child: const Text('ดูรูปภาพ'),
                      ),
                      SimpleDialogOption(
                        onPressed: () {
                          firebase_storage.FirebaseStorage.instance
                              .refFromURL(widget.photo1)
                              .delete()
                              .then(
                            (value) {
                              FirebaseFirestore.instance
                                  .collection('place')
                                  .doc(widget.place_id)
                                  .update({'photo1': ''});
                              Navigator.of(context, rootNavigator: true)
                                  .pop('dialog');
                              Toast.show("ลบสำเร็จ", context,
                                  duration: Toast.LENGTH_LONG,
                                  gravity: Toast.BOTTOM);
                            },
                          );
                        },
                        child: const Text('ลบรูปภาพ (1)'),
                      ),
                      SimpleDialogOption(
                        onPressed: () {
                          firebase_storage.FirebaseStorage.instance
                              .refFromURL(widget.photo2)
                              .delete()
                              .then(
                            (value) {
                              FirebaseFirestore.instance
                                  .collection('place')
                                  .doc(widget.place_id)
                                  .update({'photo2': ''});
                              Navigator.of(context, rootNavigator: true)
                                  .pop('dialog');
                              Toast.show("ลบสำเร็จ", context,
                                  duration: Toast.LENGTH_LONG,
                                  gravity: Toast.BOTTOM);
                            },
                          );
                        },
                        child: const Text('ลบรูปภาพ (2)'),
                      ),
                      SimpleDialogOption(
                        onPressed: () {
                          firebase_storage.FirebaseStorage.instance
                              .refFromURL(widget.photo3)
                              .delete()
                              .then(
                            (value) {
                              FirebaseFirestore.instance
                                  .collection('place')
                                  .doc(widget.place_id)
                                  .update({'photo3': ''});
                              Navigator.of(context, rootNavigator: true)
                                  .pop('dialog');
                              Toast.show("ลบสำเร็จ", context,
                                  duration: Toast.LENGTH_LONG,
                                  gravity: Toast.BOTTOM);
                            },
                          );
                        },
                        child: const Text('ลบรูปภาพ (3)'),
                      ),
                      SimpleDialogOption(
                        onPressed: () {
                          firebase_storage.FirebaseStorage.instance
                              .refFromURL(widget.photo4)
                              .delete()
                              .then(
                            (value) {
                              FirebaseFirestore.instance
                                  .collection('place')
                                  .doc(widget.place_id)
                                  .update({'photo4': ''});
                              Navigator.of(context, rootNavigator: true)
                                  .pop('dialog');
                              Toast.show("ลบสำเร็จ", context,
                                  duration: Toast.LENGTH_LONG,
                                  gravity: Toast.BOTTOM);
                            },
                          );
                        },
                        child: const Text('ลบรูปภาพ (4)'),
                      ),
                      SimpleDialogOption(
                        onPressed: () {
                          firebase_storage.FirebaseStorage.instance
                              .refFromURL(widget.photo5)
                              .delete()
                              .then(
                            (value) {
                              FirebaseFirestore.instance
                                  .collection('place')
                                  .doc(widget.place_id)
                                  .update({'photo5': ''});
                              Navigator.of(context, rootNavigator: true)
                                  .pop('dialog');
                              Toast.show("ลบสำเร็จ", context,
                                  duration: Toast.LENGTH_LONG,
                                  gravity: Toast.BOTTOM);
                            },
                          );
                        },
                        child: const Text('ลบรูปภาพ (5)'),
                      ),
                      SimpleDialogOption(
                        onPressed: () {
                          firebase_storage.FirebaseStorage.instance
                              .refFromURL(widget.photo6)
                              .delete()
                              .then(
                            (value) {
                              FirebaseFirestore.instance
                                  .collection('place')
                                  .doc(widget.place_id)
                                  .update({'photo6': ''});
                              Navigator.of(context, rootNavigator: true)
                                  .pop('dialog');
                              Toast.show("ลบสำเร็จ", context,
                                  duration: Toast.LENGTH_LONG,
                                  gravity: Toast.BOTTOM);
                            },
                          );
                        },
                        child: const Text('ลบรูปภาพ (6)'),
                      ),
                      SimpleDialogOption(
                        onPressed: () {
                          firebase_storage.FirebaseStorage.instance
                              .refFromURL(widget.photo7)
                              .delete()
                              .then(
                            (value) {
                              FirebaseFirestore.instance
                                  .collection('place')
                                  .doc(widget.place_id)
                                  .update({'photo7': ''});
                              Navigator.of(context, rootNavigator: true)
                                  .pop('dialog');
                              Toast.show("ลบสำเร็จ", context,
                                  duration: Toast.LENGTH_LONG,
                                  gravity: Toast.BOTTOM);
                            },
                          );
                        },
                        child: const Text('ลบรูปภาพ (7)'),
                      ),
                    ],
                  );
                });
          });
    } else if (photo6.isNotEmpty) {
      return InkWell(
          child: ImageSlideshow(
            width: double.infinity,
            height: 200,
            initialPage: 0,
            indicatorColor: Colors.blue,
            indicatorBackgroundColor: Colors.grey,
            onPageChanged: (value) {
              check_index = value;
            },
            autoPlayInterval: 6000,
            isLoop: true,
            children: [
              Image.network(
                photo1,
                fit: BoxFit.cover,
              ),
              Image.network(
                photo2,
                fit: BoxFit.cover,
              ),
              Image.network(
                photo3,
                fit: BoxFit.cover,
              ),
              Image.network(
                photo4,
                fit: BoxFit.cover,
              ),
              Image.network(
                photo5,
                fit: BoxFit.cover,
              ),
              Image.network(
                photo6,
                fit: BoxFit.cover,
              ),
            ],
          ),
          onTap: () {
            showDialog(
                context: context,
                barrierDismissible: true,
                builder: (BuildContext context) {
                  return SimpleDialog(
                    title: Row(
                      children: [Text('กรุณาเลือกคำสั่ง')],
                    ),
                    children: [
                      SimpleDialogOption(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => FullImage(
                                  photo: photo_array[check_index],
                                ),
                              ));
                        },
                        child: const Text('ดูรูปภาพ'),
                      ),
                      SimpleDialogOption(
                        onPressed: () {
                          firebase_storage.FirebaseStorage.instance
                              .refFromURL(widget.photo1)
                              .delete()
                              .then(
                            (value) {
                              FirebaseFirestore.instance
                                  .collection('place')
                                  .doc(widget.place_id)
                                  .update({'photo1': ''});
                              Navigator.of(context, rootNavigator: true)
                                  .pop('dialog');
                              Toast.show("ลบสำเร็จ", context,
                                  duration: Toast.LENGTH_LONG,
                                  gravity: Toast.BOTTOM);
                            },
                          );
                        },
                        child: const Text('ลบรูปภาพ (1)'),
                      ),
                      SimpleDialogOption(
                        onPressed: () {
                          firebase_storage.FirebaseStorage.instance
                              .refFromURL(widget.photo2)
                              .delete()
                              .then(
                            (value) {
                              FirebaseFirestore.instance
                                  .collection('place')
                                  .doc(widget.place_id)
                                  .update({'photo2': ''});
                              Navigator.of(context, rootNavigator: true)
                                  .pop('dialog');
                              Toast.show("ลบสำเร็จ", context,
                                  duration: Toast.LENGTH_LONG,
                                  gravity: Toast.BOTTOM);
                            },
                          );
                        },
                        child: const Text('ลบรูปภาพ (2)'),
                      ),
                      SimpleDialogOption(
                        onPressed: () {
                          firebase_storage.FirebaseStorage.instance
                              .refFromURL(widget.photo3)
                              .delete()
                              .then(
                            (value) {
                              FirebaseFirestore.instance
                                  .collection('place')
                                  .doc(widget.place_id)
                                  .update({'photo3': ''});
                              Navigator.of(context, rootNavigator: true)
                                  .pop('dialog');
                              Toast.show("ลบสำเร็จ", context,
                                  duration: Toast.LENGTH_LONG,
                                  gravity: Toast.BOTTOM);
                            },
                          );
                        },
                        child: const Text('ลบรูปภาพ (3)'),
                      ),
                      SimpleDialogOption(
                        onPressed: () {
                          firebase_storage.FirebaseStorage.instance
                              .refFromURL(widget.photo4)
                              .delete()
                              .then(
                            (value) {
                              FirebaseFirestore.instance
                                  .collection('place')
                                  .doc(widget.place_id)
                                  .update({'photo4': ''});
                              Navigator.of(context, rootNavigator: true)
                                  .pop('dialog');
                              Toast.show("ลบสำเร็จ", context,
                                  duration: Toast.LENGTH_LONG,
                                  gravity: Toast.BOTTOM);
                            },
                          );
                        },
                        child: const Text('ลบรูปภาพ (4)'),
                      ),
                      SimpleDialogOption(
                        onPressed: () {
                          firebase_storage.FirebaseStorage.instance
                              .refFromURL(widget.photo5)
                              .delete()
                              .then(
                            (value) {
                              FirebaseFirestore.instance
                                  .collection('place')
                                  .doc(widget.place_id)
                                  .update({'photo5': ''});
                              Navigator.of(context, rootNavigator: true)
                                  .pop('dialog');
                              Toast.show("ลบสำเร็จ", context,
                                  duration: Toast.LENGTH_LONG,
                                  gravity: Toast.BOTTOM);
                            },
                          );
                        },
                        child: const Text('ลบรูปภาพ (5)'),
                      ),
                      SimpleDialogOption(
                        onPressed: () {
                          firebase_storage.FirebaseStorage.instance
                              .refFromURL(widget.photo6)
                              .delete()
                              .then(
                            (value) {
                              FirebaseFirestore.instance
                                  .collection('place')
                                  .doc(widget.place_id)
                                  .update({'photo6': ''});
                              Navigator.of(context, rootNavigator: true)
                                  .pop('dialog');
                              Toast.show("ลบสำเร็จ", context,
                                  duration: Toast.LENGTH_LONG,
                                  gravity: Toast.BOTTOM);
                            },
                          );
                        },
                        child: const Text('ลบรูปภาพ (6)'),
                      ),
                    ],
                  );
                });
          });
    } else if (photo5.isNotEmpty) {
      return InkWell(
          child: ImageSlideshow(
            width: double.infinity,
            height: 200,
            indicatorColor: Colors.blue,
            indicatorBackgroundColor: Colors.grey,
            onPageChanged: (value) {
              check_index = value;
            },
            autoPlayInterval: 6000,
            isLoop: true,
            children: [
              Image.network(
                photo1,
                fit: BoxFit.cover,
              ),
              Image.network(
                photo2,
                fit: BoxFit.cover,
              ),
              Image.network(
                photo3,
                fit: BoxFit.cover,
              ),
              Image.network(
                photo4,
                fit: BoxFit.cover,
              ),
              Image.network(
                photo5,
                fit: BoxFit.cover,
              ),
            ],
          ),
          onTap: () {
            showDialog(
                context: context,
                barrierDismissible: true,
                builder: (BuildContext context) {
                  return SimpleDialog(
                    title: Row(
                      children: [Text('กรุณาเลือกคำสั่ง')],
                    ),
                    children: [
                      SimpleDialogOption(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => FullImage(
                                  photo: photo_array[check_index],
                                ),
                              ));
                        },
                        child: const Text('ดูรูปภาพ'),
                      ),
                      SimpleDialogOption(
                        onPressed: () {
                          firebase_storage.FirebaseStorage.instance
                              .refFromURL(widget.photo1)
                              .delete()
                              .then(
                            (value) {
                              FirebaseFirestore.instance
                                  .collection('place')
                                  .doc(widget.place_id)
                                  .update({'photo1': ''});
                              Navigator.of(context, rootNavigator: true)
                                  .pop('dialog');
                              Toast.show("ลบสำเร็จ", context,
                                  duration: Toast.LENGTH_LONG,
                                  gravity: Toast.BOTTOM);
                            },
                          );
                        },
                        child: const Text('ลบรูปภาพ (1)'),
                      ),
                      SimpleDialogOption(
                        onPressed: () {
                          firebase_storage.FirebaseStorage.instance
                              .refFromURL(widget.photo2)
                              .delete()
                              .then(
                            (value) {
                              FirebaseFirestore.instance
                                  .collection('place')
                                  .doc(widget.place_id)
                                  .update({'photo2': ''});
                              Navigator.of(context, rootNavigator: true)
                                  .pop('dialog');
                              Toast.show("ลบสำเร็จ", context,
                                  duration: Toast.LENGTH_LONG,
                                  gravity: Toast.BOTTOM);
                            },
                          );
                        },
                        child: const Text('ลบรูปภาพ (2)'),
                      ),
                      SimpleDialogOption(
                        onPressed: () {
                          firebase_storage.FirebaseStorage.instance
                              .refFromURL(widget.photo3)
                              .delete()
                              .then(
                            (value) {
                              FirebaseFirestore.instance
                                  .collection('place')
                                  .doc(widget.place_id)
                                  .update({'photo3': ''});
                              Navigator.of(context, rootNavigator: true)
                                  .pop('dialog');
                              Toast.show("ลบสำเร็จ", context,
                                  duration: Toast.LENGTH_LONG,
                                  gravity: Toast.BOTTOM);
                            },
                          );
                        },
                        child: const Text('ลบรูปภาพ (3)'),
                      ),
                      SimpleDialogOption(
                        onPressed: () {
                          firebase_storage.FirebaseStorage.instance
                              .refFromURL(widget.photo4)
                              .delete()
                              .then(
                            (value) {
                              FirebaseFirestore.instance
                                  .collection('place')
                                  .doc(widget.place_id)
                                  .update({'photo4': ''});
                              Navigator.of(context, rootNavigator: true)
                                  .pop('dialog');
                              Toast.show("ลบสำเร็จ", context,
                                  duration: Toast.LENGTH_LONG,
                                  gravity: Toast.BOTTOM);
                            },
                          );
                        },
                        child: const Text('ลบรูปภาพ (4)'),
                      ),
                      SimpleDialogOption(
                        onPressed: () {
                          firebase_storage.FirebaseStorage.instance
                              .refFromURL(widget.photo5)
                              .delete()
                              .then(
                            (value) {
                              FirebaseFirestore.instance
                                  .collection('place')
                                  .doc(widget.place_id)
                                  .update({'photo5': ''});
                              Navigator.of(context, rootNavigator: true)
                                  .pop('dialog');
                              Toast.show("ลบสำเร็จ", context,
                                  duration: Toast.LENGTH_LONG,
                                  gravity: Toast.BOTTOM);
                            },
                          );
                        },
                        child: const Text('ลบรูปภาพ (5)'),
                      )
                    ],
                  );
                });
          });
    } else if (photo4.isNotEmpty) {
      return InkWell(
          child: ImageSlideshow(
            width: double.infinity,
            height: 200,
            indicatorColor: Colors.blue,
            indicatorBackgroundColor: Colors.grey,
            onPageChanged: (value) {
              check_index = value;
            },
            autoPlayInterval: 6000,
            isLoop: true,
            children: [
              Image.network(
                photo1,
                fit: BoxFit.cover,
              ),
              Image.network(
                photo2,
                fit: BoxFit.cover,
              ),
              Image.network(
                photo3,
                fit: BoxFit.cover,
              ),
              Image.network(
                photo4,
                fit: BoxFit.cover,
              ),
            ],
          ),
          onTap: () {
            showDialog(
                context: context,
                barrierDismissible: true,
                builder: (BuildContext context) {
                  return SimpleDialog(
                    title: Row(
                      children: [Text('กรุณาเลือกคำสั่ง')],
                    ),
                    children: [
                      SimpleDialogOption(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => FullImage(
                                  photo: photo_array[check_index],
                                ),
                              ));
                        },
                        child: const Text('ดูรูปภาพ'),
                      ),
                      SimpleDialogOption(
                        onPressed: () {
                          firebase_storage.FirebaseStorage.instance
                              .refFromURL(widget.photo1)
                              .delete()
                              .then(
                            (value) {
                              FirebaseFirestore.instance
                                  .collection('place')
                                  .doc(widget.place_id)
                                  .update({'photo1': ''});
                              Navigator.of(context, rootNavigator: true)
                                  .pop('dialog');
                              Toast.show("ลบสำเร็จ", context,
                                  duration: Toast.LENGTH_LONG,
                                  gravity: Toast.BOTTOM);
                            },
                          );
                        },
                        child: const Text('ลบรูปภาพ (1)'),
                      ),
                      SimpleDialogOption(
                        onPressed: () {
                          firebase_storage.FirebaseStorage.instance
                              .refFromURL(widget.photo2)
                              .delete()
                              .then(
                            (value) {
                              FirebaseFirestore.instance
                                  .collection('place')
                                  .doc(widget.place_id)
                                  .update({'photo2': ''});
                              Navigator.of(context, rootNavigator: true)
                                  .pop('dialog');
                              Toast.show("ลบสำเร็จ", context,
                                  duration: Toast.LENGTH_LONG,
                                  gravity: Toast.BOTTOM);
                            },
                          );
                        },
                        child: const Text('ลบรูปภาพ (2)'),
                      ),
                      SimpleDialogOption(
                        onPressed: () {
                          firebase_storage.FirebaseStorage.instance
                              .refFromURL(widget.photo3)
                              .delete()
                              .then(
                            (value) {
                              FirebaseFirestore.instance
                                  .collection('place')
                                  .doc(widget.place_id)
                                  .update({'photo3': ''});
                              Navigator.of(context, rootNavigator: true)
                                  .pop('dialog');
                              Toast.show("ลบสำเร็จ", context,
                                  duration: Toast.LENGTH_LONG,
                                  gravity: Toast.BOTTOM);
                            },
                          );
                        },
                        child: const Text('ลบรูปภาพ (3)'),
                      ),
                      SimpleDialogOption(
                        onPressed: () {
                          firebase_storage.FirebaseStorage.instance
                              .refFromURL(widget.photo4)
                              .delete()
                              .then(
                            (value) {
                              FirebaseFirestore.instance
                                  .collection('place')
                                  .doc(widget.place_id)
                                  .update({'photo4': ''});
                              Navigator.of(context, rootNavigator: true)
                                  .pop('dialog');
                              Toast.show("ลบสำเร็จ", context,
                                  duration: Toast.LENGTH_LONG,
                                  gravity: Toast.BOTTOM);
                            },
                          );
                        },
                        child: const Text('ลบรูปภาพ (4)'),
                      ),
                    ],
                  );
                });
          });
    } else if (photo3.isNotEmpty) {
      return InkWell(
          child: ImageSlideshow(
            width: double.infinity,
            height: 200,
            indicatorColor: Colors.blue,
            indicatorBackgroundColor: Colors.grey,
            onPageChanged: (value) {
              check_index = value;
            },
            autoPlayInterval: 6000,
            isLoop: true,
            children: [
              Image.network(
                photo1,
                fit: BoxFit.cover,
              ),
              Image.network(
                photo2,
                fit: BoxFit.cover,
              ),
              Image.network(
                photo3,
                fit: BoxFit.cover,
              ),
            ],
          ),
          onTap: () {
            showDialog(
                context: context,
                barrierDismissible: true,
                builder: (BuildContext context) {
                  return SimpleDialog(
                    title: Row(
                      children: [Text('กรุณาเลือกคำสั่ง')],
                    ),
                    children: [
                      SimpleDialogOption(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => FullImage(
                                  photo: photo_array[check_index],
                                ),
                              ));
                        },
                        child: const Text('ดูรูปภาพ'),
                      ),
                      SimpleDialogOption(
                        onPressed: () {
                          firebase_storage.FirebaseStorage.instance
                              .refFromURL(widget.photo1)
                              .delete()
                              .then(
                            (value) {
                              FirebaseFirestore.instance
                                  .collection('place')
                                  .doc(widget.place_id)
                                  .update({'photo1': ''});
                              Navigator.of(context, rootNavigator: true)
                                  .pop('dialog');
                              Toast.show("ลบสำเร็จ", context,
                                  duration: Toast.LENGTH_LONG,
                                  gravity: Toast.BOTTOM);
                            },
                          );
                        },
                        child: const Text('ลบรูปภาพ (1)'),
                      ),
                      SimpleDialogOption(
                        onPressed: () {
                          firebase_storage.FirebaseStorage.instance
                              .refFromURL(widget.photo2)
                              .delete()
                              .then(
                            (value) {
                              FirebaseFirestore.instance
                                  .collection('place')
                                  .doc(widget.place_id)
                                  .update({'photo2': ''});
                              Navigator.of(context, rootNavigator: true)
                                  .pop('dialog');
                              Toast.show("ลบสำเร็จ", context,
                                  duration: Toast.LENGTH_LONG,
                                  gravity: Toast.BOTTOM);
                            },
                          );
                        },
                        child: const Text('ลบรูปภาพ (2)'),
                      ),
                      SimpleDialogOption(
                        onPressed: () {
                          firebase_storage.FirebaseStorage.instance
                              .refFromURL(widget.photo3)
                              .delete()
                              .then(
                            (value) {
                              FirebaseFirestore.instance
                                  .collection('place')
                                  .doc(widget.place_id)
                                  .update({'photo3': ''});
                              Navigator.of(context, rootNavigator: true)
                                  .pop('dialog');
                              Toast.show("ลบสำเร็จ", context,
                                  duration: Toast.LENGTH_LONG,
                                  gravity: Toast.BOTTOM);
                            },
                          );
                        },
                        child: const Text('ลบรูปภาพ (3)'),
                      ),
                    ],
                  );
                });
          });
    } else if (photo2.isNotEmpty) {
      return InkWell(
          child: ImageSlideshow(
            width: double.infinity,
            height: 200,
            indicatorColor: Colors.blue,
            indicatorBackgroundColor: Colors.grey,
            onPageChanged: (value) {
              check_index = value;
            },
            autoPlayInterval: 6000,
            isLoop: true,
            children: [
              Image.network(
                photo1,
                fit: BoxFit.cover,
              ),
              Image.network(
                photo2,
                fit: BoxFit.cover,
              ),
            ],
          ),
          onTap: () {
            showDialog(
                context: context,
                barrierDismissible: true,
                builder: (BuildContext context) {
                  return SimpleDialog(
                    title: Row(
                      children: [Text('กรุณาเลือกคำสั่ง')],
                    ),
                    children: [
                      SimpleDialogOption(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => FullImage(
                                  photo: photo_array[check_index],
                                ),
                              ));
                        },
                        child: const Text('ดูรูปภาพ'),
                      ),
                      SimpleDialogOption(
                        onPressed: () {
                          firebase_storage.FirebaseStorage.instance
                              .refFromURL(widget.photo1)
                              .delete()
                              .then(
                            (value) {
                              FirebaseFirestore.instance
                                  .collection('place')
                                  .doc(widget.place_id)
                                  .update({'photo1': ''});
                              Navigator.of(context, rootNavigator: true)
                                  .pop('dialog');
                              Toast.show("ลบสำเร็จ", context,
                                  duration: Toast.LENGTH_LONG,
                                  gravity: Toast.BOTTOM);
                            },
                          );
                        },
                        child: const Text('ลบรูปภาพ (1)'),
                      ),
                      SimpleDialogOption(
                        onPressed: () {
                          firebase_storage.FirebaseStorage.instance
                              .refFromURL(widget.photo2)
                              .delete()
                              .then(
                            (value) {
                              FirebaseFirestore.instance
                                  .collection('place')
                                  .doc(widget.place_id)
                                  .update({'photo2': ''});
                              Navigator.of(context, rootNavigator: true)
                                  .pop('dialog');
                              Toast.show("ลบสำเร็จ", context,
                                  duration: Toast.LENGTH_LONG,
                                  gravity: Toast.BOTTOM);
                            },
                          );
                        },
                        child: const Text('ลบรูปภาพ (2)'),
                      )
                    ],
                  );
                });
          });
    } else if (photo1.isNotEmpty) {
      return InkWell(
          child: ImageSlideshow(
            width: double.infinity,
            height: 200,
            indicatorColor: Colors.blue,
            indicatorBackgroundColor: Colors.grey,
            onPageChanged: (value) {
              check_index = value;
            },
            autoPlayInterval: 6000,
            isLoop: true,
            children: [
              Image.network(
                photo1,
                fit: BoxFit.cover,
              ),
            ],
          ),
          onTap: () {
            showDialog(
                context: context,
                barrierDismissible: true,
                builder: (BuildContext context) {
                  return SimpleDialog(
                    title: Row(
                      children: [Text('กรุณาเลือกคำสั่ง')],
                    ),
                    children: [
                      SimpleDialogOption(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => FullImage(
                                  photo: photo_array[check_index],
                                ),
                              ));
                        },
                        child: const Text('ดูรูปภาพ'),
                      ),
                      SimpleDialogOption(
                        onPressed: () {
                          firebase_storage.FirebaseStorage.instance
                              .refFromURL(widget.photo1)
                              .delete()
                              .then(
                            (value) {
                              FirebaseFirestore.instance
                                  .collection('place')
                                  .doc(widget.place_id)
                                  .update({'photo1': ''});
                              Navigator.of(context, rootNavigator: true)
                                  .pop('dialog');
                              Toast.show("ลบสำเร็จ", context,
                                  duration: Toast.LENGTH_LONG,
                                  gravity: Toast.BOTTOM);
                            },
                          );
                        },
                        child: const Text('ลบรูปภาพ (1)'),
                      ),
                    ],
                  );
                });
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('แก้ไขสถานที่'),
      ),
      body: ListView(
        children: [
          GetPhotoArray(
              widget.photo1,
              widget.photo2,
              widget.photo3,
              widget.photo4,
              widget.photo5,
              widget.photo6,
              widget.photo7,
              widget.photo8,
              widget.photo9,
              widget.photo10),
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
                ? Text("หากคุณต้องการเพิ่มรูป โปรดเลือกรูปของคุณใหม่")
                : Visibility(child: Text(""), visible: true)),
            uploading
                ? Center(
                    child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Container(
                      //   child: Text(
                      //     'uploading...',
                      //     style: TextStyle(fontSize: 20),
                      //   ),
                      // ),
                      // SizedBox(
                      //   height: 10,
                      // ),
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
          // IconButton(
          //     icon: Icon(Icons.delete),
          //     onPressed: () => !uploading ? chooseImage() : null),
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
                    maxLines: 1,
                    autofocus: false,
                    controller: photodetail_Controller,
                    decoration: new InputDecoration(
                      hintText: 'กรุณาใส่ชื่อ',
                    ),
                  ),
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
                  SizedBox(height: 10.0),
                  Text(
                    "หมวดหมู่",
                    style: new TextStyle(fontSize: 16.0),
                  ),
                  Text(
                    "(เลือกได้สูงสุด 5 หมวดหมู่)",
                    style: new TextStyle(fontSize: 13.0),
                  ),
                  SizedBox(height: 10.0),

                  // TextFormField(
                  //   maxLines: 1,
                  //   autofocus: false,
                  //   controller: type_Controller,
                  // ),
                  Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: DropdownButton<String>(
                      // value: dropdownValue,
                      value: widget.type,
                      icon: Icon(Icons.arrow_drop_down),
                      iconSize: 24,
                      elevation: 16,
                      style: TextStyle(color: Colors.black, fontSize: 16),
                      underline: Container(
                        height: 2,
                      ),
                      onChanged: (data) {
                        setState(() {
                          // dropdownValue = data!;
                          widget.type = data!;
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
                  // TextFormField(
                  //   maxLines: 1,
                  //   autofocus: false,
                  //   controller: type2_Controller,
                  // ),
                  Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: DropdownButton<String>(
                      value: widget.type2,
                      icon: Icon(Icons.arrow_drop_down),
                      iconSize: 24,
                      elevation: 16,
                      style: TextStyle(color: Colors.black, fontSize: 16),
                      underline: Container(
                        height: 2,
                      ),
                      onChanged: (data) {
                        setState(() {
                          widget.type2 = data!;
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
                      value: widget.type3,
                      icon: Icon(Icons.arrow_drop_down),
                      iconSize: 24,
                      elevation: 16,
                      style: TextStyle(color: Colors.black, fontSize: 16),
                      underline: Container(
                        height: 2,
                      ),
                      onChanged: (data) {
                        setState(() {
                          widget.type3 = data!;
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
                      value: widget.type4,
                      icon: Icon(Icons.arrow_drop_down),
                      iconSize: 24,
                      elevation: 16,
                      style: TextStyle(color: Colors.black, fontSize: 16),
                      underline: Container(
                        height: 2,
                      ),
                      onChanged: (data) {
                        setState(() {
                          widget.type4 = data!;
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
                      value: widget.type5,
                      icon: Icon(Icons.arrow_drop_down),
                      iconSize: 24,
                      elevation: 16,
                      style: TextStyle(color: Colors.black, fontSize: 16),
                      underline: Container(
                        height: 2,
                      ),
                      onChanged: (data) {
                        setState(() {
                          widget.type5 = data!;
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
                  // TextFormField(
                  //   maxLines: 1,
                  //   autofocus: false,
                  //   controller: type3_Controller,
                  // ),
                  // Padding(
                  //   padding: EdgeInsets.only(left: 10),
                  //   child: DropdownButton<String>(
                  //     value: dropdownValue3,
                  //     icon: Icon(Icons.arrow_drop_down),
                  //     iconSize: 24,
                  //     elevation: 16,
                  //     style: TextStyle(color: Colors.black, fontSize: 18),
                  //     underline: Container(
                  //       height: 2,
                  //     ),
                  //     onChanged: (data) {
                  //       setState(() {
                  //         dropdownValue3 = data!;
                  //       });
                  //     },
                  //     items: business_type3
                  //         .map<DropdownMenuItem<String>>((String value) {
                  //       return DropdownMenuItem<String>(
                  //         value: value,
                  //         child: Text(value, textAlign: TextAlign.center),
                  //       );
                  //     }).toList(),
                  //   ),
                  // ),
                  // TextFormField(
                  //   maxLines: 1,
                  //   autofocus: false,
                  //   controller: type4_Controller,
                  // ),
                  // Padding(
                  //   padding: EdgeInsets.only(left: 10),
                  //   child: DropdownButton<String>(
                  //     value: dropdownValue4,
                  //     icon: Icon(Icons.arrow_drop_down),
                  //     iconSize: 24,
                  //     elevation: 16,
                  //     style: TextStyle(color: Colors.black, fontSize: 18),
                  //     underline: Container(
                  //       height: 2,
                  //     ),
                  //     onChanged: (data) {
                  //       setState(() {
                  //         dropdownValue4 = data!;
                  //       });
                  //     },
                  //     items: business_type4
                  //         .map<DropdownMenuItem<String>>((String value) {
                  //       return DropdownMenuItem<String>(
                  //         value: value,
                  //         child: Text(value, textAlign: TextAlign.center),
                  //       );
                  //     }).toList(),
                  //   ),
                  // ),
                  // TextFormField(
                  //   maxLines: 1,
                  //   autofocus: false,
                  //   controller: type5_Controller,
                  // ),
                  // Padding(
                  //   padding: EdgeInsets.only(left: 10),
                  //   child: DropdownButton<String>(
                  //     value: dropdownValue5,
                  //     icon: Icon(Icons.arrow_drop_down),
                  //     iconSize: 24,
                  //     elevation: 16,
                  //     style: TextStyle(color: Colors.black, fontSize: 18),
                  //     underline: Container(
                  //       height: 2,
                  //     ),
                  //     onChanged: (data) {
                  //       setState(() {
                  //         dropdownValue5 = data!;
                  //       });
                  //     },
                  //     items: business_type5
                  //         .map<DropdownMenuItem<String>>((String value) {
                  //       return DropdownMenuItem<String>(
                  //         value: value,
                  //         child: Text(value, textAlign: TextAlign.center),
                  //       );
                  //     }).toList(),
                  //   ),
                  // ),

                  SizedBox(height: 20.0),
                  Text(
                    "ประเภท",
                    style: new TextStyle(fontSize: 16.0),
                  ),
                  Text(
                    "(เลือกได้สูงสุด 5 ประเภท)",
                    style: new TextStyle(fontSize: 13.0),
                  ),
                  // TextFormField(
                  //   maxLines: 1,
                  //   autofocus: false,
                  //   controller: type6_Controller,
                  // ),
                  SizedBox(height: 10.0),
                  Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: DropdownButton<String>(
                      value: widget.type6,
                      icon: Icon(Icons.arrow_drop_down),
                      iconSize: 24,
                      elevation: 16,
                      style: TextStyle(color: Colors.black, fontSize: 16),
                      underline: Container(
                        height: 2,
                      ),
                      onChanged: (data) {
                        setState(() {
                          widget.type6 = data!;
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
                  // TextFormField(
                  //   maxLines: 1,
                  //   autofocus: false,
                  //   controller: type7_Controller,
                  // ),
                  Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: DropdownButton<String>(
                      value: widget.type7,
                      icon: Icon(Icons.arrow_drop_down),
                      iconSize: 24,
                      elevation: 16,
                      style: TextStyle(color: Colors.black, fontSize: 16),
                      underline: Container(
                        height: 2,
                      ),
                      onChanged: (data) {
                        setState(() {
                          widget.type7 = data!;
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
                  // TextFormField(
                  //   maxLines: 1,
                  //   autofocus: false,
                  //   controller: type8_Controller,
                  // ),
                  Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: DropdownButton<String>(
                      value: widget.type8,
                      icon: Icon(Icons.arrow_drop_down),
                      iconSize: 24,
                      elevation: 16,
                      style: TextStyle(color: Colors.black, fontSize: 16),
                      underline: Container(
                        height: 2,
                      ),
                      onChanged: (data) {
                        setState(() {
                          widget.type8 = data!;
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
                  // TextFormField(
                  //   maxLines: 1,
                  //   autofocus: false,
                  //   controller: type9_Controller,
                  // ),
                  Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: DropdownButton<String>(
                      value: widget.type9,
                      icon: Icon(Icons.arrow_drop_down),
                      iconSize: 24,
                      elevation: 16,
                      style: TextStyle(color: Colors.black, fontSize: 16),
                      underline: Container(
                        height: 2,
                      ),
                      onChanged: (data) {
                        setState(() {
                          widget.type9 = data!;
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
                  // TextFormField(
                  //   maxLines: 1,
                  //   autofocus: false,
                  //   controller: type10_Controller,
                  // ),
                  Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: DropdownButton<String>(
                      value: widget.type10,
                      icon: Icon(Icons.arrow_drop_down),
                      iconSize: 24,
                      elevation: 16,
                      style: TextStyle(color: Colors.black, fontSize: 16),
                      underline: Container(
                        height: 2,
                      ),
                      onChanged: (data) {
                        setState(() {
                          widget.type10 = data!;
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
                    "(ยกตัวอย่างเช่นแปดโมงครึ่งให้กรอก 8.30)",
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
                  SizedBox(height: 10.0),
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
                  SizedBox(height: 10.0),
                  Text(
                    "ที่อยู่สถานที่ 1 (ละติจูด, ลองจิจูด)",
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
                  SizedBox(height: 10.0),
                  Text(
                    "ที่อยู่สถานที่ 2 (ละติจูด, ลองจิจูด)",
                    style: new TextStyle(fontSize: 16.0),
                  ),
                  TextFormField(
                    maxLines: 1,
                    autofocus: false,
                    controller: latitude2_Controller,
                    keyboardType: TextInputType.number,
                    decoration: new InputDecoration(
                        hintText: 'กรุณาใส่ละติจูด ถ้าไม่มีใส่ 0.1'),
                  ),
                  TextFormField(
                    maxLines: 1,
                    autofocus: false,
                    controller: longitude2_Controller,
                    keyboardType: TextInputType.number,
                    decoration: new InputDecoration(
                        hintText: 'กรุณาใส่ลองจิจูด ถ้าไม่มีใส่ 0.1'),
                  ),
                  SizedBox(height: 10.0),
                  Text(
                    "ที่อยู่สถานที่ 3 (ละติจูด, ลองจิจูด)",
                    style: new TextStyle(fontSize: 16.0),
                  ),
                  TextFormField(
                    maxLines: 1,
                    autofocus: false,
                    controller: latitude3_Controller,
                    keyboardType: TextInputType.number,
                    decoration: new InputDecoration(
                        hintText: 'กรุณาใส่ละติจูด ถ้าไม่มีใส่ 0.1'),
                  ),
                  TextFormField(
                    maxLines: 1,
                    autofocus: false,
                    controller: longitude3_Controller,
                    keyboardType: TextInputType.number,
                    decoration: new InputDecoration(
                        hintText: 'กรุณาใส่ลองจิจูด ถ้าไม่มีใส่ 0.1'),
                  ),
                  SizedBox(height: 10.0),
                  Text(
                    "ที่อยู่สถานที่ 4 (ละติจูด, ลองจิจูด)",
                    style: new TextStyle(fontSize: 16.0),
                  ),
                  TextFormField(
                    maxLines: 1,
                    autofocus: false,
                    controller: latitude4_Controller,
                    keyboardType: TextInputType.number,
                    decoration: new InputDecoration(
                        hintText: 'กรุณาใส่ละติจูด ถ้าไม่มีใส่ 0.1'),
                  ),
                  TextFormField(
                    maxLines: 1,
                    autofocus: false,
                    controller: longitude4_Controller,
                    keyboardType: TextInputType.number,
                    decoration: new InputDecoration(
                        hintText: 'กรุณาใส่ลองจิจูด ถ้าไม่มีใส่ 0.1'),
                  ),
                  SizedBox(height: 10.0),
                  Text(
                    "ที่อยู่สถานที่ 5 (ละติจูด, ลองจิจูด)",
                    style: new TextStyle(fontSize: 16.0),
                  ),
                  TextFormField(
                    maxLines: 1,
                    autofocus: false,
                    controller: latitude5_Controller,
                    keyboardType: TextInputType.number,
                    decoration: new InputDecoration(
                        hintText: 'กรุณาใส่ละติจูด ถ้าไม่มีใส่ 0.1'),
                  ),
                  TextFormField(
                    maxLines: 1,
                    autofocus: false,
                    controller: longitude5_Controller,
                    keyboardType: TextInputType.number,
                    decoration: new InputDecoration(
                        hintText: 'กรุณาใส่ลองจิจูด ถ้าไม่มีใส่ 0.1'),
                  ),
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
                        'แก้ไขสถานที่',
                        style: new TextStyle(fontSize: 20.0),
                      ),
                      onPressed: () {
                        uploadFile(context);
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

  Future<void> uploadFile(BuildContext context) async {
    var business_name = business_name_Controller.text.toString();
    var business_name1 = business_name1_Controller.text.toString();
    var business_name2 = business_name2_Controller.text.toString();
    var business_name3 = business_name3_Controller.text.toString();
    var business_name_english =
        business_name_english_Controller.text.toString();
    var day = day_Controller.text.toString();
    var detail = detail_Controller.text.toString();
    var email = email_Controller.text.toString();
    var facebook = facebook_Controller.text.toString();
    var instagram = instagram_Controller.text.toString();
    var line = line_Controller.text.toString();
    var latitude = latitude_Controller.text.toString();
    var longitude = longitude_Controller.text.toString();
    var latitude2 = latitude2_Controller.text.toString();
    var longitude2 = longitude2_Controller.text.toString();
    var latitude3 = latitude3_Controller.text.toString();
    var longitude3 = longitude3_Controller.text.toString();
    var latitude4 = latitude4_Controller.text.toString();
    var longitude4 = longitude4_Controller.text.toString();
    var latitude5 = latitude5_Controller.text.toString();
    var longitude5 = longitude5_Controller.text.toString();
    var price = price_Controller.text.toString();
    var tel = tel_Controller.text.toString();
    var time = time_Controller.text.toString();
    // var type = type_Controller.text.toString();
    var type = widget.type.toString();
    var type2 = widget.type2.toString();
    var type3 = widget.type3.toString();
    var type4 = widget.type4.toString();
    var type5 = widget.type5.toString();
    var type6 = widget.type6.toString();
    var type7 = widget.type7.toString();
    var type8 = widget.type8.toString();
    var type9 = widget.type9.toString();
    var type10 = widget.type10.toString();
    var website = website_Controller.text.toString();
    var photodetail = photodetail_Controller.text.toString();
    var photo1 = photo1_Controller.text.toString();
    var photo2 = photo2_Controller.text.toString();
    var photo3 = photo3_Controller.text.toString();
    var photo4 = photo4_Controller.text.toString();
    var photo5 = photo5_Controller.text.toString();
    var photo6 = photo6_Controller.text.toString();
    var photo7 = photo7_Controller.text.toString();
    var photo8 = photo8_Controller.text.toString();
    var photo9 = photo9_Controller.text.toString();
    var photo10 = photo10_Controller.text.toString();
    var time_open = time_open_Controller.text.toString();
    var time_close = time_close_Controller.text.toString();
    var google_map = google_map_Controller.text.toString();
    var address = address_Controller.text.toString();
    if (validateEmail(email) == false) {
      Toast.show('กรุณาตรวจสอบอีเมลให้ถูกต้อง', context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      return;
    }
    if (email.length > 100) {
      Toast.show("ต้องไม่เกิน 100 ตัว", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      return;
    }
    if (business_name.isEmpty) {
      Toast.show("กรุณาใส่ชื่อสถานที่ของคุณก่อน", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      return;
    }
    if (business_name.length > 50) {
      Toast.show("ชื่อสถานที่ต้องไม่เกิน 50 ตัว", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      return;
    }

    if (business_name1.length > 50) {
      Toast.show("ชื่อสถานที่รอง1ต้องไม่เกิน 50 ตัว", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      return;
    }

    if (business_name2.length > 50) {
      Toast.show("ชื่อสถานที่รอง2ต้องไม่เกิน 50 ตัว", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      return;
    }

    if (business_name3.length > 50) {
      Toast.show("ชื่อสถานที่รอง3ต้องไม่เกิน 50 ตัว", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      return;
    }
    if (business_name_english.length > 50) {
      Toast.show("ชื่อภาษาอังกฤษสถานที่ต้องไม่เกิน 50 ตัว", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      return;
    }
    if (latitude.isEmpty) {
      Toast.show("กรุณาใส่ละติจูดของคุณก่อน", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      return;
    }
    if (longitude.isEmpty) {
      Toast.show("กรุณาใส่ลองจิจูดของคุณก่อน", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      return;
    }
    if (google_map.isEmpty) {
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
    if (tel.isEmpty) {
      Toast.show("กรุณาเบอร์โทรศัพท์ของคุณก่อน", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      return;
    }
    if (tel.length > 15) {
      Toast.show("เบอร์โทรศัพท์ต้องไม่เกิน 15 ตัว", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      return;
    }
    if (day.isEmpty) {
      Toast.show("กรุณาใส่วันเปิดสถานที่ของคุณก่อน", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      return;
    }
    if (day.length > 30) {
      Toast.show("วันเปิด/ปิดทำการต้องไม่เกิน 30 ตัว", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      return;
    }
    if (time.isEmpty) {
      Toast.show("กรุณาใส่เวลา เปิด/ปิด สถานที่ของคุณก่อน", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      return;
    }
    if (time.length > 30) {
      Toast.show("เวลา เปิด/ปิด สถานที่ต้องไม่เกิน 30 ตัว", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      return;
    }
    if (price.length > 30) {
      Toast.show("ช่วงราคาสถานที่ต้องไม่เกิน 30 ตัว", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      return;
    }
    if (address.isEmpty) {
      Toast.show("กรุณาใส่ที่อยู่ของคุณก่อน", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      return;
    }
    if (address.length > 100) {
      Toast.show("ที่อยุ่สถานที่ต้องไม่เกิน 100 ตัว", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      return;
    }
    if (website.length > 100) {
      Toast.show("เว็บไซต์การต้องไม่เกิน 30 ตัว", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      return;
    }
    if (line.length > 100) {
      Toast.show("Line ต้องไม่เกิน 100 ตัว", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      return;
    }
    if (facebook.length > 100) {
      Toast.show("Facebook ต้องไม่เกิน 100 ตัว", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      return;
    }
    if (instagram.length > 100) {
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
    photo10 = photo10_Controller.text.toString();
    photo9 = photo9_Controller.text.toString();
    photo8 = photo8_Controller.text.toString();
    photo7 = photo7_Controller.text.toString();
    photo6 = photo6_Controller.text.toString();
    photo5 = photo5_Controller.text.toString();
    photo4 = photo4_Controller.text.toString();
    photo3 = photo3_Controller.text.toString();
    photo2 = photo2_Controller.text.toString();
    photo1 = photo1_Controller.text.toString();

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

    FirebaseFirestore.instance.collection('place').doc(widget.place_id).update({
      'business_name': business_name,
      'business_name1': business_name1,
      'business_name2': business_name2,
      'business_name3': business_name3,
      'business_name_english': business_name_english,
      'day': day,
      'detail': detail,
      'email': email,
      'facebook': facebook,
      'price': price,
      'instagram': instagram,
      'line': line,
      'latitude': double.parse('$latitude'),
      'longitude': double.parse('$longitude'),
      'latitude2': double.parse('$latitude2'),
      'longitude2': double.parse('$longitude2'),
      'latitude3': double.parse('$latitude3'),
      'longitude3': double.parse('$longitude3'),
      'latitude4': double.parse('$latitude4'),
      'longitude4': double.parse('$longitude4'),
      'latitude5': double.parse('$latitude5'),
      'longitude5': double.parse('$longitude5'),
      'time_open': double.parse('$time_open'),
      'time_close': double.parse('$time_close'),
      'tel': tel,
      'time': time,
      'type': type,
      'type2': type2,
      'type3': type3,
      'type4': type4,
      'type5': type5,
      'type6': type6,
      'type7': type7,
      'type8': type8,
      'type9': type9,
      'type10': type10,
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
      'website': website,
      'photodetail': photodetail,
      'check': false,
      'address': address,
      'map': google_map
    });

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => Launcher2(),
      ),
      (route) => false,
    );
  }
}

bool validateEmail(String email) {
  bool emailValid = RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(email);
  return emailValid;
}

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

List<String> business_type2 = [
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
