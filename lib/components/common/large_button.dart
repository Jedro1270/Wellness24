import 'package:flutter/material.dart';

class LargeButton extends StatelessWidget {
  final Function onPressed;
  final Key key;
  final String content;

  final Color backgroundColor;
  final Color fontColor;

  LargeButton(
      {this.content,
      this.onPressed,
      this.key,
      this.backgroundColor,
      this.fontColor});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: ElevatedButton(
        key: key,
        child: Text(content,
            style: TextStyle(
                fontSize: 25,
                fontFamily: "ShipporiMincho",
                fontWeight: FontWeight.bold,
                color: fontColor)),
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(vertical: 20),
          primary: backgroundColor,
        ),
      ),
    );
  }
}
