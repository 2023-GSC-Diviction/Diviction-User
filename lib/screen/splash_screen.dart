import 'package:diviction_user/config/style.dart';
import 'package:diviction_user/screen/day_check_screen.dart';
import 'package:diviction_user/screen/bottom_nav.dart';
import 'package:diviction_user/screen/sign/login_screen.dart';
import 'package:diviction_user/service/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../service/chat_service.dart';

final loginStateProvider =
    FutureProvider.autoDispose((ref) => AuthService().isLogin());

class SplashScreen extends ConsumerWidget {
  const SplashScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLogin = ref.watch(loginStateProvider);
    String today = DateFormat('yyyy-MM-dd').format(DateTime.now());

    toMainScreen(bool result) {
      ChatService();
      if (result) {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const DayCheckScreen()),
            (route) => false);
      } else {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const BottomNavigation()),
            (route) => false);
      }
    }

    void checkDay() async {
      final SharedPreferences pref = await SharedPreferences.getInstance();
      bool? result = pref.getBool(today);

      toMainScreen(result == null);
    }

    void toLoginScreen() {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const LoginScreen()),
          (route) => false);
    }

    Future.delayed(const Duration(milliseconds: 1000), () async {
      isLogin.when(
        data: (value) {
          if (value == true) {
            checkDay(); //
          } else if (value == false) {
            toLoginScreen();
          }
        },
        loading: () {},
        error: (error, stackTrace) {},
      );
    });

    return Container(
      color: Colors.white,
      child: const Center(
          child: Text('Diviction', style: TextStyles.splashTitleTextStyle)),
    );
  }
}
