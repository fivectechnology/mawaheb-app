import 'package:flutter/material.dart';

class MawahebButton extends StatelessWidget {
  const MawahebButton({
    Key key,
    this.text,
    this.buttonColor,
    this.textColor,
    this.borderColor,
    this.onPressed,
  }) : super(key: key);

  final String text;
  final Color textColor;
  final Color buttonColor;
  final Function onPressed;
  final Color borderColor;

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      color: buttonColor,
      onPressed: onPressed,
      elevation: 0,
      hoverElevation: 0,
      focusElevation: 0,
      highlightElevation: 0,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(80.0),
          side: BorderSide(color: borderColor, width: 1.0)),
      padding: const EdgeInsets.all(0.0),
      child: Container(
        decoration: BoxDecoration(
            color: buttonColor,
            borderRadius: BorderRadius.circular(80.0),
            border: Border.all(color: borderColor, width: 1.0)),
        constraints:
            const BoxConstraints(minWidth: double.infinity, minHeight: 55),
        // min sizes for Material buttons
        alignment: Alignment.center,
        child: Text(
          text,
          style: TextStyle(
              color: textColor,
              fontSize: 20,
              fontWeight: FontWeight.bold,
              fontFamily: 'Poppins'),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
