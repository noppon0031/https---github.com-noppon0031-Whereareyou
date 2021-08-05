import 'package:flutter/material.dart';
import 'package:noppon/Business/business_list_user.dart';
import 'package:noppon/Entrepreneur/home.dart';
import 'package:noppon/User/profile.dart';
import 'package:noppon/addddd.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../dropdown.dart';
import '../login.dart';
class Account extends StatefulWidget {
  Account({Key? key}) : super(key: key);

  @override
  _AccountState createState() => _AccountState();
}

LogoutMethod(BuildContext context) async {
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
class _AccountState extends State<Account> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: 100,
          ),
          ProfileMenu(),
          BusinessAdd(),
          Managetest(),
          Logout(),
        ],
      ),
    );
  }
}
class ProfileMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: FlatButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        color: Colors.grey[200],
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Profile()),
          );
        },
        child: Row(
          children: [
            Icon(Icons.account_box),
            SizedBox(width: 20),
            Expanded(
              child:
                  Text("Profile", style: Theme.of(context).textTheme.bodyText1),
            ),
            Icon(Icons.arrow_forward_ios)
          ],
        ),
      ),
    );
  }
}
class BusinessAdd extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: FlatButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        color: Colors.grey[200],
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => HomePage()),
          );
        },
        child: Row(
          children: [
            Icon(Icons.add_business),
            SizedBox(width: 20),
            Expanded(
              child:
                  Text("Manageplace", style: Theme.of(context).textTheme.bodyText1),
            ),
            Icon(Icons.arrow_forward_ios),
          ],
        ),
      ),
    );
  }
}
class Logout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: FlatButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        color: Colors.grey[200],
        onPressed: () {
          LogoutMethod(context);
        },
        child: Row(
          children: [
            Icon(Icons.logout),
            SizedBox(width: 20),
            Expanded(
              child:
                  Text("Logout", style: Theme.of(context).textTheme.bodyText1),
            ),
            Icon(Icons.arrow_forward_ios),
          ],
        ),
      ),
    );
  }
}
class Managetest extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: FlatButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        color: Colors.grey[200],
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Dropdown()),
          );
        },
        child: Row(
          children: [
            Icon(Icons.cabin),
            SizedBox(width: 20),
            Expanded(
              child:
                  Text("Test", style: Theme.of(context).textTheme.bodyText1),
            ),
            Icon(Icons.arrow_forward_ios)
          ],
        ),
      ),
    );
  }
}