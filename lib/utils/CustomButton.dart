import 'package:espace_client/Constants.dart' as constants;
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback onPressed;
  final bool isButtonEnabled;
  final String text;
  final Color color; // Ajoutez le type Color ici
  final double myPadding;

  CustomButton(
      {required this.onPressed,
      required this.isButtonEnabled,
      required this.text,
      required this.color,
      required this.myPadding});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Padding(
        padding: EdgeInsets.all(myPadding),
        child: Text(text),
      ),
      style: (isButtonEnabled)
          ? TextButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: color,
            )
          : TextButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: constants.MyDarkGreyColor,
            ),
    );
  }
}
