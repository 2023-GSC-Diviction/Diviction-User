import 'package:diviction_user/screen/community/community_screen.dart';
import 'package:diviction_user/screen/counselor/counselor_screen.dart';
import 'package:diviction_user/screen/home_screen.dart';
import 'package:diviction_user/screen/profile_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../provider/bottom_nav_provider.dart';
import '../service/auth_service.dart';

final bottomNavProvider =
    StateNotifierProvider<BottomNavState, int>((ref) => BottomNavState());

final matchedProvider = FutureProvider((ref) => AuthService().getMatched());

class BottomNavigation extends ConsumerWidget {
  const BottomNavigation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const Color selected = Color.fromRGBO(63, 66, 72, 1);
    const Color unSelected = Color.fromRGBO(204, 210, 223, 1);
    final currentPage = ref.watch(bottomNavProvider);
    // final matched = ref.watch(matchedProvider);

    return Scaffold(
      // body: SafeArea(
      //     child: matched.when(data: (data) {
      //   if (data == false) {
      //     return [
      //       const HomeSceen(),
      //       CounselorScreen(),
      //       const CommunityScreen(),
      //       const ProfileScreen()
      //     ].elementAt(currentPage);
      //   } else {
      //     return [
      //       const HomeSceen(),
      //       ChatScreen(
      //         chatroomId: data,
      //       ),
      //       const CommunityScreen(),
      //       const ProfileScreen()
      //     ].elementAt(currentPage);
      //   }
      // }, loading: () {
      //   return const CircularProgressIndicator();
      // }, error: (e, s) {
      //   return Text('fail to load');
      // })),
      body: SafeArea(
          child: [
        const HomeSceen(),
        CounselorScreen(),
        const CommunityScreen(),
        ProfileScreen(
          email: 'lin019@naver.com',
          isMe: true,
        )
      ].elementAt(currentPage)),
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
                label: 'Home'),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.chat,
                  color: unSelected,
                ),
                activeIcon: Icon(
                  Icons.chat,
                  color: selected,
                ),
                label: 'Counselor'),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.article_rounded,
                  color: unSelected,
                ),
                activeIcon: Icon(
                  Icons.article_rounded,
                  color: selected,
                ),
                label: 'Community'),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.account_circle_rounded,
                  color: unSelected,
                ),
                activeIcon: Icon(
                  Icons.account_circle_rounded,
                  color: selected,
                ),
                label: 'MyPage'),
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
