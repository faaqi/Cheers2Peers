import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:cheers2peers/screens/StartScreen.dart';

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
      body: ModalProgressHUD(
        inAsyncCall: spinner,
        child: Center(
          child: Text("Dashboar"),
        ),
      ),
    );
  }
}
