import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cheers2peers/controllers/DataController.dart';

class Profile extends StatelessWidget {
  final controller = Get.put(DataController());

  String job = "NA";
  String resImg = null;

  @override
  Widget build(BuildContext context) {
    resImg = controller.setImg.value.imageAddress;
    job = controller.setJob.value.job;
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;
    return Scaffold(
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
                    left: deviceWidth * 0.05,
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
