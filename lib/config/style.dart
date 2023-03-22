import 'package:flutter/material.dart';

class TextStyles {
  static const TextStyle titleTextStyle = TextStyle(
      fontSize: 22,
      color: Palette.appColor,
      height: 1.4,
      letterSpacing: 0.02,
      fontWeight: FontWeight.w700);
  static const TextStyle questionTextStyle = TextStyle(
      fontSize: 19,
      color: Color.fromRGBO(51, 51, 51, 1),
      height: 1.4,
      letterSpacing: 0.02,
      fontWeight: FontWeight.w600);
  static const TextStyle answerTextStyle = TextStyle(
      fontSize: 18,
      height: 1.4,
      color: Color.fromRGBO(51, 51, 51, 1),
      fontWeight: FontWeight.w500);

  static const TextStyle mainTextStyle = TextStyle(
      fontSize: 16,
      height: 1.4,
      color: Color.fromRGBO(51, 51, 51, 1),
      fontWeight: FontWeight.w500);

  static const TextStyle bottomTextStyle = TextStyle(
      fontSize: 16,
      color: Color.fromRGBO(51, 51, 51, 1),
      fontWeight: FontWeight.w500);
  static const TextStyle shadowTextStyle = TextStyle(
      letterSpacing: 0.04,
      fontSize: 14,
      color: Color.fromRGBO(82, 82, 82, 0.644));
  static const TextStyle blueBottonTextStyle = TextStyle(
      letterSpacing: 0.04,
      fontSize: 17,
      color: Color.fromRGBO(255, 255, 255, 1));
  static const TextStyle chatNicknameTextStyle =
      TextStyle(fontSize: 16, color: Colors.black, fontWeight: FontWeight.w600);
  static const TextStyle chatNotMeBubbleTextStyle =
      TextStyle(fontSize: 17, color: Colors.black, fontWeight: FontWeight.w400);
  static const TextStyle splashTitleTextStyle = TextStyle(
      decoration: TextDecoration.none,
      color: Colors.black54,
      fontSize: 25,
      fontWeight: FontWeight.w600);
  static const TextStyle optionButtonTextStyle = TextStyle(
      color: Colors.black87, fontSize: 14, fontWeight: FontWeight.normal);

  static const TextStyle dialogTextStyle = TextStyle(
      fontSize: 19,
      color: Color.fromRGBO(51, 51, 51, 1),
      height: 1.4,
      letterSpacing: 0.02,
      fontWeight: FontWeight.w600);
  static const TextStyle dialogTextStyle2 = TextStyle(
      fontSize: 16,
      color: Color.fromRGBO(51, 51, 51, 1),
      height: 1.4,
      letterSpacing: 0.02,
      fontWeight: FontWeight.w500);
  static const TextStyle dialogConfirmTextStyle =
      TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 16);
  static const TextStyle dialogCancelTextStyle = TextStyle(
      color: Colors.black54, fontWeight: FontWeight.w700, fontSize: 16);
  static const TextStyle commentBtnTextStyle = TextStyle(
      fontSize: 15,
      height: 1.2,
      color: Color.fromRGBO(51, 51, 51, 1),
      fontWeight: FontWeight.w400);
  static const TextStyle descriptionTextStyle =
      TextStyle(color: Color.fromRGBO(153, 153, 153, 1), fontSize: 14);

  static const underlineTextStyle = TextStyle(
    color: Color(0xFFC3C3C3),
    decoration: TextDecoration.underline, // 밑줄 넣기
    decorationThickness: 1.5, // 밑줄 두께
    // fontStyle: FontStyle
  );
  static const TextStyle counselorTitle = TextStyle(
      fontSize: 22,
      color: Color.fromRGBO(255, 255, 255, 1),
      height: 1.4,
      letterSpacing: 0.02,
      fontWeight: FontWeight.w700);
  static const TextStyle counselorMiddle = TextStyle(
      fontSize: 18,
      color: Color.fromRGBO(255, 255, 255, 1),
      height: 1.4,
      letterSpacing: 0.02,
      fontWeight: FontWeight.w700);
  static const TextStyle chatHeading = TextStyle(
    color: Color(0xff686795),
    fontSize: 18,
    fontWeight: FontWeight.w600,
    letterSpacing: 1.5,
  );
  static const TextStyle chatbodyText = TextStyle(
      color: Color(0xffAEABC9),
      fontSize: 14,
      letterSpacing: 1.2,
      fontWeight: FontWeight.w500);
}

class Palette {
  static const Color appColor = Color.fromARGB(255, 99, 201, 219);
  static const Color appColor2 = Color.fromARGB(255, 255, 255, 255);
  static const Color mainTextColor = Color.fromRGBO(51, 51, 51, 1);
  static const Color chatGrayColor = Color.fromARGB(255, 224, 224, 230);
  static const Color borderColor = Color.fromARGB(255, 203, 203, 209);
  static const Color bottomBoxBorderColor = Color.fromARGB(10, 0, 0, 0);
  // Color.fromARGB(255, 78, 206, 229)
}

Container dividingLine = Container(
  decoration: const BoxDecoration(
    border: Border(
      top: BorderSide(
        width: 1,
        color: Colors.grey,
      ),
    ),
  ),
);
