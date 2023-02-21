import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:table_calendar/table_calendar.dart';

class HomeSceen extends StatefulWidget {
  const HomeSceen({super.key});

  @override
  State<HomeSceen> createState() => _HomeSceenState();
}

class _HomeSceenState extends State<HomeSceen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: SingleChildScrollView(
              child: Container(
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  children: [
                    recordText(),
                    calendarWidget(),
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
        padding: const EdgeInsets.fromLTRB(20, 25, 20, 25),
        child: const Text.rich(
          TextSpan(
              text: '지난 참은 일수 \'13일\'\n',
              style: TextStyle(
                  fontSize: 22,
                  color: Color.fromRGBO(51, 51, 51, 1),
                  height: 1.4,
                  letterSpacing: 0.02,
                  fontWeight: FontWeight.w800),
              children: <TextSpan>[
                TextSpan(
                    text: '잘 하고 있어요!',
                    style: TextStyle(
                        fontSize: 22,
                        letterSpacing: 0.04,
                        color: Color.fromRGBO(51, 51, 51, 1),
                        fontWeight: FontWeight.w800))
              ]),
          textAlign: TextAlign.start,
        ));
  }

  Widget calendarWidget() {
    return TableCalendar(
        focusedDay: DateTime.now(),
        firstDay: DateTime.utc(2023, 1, 1),
        lastDay: DateTime.utc(2023, 12, 31));
  }

  Widget checkList() {
    List<bool> checkBoxList = [false, true, false];
    List<String> list = ['한시간 이상 운동하기', '물 많이 마시기', '약 챙겨먹기'];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('체크리스트',
            style: TextStyle(
                fontSize: 22,
                color: Color.fromRGBO(51, 51, 51, 1),
                fontWeight: FontWeight.w800)),
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
                          fontSize: 16, color: Color.fromRGBO(51, 51, 51, 1))),
                ],
              );
            })
      ],
    );
  }
}
