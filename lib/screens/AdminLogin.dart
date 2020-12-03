import 'package:cheers2peers/screens/Admin_Dashboard.dart';
import 'package:flutter/material.dart';
import 'package:cheers2peers/constants.dart';
import 'package:cheers2peers/components/rounded_button.dart';
import 'package:cheers2peers/screens/EmpLogin.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class AdminLogin extends StatefulWidget {
  static const routeName = "/admin-login";

  @override
  _AdminLoginState createState() => _AdminLoginState();
}

class _AdminLoginState extends State<AdminLogin> {
  final formKey = GlobalKey<FormState>();

  String userName, password;

  bool spinner = false;

  final _auth = FirebaseAuth.instance;

  bool validateAndSave() {
    final form = formKey.currentState;

    if (form.validate()) {
      form.save();
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: ModalProgressHUD(
        inAsyncCall: spinner,
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  width: deviceWidth * 0.3,
                  margin: EdgeInsets.only(
                    top: deviceHeight * 0.12,
                  ),
                  child: Image.asset("assets/images/cheers.png"),
                ),
                Container(
                  margin: EdgeInsets.only(
                    top: deviceWidth * 0.15,
                    left: deviceWidth * 0.08,
                    right: deviceWidth * 0.08,
                  ),
                  child: Card(
                    color: Colors.green,
                    child: Form(
                      key: formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Container(
                            margin: EdgeInsets.only(
                              top: deviceHeight * 0.03,
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              "Admin Login",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: deviceWidth * 0.05,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              top: deviceHeight * 0.1,
                              left: deviceWidth * 0.04,
                              right: deviceWidth * 0.04,
                            ),
                            child: Theme(
                              data: Theme.of(context)
                                  .copyWith(splashColor: Colors.transparent),
                              child: TextFormField(
                                cursorColor: Colors.black,
                                textAlign: TextAlign.center,
                                keyboardType: TextInputType.emailAddress,
                                validator: (value) => value.isEmpty
                                    ? 'Email can\'t be empty'
                                    : null,
                                decoration: KTextFielInputDecor,
                                onSaved: (value) => userName = value,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              top: deviceHeight * 0.03,
                              left: deviceWidth * 0.04,
                              right: deviceWidth * 0.04,
                            ),
                            child: Theme(
                              data: Theme.of(context)
                                  .copyWith(splashColor: Colors.transparent),
                              child: TextFormField(
                                obscureText: true,
                                cursorColor: Colors.black,
                                textAlign: TextAlign.center,
                                keyboardType: TextInputType.emailAddress,
                                validator: (value) => value.isEmpty
                                    ? 'Password can\'t be empty'
                                    : null,
                                decoration: KTextFielInputDecor.copyWith(
                                    hintText: 'Enter your Password'),
                                onSaved: (value) => password = value,
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(
                              left: deviceWidth * 0.25,
                              right: deviceWidth * 0.25,
                              top: deviceHeight * 0.06,
                            ),
                            child: RoundedButton(
                              title: "LOGIN",
                              color: Color(0xFF0c3587),
                              onPressed: () async {
                                if (validateAndSave()) {
                                  try {
                                    final user =
                                        await _auth.signInWithEmailAndPassword(
                                            email: userName,
                                            password: password);

                                    if (user != null) {
                                      Navigator.pushNamed(
                                          context, AdminDashboard.routeName);
                                    }
                                    setState(() {
                                      spinner = true;
                                    });
                                  } catch (e) {
                                    print(e);
                                  }

//                                  Navigator.pushNamed(
//                                      context, AdminDashboard.routeName);
                                } else {
                                  setState(() {
                                    spinner = false;
                                  });
                                  print('Validation Faled.');
                                }
                              },
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(
                              vertical: deviceHeight * 0.02,
                            ),
                            child: Center(
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, EmpLogin.routeName);
                                },
                                child: Text(
                                  "Are You an Employee?",
                                  style: TextStyle(
                                    color: Color(0xFF0c3587),
                                    fontSize: deviceWidth * 0.035,
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
