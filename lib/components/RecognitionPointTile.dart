import 'package:flutter/material.dart';

class RecognitionPointTile extends StatelessWidget {
  RecognitionPointTile(
      {this.deviceWidth, this.title, this.points, this.onPress, this.selected});
  final double deviceWidth;
  final String title;
  final String points;
  final Function onPress;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
        leading: GestureDetector(
          onTap: onPress,
          child: Card(
            color: selected ? Color(0xFFd5deed) : Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(deviceWidth * 0.1),
              side: BorderSide(
                color: Colors.green,
              ),
            ),
            child: Padding(
              padding: EdgeInsets.all(12.0),
              child: Text(
                title,
                style: TextStyle(
                  color: Colors.green,
                  fontSize: deviceWidth * 0.045,
                ),
              ),
            ),
          ),
        ),
        trailing: Text(
          points,
          style: TextStyle(
            color: Colors.orangeAccent,
            fontSize: deviceWidth * 0.04,
          ),
        ),
      ),
    );
  }
}
