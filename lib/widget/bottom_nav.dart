import 'package:diviction_user/screen/home_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final bottomNavProvider =
    StateNotifierProvider<BottomNavState, int>((ref) => BottomNavState());

class BottomNavState extends StateNotifier<int> {
  BottomNavState() : super(0);

  @override
  set state(int value) {
    super.state = value;
  }
}

class BottomNavigation extends ConsumerWidget {
  const BottomNavigation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const Color selected = Color.fromRGBO(63, 66, 72, 1);
    const Color unSelected = Color.fromRGBO(204, 210, 223, 1);
    final currentPage = ref.watch(bottomNavProvider);

    return Scaffold(
      appBar: AppBar(
        shadowColor: const Color.fromRGBO(255, 255, 255, 0.5),
        backgroundColor: Colors.white,
        title: const Text(
          'Diviction',
          style: TextStyle(color: Colors.black54),
        ),
        elevation: 10,
      ),
      body: SafeArea(
        child: [
          HomeSceen(),
          Container(
            color: Colors.red,
          ),
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
                  color: selected,
                ),
                activeIcon: Icon(
                  Icons.home,
                  color: unSelected,
                ),
                label: ''),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.chat,
                  color: selected,
                ),
                activeIcon: Icon(
                  Icons.chat,
                  color: unSelected,
                ),
                label: ''),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.article_rounded,
                  color: selected,
                ),
                activeIcon: Icon(
                  Icons.article_rounded,
                  color: unSelected,
                ),
                label: ''),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.account_circle_rounded,
                  color: selected,
                ),
                activeIcon: Icon(
                  Icons.account_circle_rounded,
                  color: unSelected,
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
