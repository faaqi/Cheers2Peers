import 'package:cheers2peers/screens/SelectEmployee.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cheers2peers/controllers/selectedEmpController.dart';
import 'package:get/get.dart';
import 'package:cheers2peers/components/RecognitionPointTile.dart';

class SelectRecognition extends StatefulWidget {
  static const routeName = "/select_recognition";

  @override
  _SelectRecognitionState createState() => _SelectRecognitionState();
}

class _SelectRecognitionState extends State<SelectRecognition> {
  final controller = Get.put(SelectedEmpController());

  bool cpressCard = false,
      hpressCard = false,
      lpressCard = false,
      rpressCard = false,
      ppressCard = false;

  @override
  Widget build(BuildContext context) {
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
                    cpressCard ? cpressCard = false : cpressCard = true;
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
                    hpressCard ? hpressCard = false : hpressCard = true;
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
                    lpressCard ? lpressCard = false : lpressCard = true;
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
                    rpressCard ? rpressCard = false : rpressCard = true;
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
                    ppressCard ? ppressCard = false : ppressCard = true;
                  });
                },
              ),
              Spacer(),
              Container(
                width: deviceWidth,
                child: RaisedButton(
                  color: Colors.green,
                  onPressed: () {},
                  child: Padding(
                    padding: EdgeInsets.all(
                      deviceHeight * 0.02,
                    ),
                    child: Text(
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
