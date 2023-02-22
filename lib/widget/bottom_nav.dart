import 'package:diviction_user/screen/counselor_screen.dart';
import 'package:diviction_user/screen/home_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../provider/bottom_nav_provider.dart';

final bottomNavProvider =
    StateNotifierProvider<BottomNavState, int>((ref) => BottomNavState());

class BottomNavigation extends ConsumerWidget {
  const BottomNavigation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const Color selected = Color.fromRGBO(63, 66, 72, 1);
    const Color unSelected = Color.fromRGBO(204, 210, 223, 1);
    final currentPage = ref.watch(bottomNavProvider);

    return Scaffold(
      body: SafeArea(
        child: [
          HomeSceen(),
          CounselorScreen(),
          Container(
            color: Colors.yellow,
          ),
          Container(
            color: Colors.blue,
          )
        ].elementAt(currentPage),
      ),
      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.home,
                  color: unSelected,
                ),
                activeIcon: Icon(
                  Icons.home,
                  color: selected,
                ),
                label: ''),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.chat,
                  color: unSelected,
                ),
                activeIcon: Icon(
                  Icons.chat,
                  color: selected,
                ),
                label: ''),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.article_rounded,
                  color: unSelected,
                ),
                activeIcon: Icon(
                  Icons.article_rounded,
                  color: selected,
                ),
                label: ''),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.account_circle_rounded,
                  color: unSelected,
                ),
                activeIcon: Icon(
                  Icons.account_circle_rounded,
                  color: selected,
                ),
                label: ''),
          ],
          currentIndex: currentPage,
          selectedItemColor: selected,
          unselectedItemColor: unSelected,
          onTap: (index) {
            ref.read(bottomNavProvider.notifier).state = index;
          }),
    );
  }
}
