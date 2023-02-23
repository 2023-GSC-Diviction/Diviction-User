import 'package:flutter/material.dart';

extension TextStyles on TextTheme {
  TextStyle get titleTextStyle => const TextStyle(
      fontSize: 22,
      color: Color.fromRGBO(51, 51, 51, 1),
      height: 1.4,
      letterSpacing: 0.02,
      fontWeight: FontWeight.w800);
  TextStyle get mainTextStyle => const TextStyle(
      fontSize: 18,
      color: Color.fromRGBO(51, 51, 51, 1),
      fontWeight: FontWeight.w700);

  TextStyle get bottomTextStyle => const TextStyle(
      fontSize: 16,
      color: Color.fromRGBO(51, 51, 51, 1),
      fontWeight: FontWeight.w600);
  TextStyle get shadowTextStyle => const TextStyle(
      letterSpacing: 0.04,
      fontSize: 14,
      color: Color.fromRGBO(82, 82, 82, 0.644));
}

class Palette {
  static const Color mainTextColor = Color.fromRGBO(51, 51, 51, 1);
}
