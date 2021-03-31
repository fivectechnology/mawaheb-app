import 'package:flutter/material.dart';
import 'package:mawaheb_app/app/theme/colors.dart';

class MawahebGradientButton extends StatelessWidget {
  const MawahebGradientButton({
    Key key,
    @required this.text,
    this.onPressed,
  }) : super(key: key);

  final String text;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: onPressed,
      elevation: 0,
      hoverElevation: 0,
      focusElevation: 0,
      highlightElevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(80.0)),
      padding: const EdgeInsets.all(0.0),
      child: Ink(
        decoration: const BoxDecoration(
          gradient: BUTTON_GRADIENT,
          borderRadius: BorderRadius.all(Radius.circular(80.0)),
        ),
        child: Container(
          constraints: const BoxConstraints(
              minWidth: double.infinity,
              minHeight: 55), // min sizes for Material buttons
          alignment: Alignment.center,
          child: Text(
            text,
            style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
                fontFamily: 'Poppins'),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
