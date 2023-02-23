import 'package:flutter/material.dart';

class TextStyles {
  static const TextStyle titleTextStyle = TextStyle(
      fontSize: 22,
      color: Color.fromRGBO(51, 51, 51, 1),
      height: 1.4,
      letterSpacing: 0.02,
      fontWeight: FontWeight.w800);
  static const TextStyle mainTextStyle = TextStyle(
      fontSize: 18,
      color: Color.fromRGBO(51, 51, 51, 1),
      fontWeight: FontWeight.w700);

  static const TextStyle bottomTextStyle = TextStyle(
      fontSize: 16,
      color: Color.fromRGBO(51, 51, 51, 1),
      fontWeight: FontWeight.w600);
  static const TextStyle shadowTextStyle = TextStyle(
      letterSpacing: 0.04,
      fontSize: 14,
      color: Color.fromRGBO(82, 82, 82, 0.644));
}

class Palette {
  static const Color mainTextColor = Color.fromRGBO(51, 51, 51, 1);
  static const Color chatGrayColor = Color.fromARGB(255, 224, 224, 230);
}
