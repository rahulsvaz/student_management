import 'package:flutter/material.dart';

class FontText extends StatelessWidget {
  final String text;
  final double fontSize;
  final Color? color;
  final FontWeight? fontWeight;

  const FontText(
      {super.key, required this.text, required this.fontSize, this.color,this.fontWeight});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
          color: color,
          fontSize: fontSize,
          fontFamily: 'Caveat',
          fontWeight: FontWeight.bold),
    );
  }
}
