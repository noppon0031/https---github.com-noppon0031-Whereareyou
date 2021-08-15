import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'dart:ui';
import 'dart:async';
import 'package:noppon/Business/business_detail.dart';
import 'package:noppon/Business/search.dart';
import 'package:noppon/login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';

class Business_List_User extends StatefulWidget {
  @override
  _Business_List_User createState() => _Business_List_User();
}

class _Business_List_User extends State<Business_List_User> {
  final key = new GlobalKey<ScaffoldState>();
  final TextEditingController _searchQuery = new TextEditingController();
  late bool _IsSearching;
  String _searchText = "";
  String Business_Type = "";
  var user_id, email, password, photo, username, tel, type, type2;

  Widget appBarTitle = Text(
    "สถานที่ทั้งหมด",
    style: new TextStyle(color: Colors.white),
  );

  Icon actionIcon = new Icon(
    Icons.search,
    color: Colors.white,
  );

  _Business_List_User() {
    _searchQuery.addListener(() {
      if (_searchQuery.text.isEmpty) {
        setState(() {
          _IsSearching = false;
          _searchText = "";
        });
      } else {
        setState(() {
          _IsSearching = true;
          _searchText = _searchQuery.text;
          print(_searchText);
          //getFirebase();
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _IsSearching = false;
    Business_Type = "ทั้งหมด";
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      _asyncMethod();
    });
  }

  void _asyncMethod() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      user_id = prefs.getString('user_id');
      email = prefs.getString('email');
      password = prefs.getString('password');
      photo = prefs.getString('photo');
      username = prefs.getString('username');
      tel = prefs.getString('tel');
      type = prefs.getString('type');
    });
  }

  getFirebase() {
    print(_searchText + " " + Business_Type);

    if (_searchText == "") {
      if (Business_Type == "ทั้งหมด") {
        return FirebaseFirestore.instance
            .collection('place')
            .orderBy("array", descending: true)
            .snapshots();
      } else {
        return FirebaseFirestore.instance
            .collection('place')
            .where("type", isEqualTo: Business_Type)
            .snapshots();
      }
    } else {
      return FirebaseFirestore.instance
          .collection('place')
          .orderBy('business_name')
          .startAt([_searchText]).endAt([_searchText + '\uf8ff']).snapshots();

      // .where('type', isEqualTo: Business_Type)
    }
  }

