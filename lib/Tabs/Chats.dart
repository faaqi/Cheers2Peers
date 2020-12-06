import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cheers2peers/constants.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:google_sign_in/google_sign_in.dart';
import 'package:get/get.dart';
import 'package:cheers2peers/controllers/DataController.dart';

final _firestore = FirebaseFirestore.instance;
User currUser;

class Chats extends StatefulWidget {
  static const String id = 'chat_screen';

  @override
  _ChatsState createState() => _ChatsState();
}

class _ChatsState extends State<Chats> {
  final msgTextController = TextEditingController();

  final controller = Get.put(DataController());

  final _auth = FirebaseAuth.instance;

  bool spinner = false;
  String msg;

  Future<User> getCurrUSer() async {
    try {
      final user = await _auth.currentUser;
      if (user != null) {
        currUser = user;
        print(currUser.email);
      }
      return user;
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();

    getCurrUSer();
  }

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        leading: null,
        title: Text('⚡Group Chat'),
        backgroundColor: Colors.green,
      ),
      body: ModalProgressHUD(
        inAsyncCall: false,
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              MsgStreamBuild(),
              Container(
                decoration: kMessageContainerDecoration,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: TextField(
                          controller: msgTextController,
                          onChanged: (value) {
                            msg = value;
                          },
                          decoration: kMessageTextFieldDecoration,
                        ),
                      ),
                    ),
                    FlatButton(
                      child: Text(
                        'Send',
                        style: kSendButtonTextStyle,
                      ),
                      onPressed: () {
                        msgTextController.clear();

                        String time = DateTime.now().toString();

                        _firestore.collection('chats').add({
                          'Text': msg,
                          'Img': controller.setImg.value.imageAddress,
                          'Sender': controller.setName.value.name,
                          'Time': time
                        });
                      },
                    ),
                  ],
                ),
              ),
              Container(
                color: Colors.green,
                height: deviceHeight * 0.003,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MsgStreamBuild extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;
    final controller = Get.put(DataController());

    return StreamBuilder<QuerySnapshot>(
      stream: _firestore.collection('chats').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        final messages = snapshot.data.docs.reversed;
        List<MessageBubble> msgWidgets = [];
        for (var msg in messages) {
          final text = msg.data()['Text'];
          final sender = msg.data()['Sender'];
          final time = msg.data()['Time'];
          final isMe = sender;
          final img = msg.data()['Img'];

          //  String formattedTime =DateFormat.jm().format(DateTime.parse(time));
          // print(formattedTime);

          final msgText = MessageBubble(
            text: text,
            sender: sender,
            isMe: isMe == controller.setName.value.name,
            time: time,
            deviceHeight: deviceHeight,
            deviceWidth: deviceWidth,
            Img: img,
          );
          msgWidgets.add(msgText);
          msgWidgets.sort((a, b) =>
              DateTime.parse(b.time).compareTo(DateTime.parse(a.time)));
        }

        return Expanded(
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: ListView(
              reverse: true,
              children: msgWidgets,
            ),
          ),
        );
      },
    );
  }
}

class MessageBubble extends StatelessWidget {
  MessageBubble(
      {this.text,
      this.sender,
      this.isMe,
      this.time,
      this.Img,
      this.deviceWidth,
      this.deviceHeight});
  final String text;
  final String sender;
  final bool isMe;
  final String time;
  final String Img;
  final double deviceWidth;
  final double deviceHeight;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(18.0),
      child: Column(
        crossAxisAlignment:
            isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Text(
            '$sender',
            style: TextStyle(
              color: Colors.green,
            ),
          ),
          SizedBox(
            height: 5.0,
          ),
          Material(
            borderRadius: isMe
                ? BorderRadius.only(
                    topLeft: Radius.circular(30.0),
                    bottomLeft: Radius.circular(30.0),
                    bottomRight: Radius.circular(30.0))
                : BorderRadius.only(
                    topRight: Radius.circular(30.0),
                    bottomLeft: Radius.circular(30.0),
                    bottomRight: Radius.circular(30.0)),
            color: isMe ? Colors.green : Colors.deepOrangeAccent,
            child: Padding(
              padding: EdgeInsets.all(10.0),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  isMe
                      ? Text("")
                      : ClipRRect(
                          borderRadius: BorderRadius.circular(
                            deviceWidth * 0.2,
                          ),
                          child: Container(
                            color: Colors.black,
                            width: deviceWidth * 0.1,
                            height: deviceHeight * 0.05,
                            child: Image.network(Img),
                          ),
                        ),
                  SizedBox(
                    width: deviceWidth * 0.05,
                  ),
                  Expanded(
                    child: Text(
                      '$text',
                      style: TextStyle(fontSize: 15.0, color: Colors.white),
                    ),
                  ),
                  SizedBox(
                    width: deviceWidth * 0.05,
                  ),
                  isMe
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(
                            deviceWidth * 0.2,
                          ),
                          child: Container(
                            color: Colors.black,
                            width: deviceWidth * 0.1,
                            height: deviceHeight * 0.05,
                            child: Image.network(Img),
                          ),
                        )
                      : Text(""),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 5.0,
          ),
          Text('$time'),
        ],
      ),
    );
  }
}
