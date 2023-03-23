import 'package:diviction_user/screen/community/community_screen.dart';
import 'package:diviction_user/screen/counselor/counselor_screen.dart';
import 'package:diviction_user/screen/home_screen.dart';
import 'package:diviction_user/screen/profile/user_profile_screen.dart';
import 'package:diviction_user/model/match.dart';
import 'package:diviction_user/service/match_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../provider/bottom_nav_provider.dart';
import '../service/auth_service.dart';
import 'chat/chat_screen.dart';

final bottomNavProvider =
    StateNotifierProvider<BottomNavState, int>((ref) => BottomNavState());

final matchedProvider = FutureProvider((ref) => MatchingService().getMatched());

class BottomNavigation extends ConsumerStatefulWidget {
  const BottomNavigation({Key? key}) : super(key: key);

  @override
  BottomNavigationState createState() => BottomNavigationState();
}

class BottomNavigationState extends ConsumerState<BottomNavigation> {
  @override
  Widget build(BuildContext context) {
    const Color selected = Color.fromRGBO(63, 66, 72, 1);
    const Color unSelected = Color.fromRGBO(204, 210, 223, 1);
    final currentPage = ref.watch(bottomNavProvider);
    final matched = ref.watch(matchedProvider);

    final defaultScreen = [
      const HomeSceen(),
      CounselorScreen(),
      const CommunityScreen(),
      const UserProfileScreen()
    ];

    return Scaffold(
      body: SafeArea(
          child: matched.when(data: (data) {
        if (data == null) {
          saveMatchingData(false);
          return defaultScreen.elementAt(currentPage);
        } else {
          saveMatchingData(true);
          return [
            const HomeSceen(),
            ChatScreen(
              chatroomId: '${data.counselorEmail}&${data.user.email}'
                  .replaceAll(',', ''),
              isNew: false,
              counselor: null,
            ),
            const CommunityScreen(),
            const UserProfileScreen()
          ].elementAt(currentPage);
        }
      }, loading: () {
        return defaultScreen.elementAt(currentPage);
      }, error: (e, s) {
        return defaultScreen.elementAt(currentPage);
      })),
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

  void saveMatchingData(bool isMatched) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    sharedPreferences.setBool('isMatched', isMatched);
  }
}
