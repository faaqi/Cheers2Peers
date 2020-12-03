import 'package:cheers2peers/screens/HomeScreen.dart';
import 'package:cheers2peers/screens/ImageUpload.dart';
import 'package:cheers2peers/screens/StartScreen.dart';
import 'package:flutter/material.dart';
import 'package:cheers2peers/components/rounded_button.dart';
import 'package:cheers2peers/constants.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:cheers2peers/controllers/ImageController.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:cheers2peers/classes/person.dart';
import 'package:cheers2peers/controllers/EmailController.dart';

class RegisterProfile extends StatefulWidget {
  static const routeName = "/register-profile";

  @override
  _RegisterProfileState createState() => _RegisterProfileState();
}

class _RegisterProfileState extends State<RegisterProfile> {
  final controller = Get.put(ImageController());

  final emailController = Get.put(EmailController());

  final formKey = GlobalKey<FormState>();

  String name, department, jobPosition;

  String url;

  List<String> caseSearchList;

  bool spinner = false;

  int colorButton = 0xFF39B7CD;

  File resImg;

  final _firestore = FirebaseFirestore.instance;

  Person personData = new Person();

  bool validateAndSave() {
    final form = formKey.currentState;

    if (form.validate()) {
      form.save();
      return true;
    } else {
      return false;
    }
  }

  setSearchParam(String caseNumber) {
    List<String> caseSearchList = List();
    String temp = "";
    for (int i = 0; i < caseNumber.length; i++) {
      temp = temp + caseNumber[i];
      caseSearchList.add(temp);
    }
    return caseSearchList;
  }

  @override
  void initState() {
    super.initState();

    print(emailController.emailString.value.email);
  }

  @override
  Widget build(BuildContext context) {
    resImg = controller.imageData.value.shopImgFile;

    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pushNamed(context, StartScreen.routeName);
          },
          icon: Icon(
            Icons.arrow_back,
          ),
        ),
        title: Text('Complete your Profile'),
      ),
      body: ModalProgressHUD(
        inAsyncCall: spinner,
        child: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.symmetric(
                vertical: deviceHeight * 0.05,
                horizontal: deviceWidth * 0.08,
              ),
              child: Card(
                color: Colors.green,
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      Center(
                        child: Padding(
                          padding: EdgeInsets.only(
                            top: deviceHeight * 0.03,
                          ),
                          child: ClipRRect(
                            borderRadius:
                                BorderRadius.circular(deviceWidth * 0.2),
                            child: Container(
                              color: Colors.white,
                              width: deviceWidth * 0.4,
                              height: deviceHeight * 0.2,
                              child: resImg == null
                                  ? Image.asset("assets/images/profile.png")
                                  : Obx(() => Image.file(
                                      controller.imageData.value.shopImgFile)),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: 5.0,
                          horizontal: deviceWidth * 0.26,
                        ),
                        child: RoundedButton(
                          title: "Upload",
                          color: Color(0xFF0c3587),
                          onPressed: () {
                            Navigator.pushNamed(context, ImageUpload.routeName);
                          },
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(
                          vertical: deviceHeight * 0.02,
                          horizontal: deviceWidth * 0.08,
                        ),
                        child: Theme(
                          data: Theme.of(context)
                              .copyWith(splashColor: Colors.transparent),
                          child: TextFormField(
                            cursorColor: Colors.black,
                            textAlign: TextAlign.center,
                            keyboardType: TextInputType.text,
                            validator: (value) =>
                                value.isEmpty ? 'Name can\'t be empty' : null,
                            decoration: KTextFielInputDecor.copyWith(
                              hintText: "Enter your Name",
                            ),
                            onSaved: (value) => name = value,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(
                          vertical: deviceHeight * 0.02,
                          horizontal: deviceWidth * 0.08,
                        ),
                        child: Theme(
                          data: Theme.of(context)
                              .copyWith(splashColor: Colors.transparent),
                          child: TextFormField(
                            cursorColor: Colors.black,
                            textAlign: TextAlign.center,
                            keyboardType: TextInputType.text,
                            validator: (value) =>
                                value.isEmpty ? 'Name can\'t be empty' : null,
                            decoration: KTextFielInputDecor.copyWith(
                              hintText: "Enter department Name",
                            ),
                            onSaved: (value) => department = value,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(
                          vertical: deviceHeight * 0.02,
                          horizontal: deviceWidth * 0.08,
                        ),
                        child: Theme(
                          data: Theme.of(context)
                              .copyWith(splashColor: Colors.transparent),
                          child: TextFormField(
                            cursorColor: Colors.black,
                            textAlign: TextAlign.center,
                            keyboardType: TextInputType.text,
                            validator: (value) =>
                                value.isEmpty ? 'Name can\'t be empty' : null,
                            decoration: KTextFielInputDecor.copyWith(
                              hintText: "Enter your Job Designation",
                            ),
                            onSaved: (value) => jobPosition = value,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: deviceWidth * 0.2,
                          vertical: deviceHeight * 0.01,
                        ),
                        child: RoundedButton(
                          title: "Done",
                          color: Color(0xFF0c3587),
                          onPressed: () async {
                            if (validateAndSave()) {
                              print("$name : $department");
                              ///////////////////

                              caseSearchList = setSearchParam(name);

                              print(caseSearchList);

                              final FirebaseStorage storage =
                                  FirebaseStorage(storageBucket: storageRefURL);
                              String filePath =
                                  'shopImages/${DateTime.now()}.png';

                              try {
                                Reference str = storage.ref(filePath);

                                setState(() {
                                  spinner = true;
                                });

                                await str.putFile(resImg).then((val) => val.ref
                                    .getDownloadURL()
                                    .then((value) => url = value));

                                print(url);
                              } catch (e) {
                                print(e);
                              }

                              personData.imageAddress = url;

                              _firestore.collection('Employees').add({
                                'name': name,
                                'dept': department,
                                'job': jobPosition,
                                'imgUri': personData.imageAddress,
                                'id': emailController.emailString.value.email,
                                'points': personData.points,
                                'cheeredTime': personData.cheeredTime,
                                'posts': personData.posts,
                                'caseSearch': caseSearchList,
                              });

                              Navigator.pushNamed(
                                  context, HomeScreen.routeName);
                              //////////////////////
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
