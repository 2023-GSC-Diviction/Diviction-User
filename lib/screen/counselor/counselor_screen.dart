import 'dart:async';

import 'package:diviction_user/screen/counselor/find_counselor_screen.dart';
import 'package:diviction_user/screen/counselor/requested_counselor_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../config/style.dart';

class CounselorScreen extends ConsumerWidget {
  CounselorScreen({super.key});

  final PageController _pageController = PageController(initialPage: 0);
  final pageProvider = StateProvider<int>((ref) => 0);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _pageController.addListener(() {
      ref.read(pageProvider.notifier).state =
          _pageController.page?.round() ?? 0;
    });
    int index = ref.watch(pageProvider);
    final page = [
      const FindCounselorScreen(),
      const RequestedCounselorScreen()
    ];

    Widget bottomBar() {
      return InkWell(
          onTap: () {
            _pageController.animateToPage(index == 1 ? 0 : 1,
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeInOut);
          },
          child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                border: Border.symmetric(
                    horizontal: BorderSide(
                        width: 1, color: Palette.bottomBoxBorderColor)),
              ),
              padding: const EdgeInsets.all(12),
              width: MediaQuery.of(context).size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(index == 0 ? 'my chat' : 'counselor list',
                      style: TextStyles.bottomTextStyle),
                  Icon(index == 0
                      ? Icons.arrow_right_sharp
                      : Icons.arrow_left_sharp)
                ],
              )));
    }

    return Stack(
      children: [
        PageView.builder(
            itemCount: page.length,
            findChildIndexCallback: (key) {
              //important here:
              if (index > 0) {
                return index;
              } else {
                return null;
              }
            },
            controller: _pageController,
            itemBuilder: (context, index) {
              return page[index];
            }),
        Positioned(
          bottom: 0,
          child: bottomBar(),
        )
      ],
    );
  }
}