  Text _buildRatingStars(int rating) {
    String stars = '';
    for (int i = 0; i < rating; i++) {
      stars += '⭐ ';
    }
    stars.trim();
    return Text(stars);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: appBarTitle,
          backgroundColor: Colors.red,
          actions: <Widget>[
            new IconButton(
              icon: actionIcon,
              onPressed: () {
                setState(() {
                  if (this.actionIcon.icon == Icons.search) {
                    this.actionIcon = new Icon(
                      Icons.close,
                      color: Colors.white,
                    );
                    this.appBarTitle = new TextField(
                      controller: _searchQuery,
                      style: new TextStyle(
                        color: Colors.white,
                      ),
                      decoration: new InputDecoration(
                          prefixIcon:
                              new Icon(Icons.search, color: Colors.white),
                          hintText: "กรุณาใส่คำค้นหา...",
                          hintStyle: new TextStyle(color: Colors.white)),
                    );
                    _handleSearchStart();
                  } else {
                    _handleSearchEnd();
                  }
                });
              },
            ),
            // InkWell(
            //   onTap: () {},
            //   child: Padding(
            //       padding: const EdgeInsets.symmetric(horizontal: 15),
            //       child: Icon(
            //         Icons.tune,
            //       )),
            // )
          ]),
      body: ListView(
        children: [
          carousel(),
          Container(
            margin: EdgeInsets.all(10),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  InkWell(
                    onTap: () {
                      setState(() {
                        Business_Type = "ทั้งหมด";
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.all(6.0),
                      decoration: BoxDecoration(
                        color: Business_Type == "ทั้งหมด"
                            ? Theme.of(context).accentColor
                            : Colors.grey,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        "ทั้งหมด",
                        style: new TextStyle(color: Colors.white, fontSize: 12),
                      ),
                    ),
                  ),
                  SizedBox(width: 5.0),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (context) => SearchFilters()),
                      );
                      setState(() {
                        Business_Type = "ร้านอาหาร";
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.all(6.0),
                      decoration: BoxDecoration(
                        color: Business_Type == "ร้านอาหาร"
                            ? Theme.of(context).accentColor
                            : Colors.grey,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        "ร้านอาหาร",
                        style: new TextStyle(color: Colors.white, fontSize: 12),
                      ),
                    ),
                  ),
                  SizedBox(width: 5.0),
                  InkWell(
                    onTap: () {
                      setState(() {
                        Business_Type = "ร้านกาแฟ";
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.all(6.0),
                      decoration: BoxDecoration(
                        color: Business_Type == "ร้านกาแฟ"
                            ? Theme.of(context).accentColor
                            : Colors.grey,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        "ร้านกาแฟ",
                        style: new TextStyle(color: Colors.white, fontSize: 12),
                      ),
                    ),
                  ),
                  SizedBox(width: 5.0),
                  InkWell(
                    onTap: () {
                      setState(() {
                        Business_Type = "ร้านเครื่องเขียน";
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.all(6.0),
                      decoration: BoxDecoration(
                        color: Business_Type == "ร้านเครื่องเขียน"
                            ? Theme.of(context).accentColor
                            : Colors.grey,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        "ร้านเครื่องเขียน",
                        style: new TextStyle(color: Colors.white, fontSize: 12),
                      ),
                    ),
                  ),
                  SizedBox(width: 5.0),
                  InkWell(
                    onTap: () {
                      setState(() {
                        Business_Type = "ร้านเสริมสวย";
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.all(6.0),
                      decoration: BoxDecoration(
                        color: Business_Type == "ร้านเสริมสวย"
                            ? Theme.of(context).accentColor
                            : Colors.grey,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        "ร้านเสริมสวย",
                        style: new TextStyle(color: Colors.white, fontSize: 12),
                      ),
                    ),
                  ),
                  SizedBox(width: 5.0),
                  InkWell(
                    onTap: () {
                      setState(() {
                        Business_Type = "คลินิก/ขายยา";
                        print(Business_Type);
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.all(6.0),
                      decoration: BoxDecoration(
                        color: Business_Type == "คลินิก/ขายยา"
                            ? Theme.of(context).accentColor
                            : Colors.grey,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        "คลินิก/ขายยา",
                        style: new TextStyle(color: Colors.white, fontSize: 12),
                      ),
                    ),
                  ),
                  SizedBox(width: 5.0),
                  InkWell(
                    onTap: () {
                      setState(() {
                        Business_Type = "สถานที่ใน Rmutt";
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.all(6.0),
                      decoration: BoxDecoration(
                        color: Business_Type == "สถานที่ใน Rmutt"
                            ? Theme.of(context).accentColor
                            : Colors.grey,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        "สถานที่ใน Rmutt",
                        style: new TextStyle(color: Colors.white, fontSize: 12),
                      ),
                    ),
                  ),
                  SizedBox(width: 5.0),
                  InkWell(
                    onTap: () {
                      setState(() {
                        Business_Type = "สถานที่ทั่วไป";
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.all(6.0),
                      decoration: BoxDecoration(
                        color: Business_Type == "สถานที่ทั่วไป"
                            ? Theme.of(context).accentColor
                            : Colors.grey,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        "สถานที่ทั่วไป",
                        style: new TextStyle(color: Colors.white, fontSize: 12),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (context) => SearchFilters()),
                      );
                    },
                    child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Icon(
                          Icons.tune,
                        )),
                  )
                ],
              ),
            ),
          ),
          StreamBuilder<QuerySnapshot>(
            stream: getFirebase(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                print("No Data");
                return Center(child: Text("ไม่มีข้อมูล"));
              } else
                return ListView(
                  physics: ClampingScrollPhysics(),
                  shrinkWrap: true,
                  children: snapshot.data!.docs.map((doc) {
                    return doc['type'] == Business_Type ||
                            Business_Type == "ทั้งหมด"
                        ? Column(
                            children: <Widget>[
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Business_Detail(
                                              place_id: doc["place_id"],
                                              address: doc["address"],
                                              business_name:
                                                  doc["business_name"],
                                              business_name1:
                                                  doc["business_name1"],
                                              business_name2:
                                                  doc["business_name2"],
                                              business_name3:
                                                  doc["business_name3"],
                                              business_name_english:
                                                  doc["business_name_english"],
                                              day: doc["day"],
                                              detail: doc["detail"],
                                              email: doc["email"],
                                              facebook: doc["facebook"],
                                              instagram: doc["instagram"],
                                              line: doc["line"],
                                              latitude: doc["latitude"],
                                              longitude: doc["longitude"],
                                              map: doc["map"],
                                              photo1: doc["photo1"],
                                              photo2: doc["photo2"],
                                              photo3: doc["photo3"],
                                              photo4: doc["photo4"],
                                              photo5: doc["photo5"],
                                              photo6: doc["photo6"],
                                              photo7: doc["photo7"],
                                              photo8: doc["photo8"],
                                              photo9: doc["photo9"],
                                              photo10: doc["photo10"],
                                              price: doc["price"],
                                              rating: doc["rating"]
                                                  .toStringAsFixed(1),
                                              tel: doc["tel"],
                                              time: doc["time"],
                                              type: doc["type"],
                                              type2: doc["type2"],
                                              user_id: doc["user_id"],
                                              website: doc["website"],
                                            )),
                                  );
                                },
                                child: Container(
                                  margin: EdgeInsets.fromLTRB(5, 0, 5, 5),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                  ),
                                  child: Card(
                                    child: Padding(
                                      padding: EdgeInsets.all(0),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Image.network(
                                            doc["photo1"],
                                            width: double.infinity,
                                            height: 180,
                                            fit: BoxFit.cover,
                                          ),
                                          Row(
                                            children: [
                                              Container(
                                                width: (330),
                                                margin: EdgeInsets.only(top: 8),
                                                child: Text(
                                                  doc["business_name"],
                                                  style: TextStyle(
                                                    fontSize: 16.0,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  maxLines: 2,
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 8.0),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                  "⭐ : " +
                                                      doc["rating"]
                                                          .toStringAsFixed(1) +
                                                      "/5.0",
                                                  style: TextStyle(
                                                      color: Colors.blueGrey,
                                                      fontSize: 16.0)),
                                              Row(
                                                children: [
                                                  Container(
                                                    padding:
                                                        EdgeInsets.all(6.0),
                                                    decoration: BoxDecoration(
                                                      color: Theme.of(context)
                                                          .accentColor,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10.0),
                                                    ),
                                                    alignment: Alignment.center,
                                                    child: Text(
                                                      doc["day"],
                                                      style: new TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 12),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: (10),
                                                  ),
                                                  Container(
                                                    padding:
                                                        EdgeInsets.all(6.0),
                                                    decoration: BoxDecoration(
                                                      color: Theme.of(context)
                                                          .accentColor,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10.0),
                                                    ),
                                                    alignment: Alignment.center,
                                                    child: Text(
                                                      doc["time"],
                                                      style: new TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 12),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: (10),
                                                  ),
                                                  doc["open"] == "true"
                                                      ? Container(
                                                          padding:
                                                              EdgeInsets.all(
                                                                  6.0),
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Colors.green,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10.0),
                                                          ),
                                                          alignment:
                                                              Alignment.center,
                                                          child: Text(
                                                            "เปิด",
                                                            style: new TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 12),
                                                          ),
                                                        )
                                                      : Container(
                                                          padding:
                                                              EdgeInsets.all(
                                                                  6.0),
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Colors.red,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10.0),
                                                          ),
                                                          alignment:
                                                              Alignment.center,
                                                          child: Text(
                                                            "ปิด",
                                                            style: new TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 12),
                                                          ),
                                                        ),
                                                  SizedBox(
                                                    width: 30,
                                                  )
                                                ],
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 10.0),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )
                        : Visibility(child: Text("data"), visible: false);
                  }).toList(),
                );
            },
          ),
        ],
      ),
    );
  }

  void _handleSearchStart() {
    setState(() {
      _IsSearching = true;
    });
  }

  void _handleSearchEnd() {
    setState(() {
      Business_Type = "ทั้งหมด";

      this.actionIcon = new Icon(
        Icons.search,
        color: Colors.white,
      );
      this.appBarTitle = new Text(
        "สถานที่ทั้งหมด",
        style: new TextStyle(color: Colors.white),
      );
      _IsSearching = false;
      _searchText = "";
      print(_searchText);
      _searchQuery.clear();
    });
  }

  Business_Type_List() {
    Row(
      children: <Widget>[
        InkWell(
          onTap: () {
            Business_Type = "ร้านอาหาร";
            print(Business_Type);
          },
          child: Container(
            padding: EdgeInsets.all(6.0),
            decoration: BoxDecoration(
              color: Theme.of(context).accentColor,
              borderRadius: BorderRadius.circular(10.0),
            ),
            alignment: Alignment.center,
            child: Text(
              "ร้านอาหาร",
              style: new TextStyle(color: Colors.white, fontSize: 12),
            ),
          ),
        ),
        SizedBox(width: 10.0),
        InkWell(
          onTap: () {
            Business_Type = "ร้านกาแฟ";
            print(Business_Type);
          },
          child: Container(
            padding: EdgeInsets.all(6.0),
            decoration: BoxDecoration(
              color: Theme.of(context).accentColor,
              borderRadius: BorderRadius.circular(10.0),
            ),
            alignment: Alignment.center,
            child: Text(
              "ร้านกาแฟ",
              style: new TextStyle(color: Colors.white, fontSize: 12),
            ),
          ),
        ),
        SizedBox(width: 10.0),
        Container(
          padding: EdgeInsets.all(6.0),
          decoration: BoxDecoration(
            color: Theme.of(context).accentColor,
            borderRadius: BorderRadius.circular(10.0),
          ),
          alignment: Alignment.center,
          child: Text(
            "ร้านเครื่องเขียน",
            style: new TextStyle(color: Colors.white, fontSize: 12),
          ),
        ),
        SizedBox(width: 10.0),
        Container(
          padding: EdgeInsets.all(6.0),
          decoration: BoxDecoration(
            color: Theme.of(context).accentColor,
            borderRadius: BorderRadius.circular(10.0),
          ),
          alignment: Alignment.center,
          child: Text(
            "คลินิก/ขายยา",
            style: new TextStyle(color: Colors.white, fontSize: 12),
          ),
        ),
        SizedBox(width: 10.0),
        Container(
          padding: EdgeInsets.all(6.0),
          decoration: BoxDecoration(
            color: Theme.of(context).accentColor,
            borderRadius: BorderRadius.circular(10.0),
          ),
          alignment: Alignment.center,
          child: Text(
            "สถานที่ใน Rmutt",
            style: new TextStyle(color: Colors.white, fontSize: 12),
          ),
        ),
        SizedBox(width: 10.0),
        Container(
          padding: EdgeInsets.all(6.0),
          decoration: BoxDecoration(
            color: Theme.of(context).accentColor,
            borderRadius: BorderRadius.circular(10.0),
          ),
          alignment: Alignment.center,
          child: Text(
            "สถานที่ทั่วไป",
            style: new TextStyle(color: Colors.white, fontSize: 12),
          ),
        ),
      ],
    );
  }

  void LogoutMethod(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Row(children: [
            Image.asset(
              'assets/logo.png',
              width: 30,
              height: 30,
              fit: BoxFit.contain,
            ),
            Text('  แจ้งเตือน')
          ]),
          content: Text("คุณต้องการออกจากระบบ ใช่หรือไม่?"),
          actions: <Widget>[
            // ignore: deprecated_member_use
            FlatButton(
              child: Text(
                "ไม่ใช่",
                style: new TextStyle(color: Colors.blue),
              ),
              onPressed: () {
                Navigator.of(context, rootNavigator: true).pop('dialog');
              },
            ),
            // ignore: deprecated_member_use
            FlatButton(
              child: Text(
                "ใช่",
                style: new TextStyle(color: Colors.blue),
              ),
              onPressed: () async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                prefs.clear();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
              },
            ),
          ],
        );
      },
    );
  }

  Widget carousel() {
    return Column(
      children: [
        Container(
          width: double.infinity,
          child: CarouselSlider(
            options: CarouselOptions(
                aspectRatio: 1.99,
                viewportFraction: 0.8,
                autoPlay: true,
                onPageChanged: (index, reason) {
                  print("index");
                }),
            items: [1, 2, 3, 4, 5].map((i) {
              return Builder(
                builder: (BuildContext context) {
                  return Container(
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.symmetric(horizontal: 0),
                    decoration: BoxDecoration(color: Colors.red.shade200),
                    child: Image.asset('assets/logo.png'),
                  );
                },
              );
            }).toList(),
          ),
        )
      ],
    );
  }
}
