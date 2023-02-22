import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../widget/bottom_nav.dart';

class DayCheckScreen extends StatelessWidget {
  const DayCheckScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        child: Stack(
          children: [
            const Center(
              child: Text(
                '어제는 잘 참으셨나요?',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            Positioned(
                bottom: 0,
                child: Container(
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      children: [
                        Flexible(
                            flex: 1,
                            child: GestureDetector(
                                onTap: () {
                                  saveData(false);
                                  Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              BottomNavigation()),
                                      (route) => false);
                                },
                                child: Container(
                                    margin: EdgeInsets.all(20),
                                    padding: EdgeInsets.all(20),
                                    alignment: Alignment.center,
                                    width: double.infinity,
                                    child: const Text('No 😂',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 20,
                                            fontWeight: FontWeight.w600))))),
                        Flexible(
                            flex: 1,
                            child: GestureDetector(
                                onTap: () {
                                  saveData(true);
                                  Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              BottomNavigation()),
                                      (route) => false);
                                },
                                child: Container(
                                    alignment: Alignment.center,
                                    margin: EdgeInsets.all(20),
                                    padding: EdgeInsets.all(20),
                                    width: double.infinity,
                                    child: const Text('Yes 😁',
                                        style: TextStyle(
                                            fontSize: 20,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w600)))))
                      ],
                    )))
          ],
        ));
  }

  saveData(bool data) async {
    String today = DateFormat('yyyy-MM-dd').format(DateTime.now());
    final SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setBool(today, data);
  }
}
