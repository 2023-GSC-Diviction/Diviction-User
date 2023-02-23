import 'package:diviction_user/widget/style.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

import '../widget/appbar.dart';

class HomeSceen extends StatefulWidget {
  const HomeSceen({super.key});

  @override
  State<HomeSceen> createState() => _HomeSceenState();
}

class _HomeSceenState extends State<HomeSceen> {
  ColorStyles _colorStyles = ColorStyles();
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
                    CalendarWidget(),
                    checkList(),
                    InkWell(
                        child: Container(
                      width: double.infinity,
                      child: Image.asset(
                          'assets/icons/psychological_test_icon.png'),
                    ))
                  ],
                ),
              ),
            )));
  }

  Widget recordText() {
    return Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Text.rich(
          TextSpan(
              text: '지난 참은 일수 \'13일\'\n',
              style: Theme.of(context).textTheme.titleTextStyle,
              children: <TextSpan>[
                TextSpan(
                    text: '잘 하고 있어요!',
                    style: Theme.of(context).textTheme.titleTextStyle)
              ]),
          textAlign: TextAlign.start,
        ));
  }

  Widget checkList() {
    List<bool> checkBoxList = [false, true, false];
    List<String> list = ['한시간 이상 운동하기', '물 많이 마시기', '약 챙겨먹기'];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('체크리스트', style: Theme.of(context).textTheme.titleTextStyle),
        ListView.builder(
            shrinkWrap: true,
            itemCount: list.length,
            itemBuilder: (context, index) {
              return Row(
                children: [
                  Checkbox(
                      value: checkBoxList[index],
                      onChanged: (value) {
                        checkBoxList[index] = value!;
                      }),
                  Text(list[index],
                      style: TextStyle(
                          fontSize: 16, color: _colorStyles.mainTextColor)),
                ],
              );
            })
      ],
    );
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
