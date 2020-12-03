import 'package:cheers2peers/screens/StartScreen.dart';
import 'package:flutter/material.dart';
import 'package:cheers2peers/Tabs/Home.dart';
import 'package:cheers2peers/Tabs/Chats.dart';
import 'package:cheers2peers/Tabs/Leaderboard.dart';
import 'package:cheers2peers/Tabs/Profile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:cheers2peers/classes/person.dart';
import 'package:cheers2peers/controllers/EmailController.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = "/home-screen";
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _auth = FirebaseAuth.instance;

  final _firestore = FirebaseFirestore.instance;

  String mail;

  int _currentIndex = 0;
  final List<Widget> _children = [
    Home(),
    Chats(),
    Leaderboard(),
    Profile(),
  ];
  void _onPressed(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () async {
              await _auth.signOut();
              Navigator.pushNamed(context, StartScreen.routeName);
            },
            icon: Icon(
              Icons.person,
              color: Colors.black,
            ),
          ),
        ],
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Container(
          height: deviceHeight * 0.06,
          width: deviceWidth * 0.3,
          child: Image.asset("assets/images/cheers.png"),
        ),
        leading: IconButton(
          color: Colors.black,
          onPressed: () {},
          icon: Icon(
            Icons.menu,
          ),
        ),
      ),
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedItemColor: Colors.green,
        selectedLabelStyle: TextStyle(
          fontWeight: FontWeight.bold,
          fontFamily: 'BalooBhai2',
        ),
        unselectedItemColor: Colors.grey,
        unselectedLabelStyle: TextStyle(
          fontWeight: FontWeight.bold,
          fontFamily: 'BalooBhai2',
        ),
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        onTap: (index) => _onPressed(index),
        elevation: 25,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text(
              "HOME",
              style: TextStyle(
                fontSize: deviceWidth * 0.03,
              ),
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            title: Text(
              "CHATS",
              style: TextStyle(
                fontSize: deviceWidth * 0.03,
              ),
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.equalizer),
            title: Text(
              "LEADERBOARD",
              style: TextStyle(
                fontSize: deviceWidth * 0.03,
              ),
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_pin),
            title: Text(
              "PROFILE",
              style: TextStyle(
                fontSize: deviceWidth * 0.03,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
