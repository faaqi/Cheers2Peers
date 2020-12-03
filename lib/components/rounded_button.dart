import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  RoundedButton(
      {@required this.color, @required this.title, @required this.onPressed});

  final Color color;
  final String title;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.0),
      child: Material(
        borderRadius: BorderRadius.circular(30.0),
        color: color,
        child: MaterialButton(
            minWidth: 200.0,
            height: 20.0,
            child: Padding(
              padding: EdgeInsets.all(14.0),
              child: Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                  fontSize: 16.0,
                ),
              ),
            ),
            onPressed: onPressed),
      ),
    );
  }
}
