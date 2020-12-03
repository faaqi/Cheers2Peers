import 'package:cheers2peers/screens/AdminLogin.dart';
import 'package:cheers2peers/screens/EmpLogin.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

class StartScreen extends StatefulWidget {
  static const routeName = "/start-screen";

  @override
  _StartScreenState createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  @override
  void initState() {
    super.initState();

    Firebase.initializeApp();
  }

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: deviceHeight * 0.15),
              child: Container(
                width: deviceWidth * 0.5,
                height: deviceHeight * 0.3,
                child: Image.asset("assets/images/office.png"),
              ),
            ),
            Text(
              "Are you Admin or Employee?",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: deviceWidth * 0.05,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                top: 20.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  FlatButton(
                    color: Colors.orangeAccent,
                    onPressed: () {
                      Navigator.pushNamed(context, AdminLogin.routeName);
                    },
                    child: Text(
                      "   Admin   ",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  FlatButton(
                    color: Colors.green,
                    onPressed: () {
                      Navigator.pushNamed(context, EmpLogin.routeName);
                    },
                    child: Center(
                      child: Text(
                        "Employee",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
