import 'package:diviction_user/widget/bottom_nav.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});
  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(milliseconds: 1500), () {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => BottomNavigation()),
          (route) => false);
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
