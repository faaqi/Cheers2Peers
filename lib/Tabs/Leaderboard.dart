import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class Leaderboard extends StatelessWidget {
  static const routeName = "/leader_tab";
  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;

    final _firestore = FirebaseFirestore.instance;
    return Scaffold(
      appBar: AppBar(
        title: Text('⚡LeaderBoard'),
        backgroundColor: Colors.green,
      ),
      body: SafeArea(
        child: StreamBuilder<QuerySnapshot>(
          stream: _firestore.collection('Employees').snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            final data = snapshot.data.docs;
            List<EmpPointsCard> msgWidgets = [];
            for (var msg in data) {
              final _name = msg.data()['name'];
              final _job = msg.data()['job'];
              final _imgAddress = msg.data()['imgUri'];
              final _points = msg.data()['points'];

              final msgText = EmpPointsCard(
                deviceWidth: deviceWidth,
                deviceHeight: deviceHeight,
                name: _name,
                job: _job,
                points: _points,
                imgUrl: _imgAddress,
              );

              msgWidgets.add(msgText);
              msgWidgets.sort((a, b) => a.points.compareTo(b.points));
            }

            return ListView(
              children: msgWidgets,
              reverse: true,
            );
          },
        ),
      ),
    );
  }
}

class EmpPointsCard extends StatelessWidget {
  EmpPointsCard({
    this.deviceHeight,
    this.deviceWidth,
    this.name,
    this.imgUrl,
    this.job,
    this.points,
  });

  final double deviceWidth;
  final double deviceHeight;
  final String imgUrl, name, job;
  int points;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(
        horizontal: deviceWidth * 0.02,
        vertical: deviceHeight * 0.007,
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: deviceWidth * 0.03,
          vertical: deviceHeight * 0.01,
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(deviceWidth * 0.2),
              child: Container(
                color: Colors.black,
                width: deviceWidth * 0.16,
                height: deviceHeight * 0.08,
                child: Image.network(imgUrl),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: deviceWidth * 0.05,
              ),
              child: Column(
                children: [
                  Text(
                    name,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: deviceHeight * 0.005,
                  ),
                  Text(job),
                ],
              ),
            ),
            Spacer(),
            Text(
              "$points points",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.orangeAccent,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
