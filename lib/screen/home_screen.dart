import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

import '../config/style.dart';
import '../widget/appbar.dart';

class HomeSceen extends StatefulWidget {
  const HomeSceen({super.key});

  @override
  State<HomeSceen> createState() => _HomeSceenState();
}

class _HomeSceenState extends State<HomeSceen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const MyAppbar(),
        backgroundColor: Colors.white,
        body: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: SingleChildScrollView(
              child: Container(
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    recordText(),
                    const CalendarWidget(),
                    checkList(),
                    TestButton(
                      type: 0,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TestButton(
                      type: 1,
                    )
                  ],
                ),
              ),
            )));
  }

  Widget recordText() {
    return Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: const Text.rich(
          TextSpan(
              text: '지난 참은 일수 \'13일\'\n',
              style: TextStyles.titleTextStyle,
              children: <TextSpan>[
                TextSpan(text: '잘 하고 있어요!', style: TextStyles.titleTextStyle)
              ]),
          textAlign: TextAlign.start,
        ));
  }

  Widget checkList() {
    List<bool> checkBoxList = [false, true, false, true, false];
    List<String> list = [
      '한시간 이상 운동하기',
      '물 많이 마시기',
      '약 챙겨먹기',
      '물 많이 마시기',
      '약 챙겨먹기'
    ];
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: checkBoxList
            .map((e) => Row(
                  children: [
                    Checkbox(
                        value: e,
                        onChanged: (value) {
                          checkBoxList[checkBoxList.indexOf(e)] = value!;
                        }),
                    Text(list[checkBoxList.indexOf(e)],
                        style: const TextStyle(
                            fontSize: 16, color: Palette.mainTextColor)),
                  ],
                ))
            .toList());
  }
}

class TestButton extends StatelessWidget {
  TestButton({required this.type, super.key});

  int type;

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          // Navigator.push(
          //     context,
          //     MaterialPageRoute(
          //         builder: (context) => CounselorDetailScreen()));
        },
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Palette.borderColor)),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          width: double.infinity,
          child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(type == 0 ? 'psychological Test' : 'self-diagnosis Test',
                    style: const TextStyle(
                        fontSize: 16, color: Palette.mainTextColor)),
                ClipOval(
                    child: Container(
                        width: 50,
                        height: 50,
                        decoration: const BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(
                                    'assets/icons/psychological_icon.png'),
                                fit: BoxFit.cover)))),
              ]),
        ));
  }
}

class CalendarWidget extends StatelessWidget {
  const CalendarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return TableCalendar(
        focusedDay: DateTime.now(),
        firstDay: DateTime.utc(2023, 1, 1),
        lastDay: DateTime.utc(2023, 12, 31));
  }
}
