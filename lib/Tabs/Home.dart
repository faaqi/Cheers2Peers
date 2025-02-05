import 'package:cheers2peers/screens/SelectEmployee.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cheers2peers/controllers/EmailController.dart';
import 'package:get/get.dart';
import 'package:cheers2peers/screens/StartScreen.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:cheers2peers/classes/person.dart';
import 'package:cheers2peers/controllers/DataController.dart';
import 'package:cheers2peers/components/CheerCard.dart';

class Home extends StatelessWidget {
  static const routeName = "/home_tab";

  final controller = Get.put(DataController());

  bool spinner = false;
  String mail;

  bool dataInserted = false;

  Person personData = new Person();

  final _firestore = FirebaseFirestore.instance;
  final emailController = Get.put(EmailController());

  @override
  Widget build(BuildContext context) {
    mail = emailController.emailString.value.email;
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Color(0xFFececec),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(25.0),
        child: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, SelectEmployee.routeName);
          },
          child: IconButton(
            iconSize: deviceWidth * 0.1,
            icon: Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: EdgeInsets.only(
                top: deviceHeight * 0.02,
                left: deviceWidth * 0.04,
                right: deviceWidth * 0.04,
              ),
              child: Row(
                children: [
                  Text(
                    'Hello there, ',
                    style: TextStyle(
                      fontSize: deviceWidth * 0.06,
                    ),
                  ),
                  Expanded(
                    child: StreamBuilder<QuerySnapshot>(
                      stream: _firestore
                          .collection('Employees')
                          .where("id", isEqualTo: mail)
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return CircularProgressIndicator();
                        } else {
                          final data = snapshot.data.docs;

                          for (var text in data) {
                            Get.find<DataController>().setName.value.name =
                                text.data()['name'];
                            Get.find<DataController>().setDept.value.dept =
                                text.data()['dept'];
                            Get.find<DataController>().setJob.value.job =
                                text.data()['job'];
                            Get.find<DataController>()
                                .setImg
                                .value
                                .imageAddress = text.data()['imgUri'];
                            Get.find<DataController>()
                                .setCheers
                                .value
                                .cheeredTime = text.data()['cheeredTime'];
                            Get.find<DataController>()
                                .setCheerPoints
                                .value
                                .points = text.data()['points'];
                            Get.find<DataController>().setPosts.value.posts =
                                text.data()['posts'];
                          }
                        }

                        return Text(
                          controller.setName.value.name,
                          style: TextStyle(
                            color: Colors.green,
                            fontSize: deviceWidth * 0.06,
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                top: deviceHeight * 0.015,
                left: deviceWidth * 0.03,
                right: deviceWidth * 0.03,
              ),
              child: Card(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: deviceHeight * 0.01,
                        horizontal: deviceWidth * 0.05,
                      ),
                      child: Text(
                        "How are you feeling today?",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: deviceWidth * 0.1,
                        vertical: deviceHeight * 0.008,
                      ),
                      child: RatingBar.builder(
                        itemSize: deviceWidth * 0.14,
                        glow: true,
                        initialRating: 3,
                        itemCount: 5,
                        itemBuilder: (context, index) {
                          switch (index) {
                            case 0:
                              return Icon(
                                Icons.sentiment_very_dissatisfied,
                                color: Colors.red,
                              );
                            case 1:
                              return Icon(
                                Icons.sentiment_dissatisfied,
                                color: Colors.redAccent,
                              );
                            case 2:
                              return Icon(
                                Icons.sentiment_neutral,
                                color: Colors.amber,
                              );
                            case 3:
                              return Icon(
                                Icons.sentiment_satisfied,
                                color: Colors.lightGreen,
                              );
                            case 4:
                              return Icon(
                                Icons.sentiment_very_satisfied,
                                color: Colors.green,
                              );
                          }
                          return CircularProgressIndicator();
                        },
                        onRatingUpdate: (rating) {
                          print(rating);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                top: deviceHeight * 0.01,
                left: deviceWidth * 0.06,
              ),
              child: Text(
                "Recognitions",
                style: TextStyle(
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                  fontSize: deviceWidth * 0.05,
                ),
              ),
            ),
            StreamBuilder<QuerySnapshot>(
              stream: _firestore.collection('Recognitions').snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  print("Snapshot rcvd");
                  final data = snapshot.data.docs;
                  List<CheerCard> cheerPosts = [];

                  for (var text in data) {
                    final _postTitle = text.data()['postTitle'];
                    final _fromImgAddress = text.data()['fromImgAddress'];
                    final _fromName = text.data()['fromName'];
                    final _fromJob = text.data()['fromJob'];
                    final _time = text.data()['time'];
                    final _toName = text.data()['toName'];
                    final _likes = text.data()['likes'];
                    final _points = text.data()['points'];

                    print(cheerPosts.toString());

                    final cheerCardWiget = CheerCard(
                      deviceWidth: deviceWidth,
                      deviceHeight: deviceHeight,
                      fromImgAddress: _fromImgAddress,
                      fromName: _fromName,
                      fromJob: _fromJob,
                      toName: _toName,
                      postTitle: _postTitle,
                      points: _points,
                      likes: _likes,
                      time: _time,
                    );
                    cheerPosts.add(cheerCardWiget);
                    cheerPosts.sort((a, b) => DateTime.parse(b.time)
                        .compareTo(DateTime.parse(a.time)));
                  }
                  return Container(
                    height: deviceHeight * 0.6,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 3.0,
                      ),
                      child: ListView(
                        children: cheerPosts,
                      ),
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
