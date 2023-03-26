import 'dart:async';

import 'package:diviction_user/screen/counselor/find_counselor_screen.dart';
import 'package:diviction_user/screen/chat/chatlist_screen.dart';
import 'package:diviction_user/service/chat_service.dart';
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
      const ChatListScreen(),
      const FindCounselorScreen(),
    ];

    Widget bottomBar() {
      return InkWell(
          onTap: () {
            _pageController.animateToPage(index == 0 ? 1 : 0,
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeInOut);
          },
          child: Container(
              decoration: const BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Color.fromARGB(13, 0, 0, 0),
                    blurRadius: 10,
                    spreadRadius: 5,
                    offset: Offset(0, 0),
                  )
                ],
                color: Palette.appColor,
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              margin: const EdgeInsets.all(15),
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
              width: MediaQuery.of(context).size.width - 30,
              alignment: Alignment.centerLeft,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  if (index == 0) ...[
                    const Text(
                      'Want find Counselor?',
                      style: TextStyles.counselorTitle,
                    ),
                    // Text.rich(
                    //   TextSpan(
                    //       text: 'Want find Counselor?\n',
                    //       style: TextStyles.counselorTitle,
                    //       children: <TextSpan>[
                    //         TextSpan(
                    //             text: ' find your counselor',
                    //             style: TextStyles.counselorMiddle)
                    //       ]),
                    //   textAlign: TextAlign.start,
                    // ),
                    const Icon(
                      Icons.arrow_right_sharp,
                      size: 40,
                      color: Palette.appColor2,
                    )
                  ] else ...[
                    const Text.rich(
                      TextSpan(
                          text: 'Back to my chat',
                          style: TextStyles.counselorTitle,
                          children: <TextSpan>[
                            TextSpan(text: '', style: TextStyles.titleTextStyle)
                          ]),
                      textAlign: TextAlign.start,
                    ),
                    const Icon(
                      Icons.arrow_left_sharp,
                      size: 40,
                      color: Palette.appColor2,
                    )
                  ],
                ],
              )));
    }

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 42, 42, 42),
          title: const Text('Divicion',
              style: TextStyle(color: Palette.appColor, fontSize: 23)),
          centerTitle: true,
          elevation: 0,
        ),
        body: Stack(children: [
          Container(
              color: Color.fromARGB(255, 42, 42, 42),
              padding: const EdgeInsets.only(top: 30),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Row(
                    //   mainAxisSize: MainAxisSize.max,
                    //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    //   children: [
                    //     Flexible(
                    //         flex: 1,
                    //         child: Container(
                    //             padding: EdgeInsets.all(10),
                    //             margin: const EdgeInsets.symmetric(
                    //                 horizontal: 10, vertical: 4),
                    //             decoration: BoxDecoration(
                    //                 borderRadius: BorderRadius.circular(10),
                    //                 color: index == 0
                    //                     ? Colors.white
                    //                     : Colors.blue),
                    //             child: const Text(
                    //               'Counselor',
                    //               style: TextStyles.answerTextStyle,
                    //             ))),
                    //     Flexible(
                    //       flex: 1,
                    //       child: Container(
                    //           padding: EdgeInsets.all(10),
                    //           margin: const EdgeInsets.symmetric(
                    //               horizontal: 10, vertical: 4),
                    //           decoration: BoxDecoration(
                    //               borderRadius: BorderRadius.circular(10),
                    //               color:
                    //                   index == 0 ? Colors.white : Colors.blue),
                    //           child: const Text(
                    //             'Counselor',
                    //             style: TextStyles.answerTextStyle,
                    //           )),
                    //     )
                    //   ],
                    // ),
                    Expanded(
                        child: Container(
                      decoration: const BoxDecoration(
                        color: Palette.appColor,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30)),
                      ),
                      child: PageView.builder(
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
                    ))
                  ])),
          Positioned(
            bottom: 0,
            child: bottomBar(),
          )
        ]));
  }
}
