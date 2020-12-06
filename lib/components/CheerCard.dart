import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CheerCard extends StatefulWidget {
  CheerCard({
    this.postTitle,
    this.fromImgAddress,
    this.deviceHeight,
    this.deviceWidth,
    this.fromName,
    this.points,
    this.toName,
    this.likes,
    this.fromJob,
    this.time,
  });

  final String postTitle;
  final String fromJob;
  final String fromImgAddress;
  final double deviceHeight;
  final double deviceWidth;
  final String fromName;
  final int points;
  final String toName;
  final int likes;
  final String time;

  @override
  _CheerCardState createState() => _CheerCardState();
}

class _CheerCardState extends State<CheerCard> {
  @override
  Widget build(BuildContext context) {
    bool liked = false;

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 3.0,
      ),
      child: Card(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(
                top: widget.deviceHeight * 0.02,
                left: widget.deviceWidth * 0.04,
                right: widget.deviceWidth * 0.05,
              ),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(
                      widget.deviceWidth * 0.2,
                    ),
                    child: Container(
                      color: Colors.black,
                      width: widget.deviceWidth * 0.15,
                      height: widget.deviceHeight * 0.075,
                      child: Image.network(widget.fromImgAddress),
                    ),
                  ),
                  SizedBox(
                    width: widget.deviceWidth * 0.02,
                  ),
                  Column(
                    children: [
                      Text(
                        widget.fromName,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: widget.deviceHeight * 0.005,
                      ),
                      Text(widget.fromJob),
                    ],
                  ),
                  Spacer(),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                top: widget.deviceHeight * 0.02,
                left: widget.deviceWidth * 0.04,
                right: widget.deviceWidth * 0.04,
              ),
              child: RichText(
                text: TextSpan(
                  // Note: Styles for TextSpans must be explicitly defined.
                  // Child text spans will inherit styles from parent
                  style: TextStyle(
                    fontSize: 14.0,
                    color: Colors.black,
                  ),
                  children: <TextSpan>[
                    TextSpan(
                      text: '${widget.fromName} ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      text: 'cheered ',
                    ),
                    TextSpan(
                      text: '${widget.toName} ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      text: 'for ',
                    ),
                    TextSpan(
                      text: '${widget.postTitle}. ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      text: '${widget.toName} ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      text: 'earned ',
                    ),
                    TextSpan(
                      text: '${widget.points} ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      text: 'points. ',
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                left: 10.0,
              ),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {
                      setState(() {
                        liked ? liked = false : liked = true;
                      });
                    },
                    icon: liked
                        ? Icon(Icons.favorite)
                        : Icon(Icons.favorite_border),
                  ),
                  Text('${widget.points} likes'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
