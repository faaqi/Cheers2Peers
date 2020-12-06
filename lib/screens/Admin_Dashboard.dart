import 'package:cheers2peers/Tabs/Leaderboard.dart';
import 'package:cheers2peers/screens/SelectEmployee.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:cheers2peers/screens/StartScreen.dart';
import 'package:cheers2peers/components/rounded_button.dart';

class AdminDashboard extends StatefulWidget {
  static const routeName = "/admin-dashboard";
  @override
  _AdminDashboardState createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  final _auth = FirebaseAuth.instance;
  bool spinner = false;

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Dashboard"),
        leading: Icon(
          Icons.menu,
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.person_pin,
            ),
            onPressed: () async {
              setState(() {
                spinner = true;
              });
              await _auth.signOut();
              Navigator.pushNamed(context, StartScreen.routeName);
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.symmetric(
                horizontal: deviceWidth * 0.1,
                vertical: deviceHeight * 0.05,
              ),
              child: Image.asset("assets/images/office.png"),
            ),
            RoundedButton(
              color: Colors.green,
              onPressed: () {
                Navigator.pushNamed(context, SelectEmployee.routeName);
              },
              title: "View Employees",
            ),
            RoundedButton(
              color: Colors.green,
              onPressed: () {
                Navigator.pushNamed(context, Leaderboard.routeName);
              },
              title: "View Leaderboard",
            ),
          ],
        ),
      ),
    );
  }
}
