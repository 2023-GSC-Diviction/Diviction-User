import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../config/style.dart';

class SurveyButton extends StatelessWidget {
  const SurveyButton({super.key, required this.title, required this.screen});

  final String title;
  final Widget screen;

  @override
  Widget build(BuildContext context) {
    return Expanded(
        flex: 1,
        child: InkWell(
            onTap: () => Navigator.push(
                context, MaterialPageRoute(builder: (context) => screen)),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 10),
              height: MediaQuery.of(context).size.height * 0.14,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Icon(
                    Icons.medication_liquid,
                    size: MediaQuery.of(context).size.height * 0.06,
                    color: Palette.appColor,
                  ),
                  Text(title,
                      style: const TextStyle(
                          fontSize: 13, color: Palette.mainTextColor))
                ],
              ),
            )));
  }
}
