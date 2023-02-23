import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'bottom_nav.dart';

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
                child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      children: [button(context, false), button(context, true)],
                    )))
          ],
        ));
  }

  Widget button(BuildContext context, bool data) {
    return Flexible(
        flex: 1,
        child: GestureDetector(
            onTap: () {
              saveData(data);
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => BottomNavigation()),
                  (route) => false);
            },
            child: Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.all(20),
                padding: const EdgeInsets.all(20),
                width: double.infinity,
                child: Text(data == true ? 'Yes 😁' : 'No 😂',
                    style: const TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.w600)))));
  }

  saveData(bool data) async {
    String today = DateFormat('yyyy-MM-dd').format(DateTime.now());
    final SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setBool(today, data);
  }
}
