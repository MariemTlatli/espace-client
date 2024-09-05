import 'package:flutter/material.dart';
import 'package:another_flushbar/flushbar.dart';

class CustomFlushbar {
  static void showFlushbar(BuildContext context, String title,
      {Color backgroundColor = Colors.red, Color textColor = Colors.white}) {
    Flushbar(
      backgroundColor: backgroundColor,
      boxShadows: [
        BoxShadow(
          color: backgroundColor,
          offset: Offset(0.0, 2.0),
          blurRadius: 3.0,
        )
      ],
      duration: Duration(seconds: 3),
      flushbarPosition: FlushbarPosition.TOP, // Position en haut
      margin: EdgeInsets.all(8),
      borderRadius: BorderRadius.circular(8),
      messageText: Text(
        title,
        style: TextStyle(
          color: textColor,
          fontWeight: FontWeight.bold,
          fontSize: 16.0,
        ),
        textAlign: TextAlign.center,
      ),
    )..show(context);
  }
}
