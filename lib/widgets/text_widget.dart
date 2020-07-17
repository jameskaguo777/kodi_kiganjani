import 'package:flutter/material.dart';

class TextWidget extends StatelessWidget{
  TextWidget({@required this.text, @required this.color, @required this.font, @required this.fontSize});

  final String text;
  final String font;
  final double fontSize;
  final color;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: fontSize,
        fontFamily: font,
        color: color
      ),
    );
  }
}
