import 'package:diviction_user/screen/day_check_screen.dart';
import 'package:diviction_user/screen/bottom_nav.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});
  @override
  Widget build(BuildContext context) {
    String today = DateFormat('yyyy-MM-dd').format(DateTime.now());

    Future.delayed(const Duration(milliseconds: 1000), () async {
      final SharedPreferences pref = await SharedPreferences.getInstance();
      bool? result = pref.getBool(today);
      if (context.mounted) {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (context) => result == null
                    ? const DayCheckScreen()
                    : const BottomNavigation()),
            (route) => false);
      }
    });
    return Container(
      color: Colors.white,
      height: double.infinity,
      width: double.infinity,
      child: const Center(
        child: Text(
          'Diviction',
          style: TextStyle(color: Colors.black54, fontSize: 17),
        ),
      ),
    );
  }
}
