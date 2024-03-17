import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomText extends StatelessWidget {
  CustomText({
    super.key,
    required this.text,
    this.textAlign,
    this.textDirection,
    this.color,
    this.fontFamily,
    this.fontSize,
    this.fontWeight,
    this.letterSpacing,
    this.wordSpacing,
  });
  final String text;
  TextAlign? textAlign;
  TextDirection? textDirection;
  Color? color;
  FontWeight? fontWeight;
  String? fontFamily;
  double? fontSize;
  double? letterSpacing;
  double? wordSpacing;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      textDirection: textDirection,
      style: TextStyle(
        color: color,
        fontSize: fontSize,
        fontWeight: fontWeight,
        letterSpacing: letterSpacing,
        wordSpacing: wordSpacing,
        fontFamily: fontFamily,
      ),
    );
  }
}
