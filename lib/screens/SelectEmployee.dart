import 'package:cheers2peers/Tabs/Home.dart';
import 'package:cheers2peers/screens/HomeScreen.dart';
import 'package:cheers2peers/screens/SelectRecognition.dart';
import 'package:flutter/material.dart';
import 'package:cheers2peers/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:cheers2peers/controllers/selectedEmpController.dart';

class SelectEmployee extends StatefulWidget {
  static const routeName = "/select_employee";

  @override
  _SelectEmployeeState createState() => _SelectEmployeeState();
}

class _SelectEmployeeState extends State<SelectEmployee> {
  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;

    final _firestore = FirebaseFirestore.instance;
    String userName;

    String searchString;

    Future getSearchResults(String query) async {}

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pushNamed(context, HomeScreen.routeName);
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
        title: Theme(
          data: Theme.of(context).copyWith(splashColor: Colors.transparent),
          child: Container(
            margin: EdgeInsets.only(
              top: deviceHeight * 0.02,
              bottom: deviceHeight * 0.02,
              right: deviceWidth * 0.1,
            ),
            child: TextFormField(
              cursorColor: Colors.black,
              textAlign: TextAlign.center,
              keyboardType: TextInputType.emailAddress,
              validator: (value) =>
                  value.isEmpty ? 'Email can\'t be empty' : null,
              decoration: KTextFielInputDecor.copyWith(
                hintText: "Select User",
              ),
              onChanged: (String val) {
                setState(() {
                  searchString = val;
                });
              },
              onSaved: (value) => userName = value,
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: StreamBuilder<QuerySnapshot>(
            stream: searchString == null
                ? _firestore.collection('Employees').snapshots()
                : _firestore
                    .collection('Employees')
                    .where(
                      "caseSearch",
                      arrayContains: searchString,
                    )
                    .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Text("Error : ${snapshot.error}");
              }
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                default:
                  return new ListView(
                    children:
                        snapshot.data.docs.map((DocumentSnapshot document) {
                      return GestureDetector(
                        onTap: () {
                          //////////////

                          Get.put(SelectedEmpController()).setName.value.name =
                              document['name'];
                          Get.put(SelectedEmpController()).setJob.value.job =
                              document['job'];
                          Get.put(SelectedEmpController())
                              .setImg
                              .value
                              .imageAddress = document['imgUri'];

                          Navigator.pushNamed(
                              context, SelectRecognition.routeName);
                        },
                        child: Card(
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
                                  borderRadius:
                                      BorderRadius.circular(deviceWidth * 0.2),
                                  child: Container(
                                    color: Colors.black,
                                    width: deviceWidth * 0.16,
                                    height: deviceHeight * 0.08,
                                    child: Image.network(document['imgUri']),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: deviceWidth * 0.05,
                                  ),
                                  child: Column(
                                    children: [
                                      Text(
                                        document['name'],
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(
                                        height: deviceHeight * 0.005,
                                      ),
                                      Text(document['job']),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  );
              }
            },
          ),
        ),
      ),
    );
  }
}
