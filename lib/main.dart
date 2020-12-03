import 'package:cheers2peers/Tabs/Home.dart';
import 'package:cheers2peers/screens/AdminLogin.dart';
import 'package:cheers2peers/screens/Admin_Dashboard.dart';
import 'package:cheers2peers/screens/EmpLogin.dart';
import 'package:cheers2peers/screens/EmpSignUp.dart';
import 'package:cheers2peers/screens/HomeScreen.dart';
import 'package:cheers2peers/screens/ImageUpload.dart';
import 'package:cheers2peers/screens/Register_profile.dart';
import 'package:cheers2peers/screens/SelectEmployee.dart';
import 'package:cheers2peers/screens/SelectRecognition.dart';
import 'package:cheers2peers/screens/StartScreen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Firebase.initializeApp();
    return MaterialApp(
      title: "Cheers2Peers",
      theme: ThemeData(
          primarySwatch: Colors.green,
          canvasColor: Colors.white,
          visualDensity: VisualDensity.adaptivePlatformDensity),
      debugShowCheckedModeBanner: false,
      home: StartScreen(),
      initialRoute: "/",
      routes: {
        StartScreen.routeName: (ctx) => StartScreen(),
        EmpLogin.routeName: (ctx) => EmpLogin(),
        EmpSignUp.routeName: (ctx) => EmpSignUp(),
        RegisterProfile.routeName: (ctx) => RegisterProfile(),
        HomeScreen.routeName: (ctx) => HomeScreen(),
        AdminLogin.routeName: (ctx) => AdminLogin(),
        AdminDashboard.routeName: (ctx) => AdminDashboard(),
        ImageUpload.routeName: (ctx) => ImageUpload(),
        SelectEmployee.routeName: (ctx) => SelectEmployee(),
        SelectRecognition.routeName: (ctx) => SelectRecognition(),
      },
    );
  }
}
