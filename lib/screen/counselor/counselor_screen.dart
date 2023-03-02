import 'dart:async';

import 'package:diviction_user/screen/counselor/find_counselor_screen.dart';
import 'package:diviction_user/screen/counselor/requested_counselor_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import '../../config/style.dart';

class CounselorScreen extends StatefulWidget {
  const CounselorScreen({super.key});

  @override
  State<CounselorScreen> createState() => _CounselorScreenState();
}

@override
class _CounselorScreenState extends State<CounselorScreen> {
  final PageController _pageController = PageController(initialPage: 0);
  int _selectedIndex = 0;
  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      setState(() {
        _selectedIndex = _pageController.page!.round();
      });
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Future<bool> initializeController() {
    Completer<bool> completer = Completer<bool>();

    /// Callback called after widget has been fully built
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      completer.complete(true);
    });

    return completer.future;
  } // /initializeController()

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Future.value(true),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Stack(
              children: [
                PageView(controller: _pageController, children: const [
                  FindCounselorScreen(),
                  RequestedCounselorScreen()
                ]),
                Positioned(
                  bottom: 0,
                  child: bottomBar(),
                )
              ],
            );
          } else {
            return const Center(
              child: Text('loading...'),
            );
          }
        });
  }

  Widget bottomBar() {
    return _pageController.positions.isNotEmpty
        ? InkWell(
            onTap: () {
              _pageController.animateToPage(_selectedIndex == 1 ? 0 : 1,
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
                    Text(_selectedIndex == 0 ? '내가 한 요청 보기' : '상담사 찾기',
                        style: TextStyles.bottomTextStyle),
                    Icon(_selectedIndex == 0
                        ? Icons.arrow_right_sharp
                        : Icons.arrow_left_sharp)
                  ],
                )))
        : const Center(
            child: Text('loading...'),
          );
  }
}
