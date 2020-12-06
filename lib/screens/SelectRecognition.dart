import 'package:cheers2peers/classes/recognition.dart';
import 'package:cheers2peers/screens/HomeScreen.dart';
import 'package:cheers2peers/screens/SelectEmployee.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cheers2peers/controllers/selectedEmpController.dart';
import 'package:get/get.dart';
import 'package:cheers2peers/components/RecognitionPointTile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cheers2peers/controllers/DataController.dart';
import 'package:intl/intl.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SelectRecognition extends StatefulWidget {
  static const routeName = "/select_recognition";

  @override
  _SelectRecognitionState createState() => _SelectRecognitionState();
}

class _SelectRecognitionState extends State<SelectRecognition> {
  final controller = Get.put(SelectedEmpController());

  DateTime now = new DateTime.now();

  bool loading = false;

  String postT;
  int postP;

  final dataController = Get.put(DataController());

  final _firestore = FirebaseFirestore.instance;

  DateTime time;
  Recognition recog = new Recognition();

  bool cpressCard = false,
      hpressCard = false,
      lpressCard = false,
      rpressCard = false,
      ppressCard = false;

  @override
  Widget build(BuildContext context) {
    time = new DateTime(now.hour, now.minute);

    recog.fromName = dataController.setName.value.name;
    recog.fromEmail = null;
    recog.fromImgAddress = dataController.setImg.value.imageAddress;
    recog.fromJob = dataController.setJob.value.job;

    recog.toName = controller.setName.value.name;
    recog.toEmail = controller.setEmail.value.name;

    recog.postTitle = null;
    recog.likes = 0;
    recog.points = 0;
    recog.time = DateTime.now().toString();

    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pushNamed(context, SelectEmployee.routeName);
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
        title: Text('Select Recognition'),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: deviceWidth * 0.05,
            vertical: deviceHeight * 0.02,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'User',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: deviceWidth * 0.045,
                ),
              ),
              SizedBox(
                height: deviceHeight * 0.01,
              ),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(deviceWidth * 0.2),
                        child: Container(
                          color: Colors.black,
                          width: deviceWidth * 0.16,
                          height: deviceHeight * 0.08,
                          child: Obx(() => Image.network(
                              controller.setImg.value.imageAddress)),
                        ),
                      ),
                      SizedBox(
                        width: deviceWidth * 0.05,
                      ),
                      Column(
                        children: [
                          Obx(() => Text(
                                controller.setName.value.name,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              )),
                          SizedBox(
                            height: deviceHeight * 0.005,
                          ),
                          Obx(() => Text(controller.setJob.value.job)),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: deviceHeight * 0.02,
              ),
              Text(
                'Recognitions',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: deviceWidth * 0.045,
                ),
              ),
              SizedBox(
                height: deviceHeight * 0.03,
              ),
              RecognitionPointTile(
                deviceWidth: deviceWidth,
                title: "Community Work",
                points: "5 Points",
                selected: cpressCard,
                onPress: () {
                  setState(() {
                    if (cpressCard) {
                      cpressCard = false;
                    } else {
                      cpressCard = true;

                      postT = null;
                      postT = "Community Work";
                      postP = 5;

                      hpressCard = false;
                      lpressCard = false;
                      rpressCard = false;
                      ppressCard = false;
                    }
                  });
                },
              ),
              RecognitionPointTile(
                deviceWidth: deviceWidth,
                title: "Helping Hand",
                points: "10 Points",
                selected: hpressCard,
                onPress: () {
                  setState(() {
                    if (hpressCard) {
                      hpressCard = false;
                    } else {
                      hpressCard = true;
                      postT = null;
                      postT = "Helping Hand";
                      postP = 10;

                      cpressCard = false;
                      lpressCard = false;
                      rpressCard = false;
                      ppressCard = false;
                    }
                  });
                },
              ),
              RecognitionPointTile(
                deviceWidth: deviceWidth,
                title: "Leader of the Day",
                points: "30 Points",
                selected: lpressCard,
                onPress: () {
                  setState(() {
                    if (lpressCard) {
                      lpressCard = false;
                    } else {
                      lpressCard = true;
                      postT = null;
                      postT = "Leader of the Day";
                      postP = 30;

                      hpressCard = false;
                      cpressCard = false;
                      rpressCard = false;
                      ppressCard = false;
                    }
                  });
                },
              ),
              RecognitionPointTile(
                deviceWidth: deviceWidth,
                title: "Task Finisher",
                points: "20 Points",
                selected: rpressCard,
                onPress: () {
                  setState(() {
                    if (rpressCard) {
                      rpressCard = false;
                    } else {
                      rpressCard = true;
                      postT = null;
                      postT = "Task Finisher";
                      postP = 20;

                      hpressCard = false;
                      lpressCard = false;
                      cpressCard = false;
                      ppressCard = false;
                    }
                  });
                },
              ),
              RecognitionPointTile(
                deviceWidth: deviceWidth,
                title: "Problem Solver",
                points: "15 Points",
                selected: ppressCard,
                onPress: () {
                  setState(() {
                    if (ppressCard) {
                      ppressCard = false;
                    } else {
                      ppressCard = true;
                      postT = null;
                      postT = "Problem Solver";
                      postP = 15;

                      hpressCard = false;
                      lpressCard = false;
                      rpressCard = false;
                      cpressCard = false;
                    }
                  });
                },
              ),
              Spacer(),
              Container(
                width: deviceWidth,
                child: RaisedButton(
                  color: Colors.green,
                  onPressed: () async {
                    setState(() {
                      loading = true;
                      var firebaseUser = FirebaseAuth.instance.currentUser;
                      try {
                        _firestore.collection('Recognitions').add({
                          'fromName': recog.fromName,
                          'toName': recog.toName,
                          'fromEmail': recog.fromEmail,
                          'toEmail': recog.toEmail,
                          'time': DateTime.now().toString(),
                          'postTitle': postT,
                          'points': postP,
                          'likes': recog.likes,
                          'fromImgAddress': recog.fromImgAddress,
                          'fromJob': recog.fromJob,
                        });

                        Navigator.pushNamed(context, HomeScreen.routeName);
                      } catch (e) {
                        loading = false;
                        print(e);
                      }
                    });

                    print("${recog.toName}  : $postP");

                    QuerySnapshot snapshot = await _firestore
                        .collection('Employees')
                        .where('name', isEqualTo: recog.toName)
                        .get();

                    int prevPoints = snapshot.docs[0].data()['points'];
                    int prevCheers = snapshot.docs[0].data()['cheeredTime'];

                    prevPoints += postP;
                    prevCheers += 1;

                    snapshot.docs.forEach((element) {
                      element.reference.update(<String, dynamic>{
                        'points': prevPoints,
                        'cheeredTime': prevCheers,
                      });
                    });

                    QuerySnapshot fromSnapshot = await _firestore
                        .collection('Employees')
                        .where('name', isEqualTo: recog.fromName)
                        .get();

                    int prevPosts = fromSnapshot.docs[0].data()['posts'];

                    prevPosts += 1;

                    fromSnapshot.docs.forEach((element) {
                      element.reference.update(<String, dynamic>{
                        'posts': prevPosts,
                      });
                    });

//                    selectedDoc = _firestore
//                        .collection('Employees')
//                        .where('name', isEqualTo: recog.toName)
//                        .getDocuments().then((value) => value.docs);
//
//                    print(selectedDoc.toString());
//
//                    await _firestore
//                        .collection("Employees")
//                        .doc(selectedDoc)
//                        .update({
//                      'points': recog.points,
//                      'cheeredTime': 1,
//                    });
                  },
                  child: Padding(
                    padding: EdgeInsets.all(
                      deviceHeight * 0.02,
                    ),
                    child: loading
                        ? CircularProgressIndicator()
                        : Text(
                            'Recognise',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
