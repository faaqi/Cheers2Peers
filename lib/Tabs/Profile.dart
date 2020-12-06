import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cheers2peers/controllers/DataController.dart';
import 'package:cheers2peers/components/CheerCard.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Profile extends StatelessWidget {
  final controller = Get.put(DataController());
  final _firestore = FirebaseFirestore.instance;
  String job = "NA";
  String resImg = null;

  @override
  Widget build(BuildContext context) {
    resImg = controller.setImg.value.imageAddress;
    job = controller.setJob.value.job;
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Color(0xFFececec),
      body: Column(
        children: [
          Card(
            child: Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    left: deviceWidth * 0.06,
                    top: deviceHeight * 0.02,
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                        height: deviceHeight * 0.02,
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(deviceWidth * 0.2),
                        child: Container(
                          color: Colors.black,
                          width: deviceWidth * 0.25,
                          height: deviceHeight * 0.12,
                          child: resImg == null
                              ? Image.asset("assets/images/profile.png")
                              : Image.network(resImg),
                        ),
                      ),
                      SizedBox(
                        height: deviceHeight * 0.02,
                      ),
                      Text(
                        controller.setName.value.name,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: deviceWidth * 0.04,
                        ),
                      ),
                      SizedBox(
                        height: deviceHeight * 0.01,
                      ),
                      Text(
                        job,
                        style: TextStyle(
                          fontSize: deviceWidth * 0.04,
                        ),
                      ),
                      SizedBox(
                        height: deviceHeight * 0.02,
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                    left: deviceWidth * 0.1,
                    bottom: deviceHeight * 0.04,
                  ),
                  child: ProfilePoints(
                    title: "Cheers",
                    pointers: controller.setCheers.value.cheeredTime,
                    deviceWidth: deviceWidth,
                    deviceHeight: deviceHeight,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                    left: deviceWidth * 0.06,
                    bottom: deviceHeight * 0.04,
                  ),
                  child: ProfilePoints(
                    title: "Points",
                    pointers: controller.setCheerPoints.value.points,
                    deviceWidth: deviceWidth,
                    deviceHeight: deviceHeight,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                    left: deviceWidth * 0.06,
                    bottom: deviceHeight * 0.04,
                  ),
                  child: ProfilePoints(
                    title: "Posts",
                    pointers: controller.setPosts.value.posts,
                    deviceWidth: deviceWidth,
                    deviceHeight: deviceHeight,
                  ),
                ),
              ],
            ),
          ),
          Card(
            color: Colors.green,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Recognitions",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: deviceWidth * 0.04,
                ),
              ),
            ),
          ),
          StreamBuilder<QuerySnapshot>(
            stream: _firestore
                .collection('Recognitions')
                .where(
                  "fromName",
                  isEqualTo: controller.setName.value.name,
                )
                .snapshots(),
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
                  cheerPosts.sort((a, b) =>
                      DateTime.parse(b.time).compareTo(DateTime.parse(a.time)));
                }
                return Container(
                  height: deviceHeight * 0.5,
                  child: Padding(
                    padding: EdgeInsets.all(5.0),
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
    );
  }
}

class ProfilePoints extends StatelessWidget {
  ProfilePoints({
    this.title,
    this.pointers,
    this.deviceHeight,
    this.deviceWidth,
  });

  final double deviceWidth;
  final double deviceHeight;
  final int pointers;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "$pointers",
          style: TextStyle(
            color: Colors.orangeAccent,
            fontWeight: FontWeight.bold,
            fontSize: deviceWidth * 0.05,
          ),
        ),
        SizedBox(
          height: deviceHeight * 0.01,
        ),
        Text(
          "$title",
          style: TextStyle(
            fontSize: deviceWidth * 0.035,
          ),
        ),
      ],
    );
  }
}
