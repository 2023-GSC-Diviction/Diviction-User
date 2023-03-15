import 'package:diviction_user/screen/survey/alcohol_survey.dart';
import 'package:diviction_user/screen/survey/drug_survey.dart';
import 'package:diviction_user/screen/survey/psychological_survey.dart';
import 'package:diviction_user/screen/survey/survey_result.dart';
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
        appBar: const MyAppbar(
          isMain: true,
          hasBack: false,
        ),
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
                      type: 'Drug',
                      screen: DrugSurvey(), // 테스트 : SurveyResult
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TestButton(
                      type: 'Alcohol',
                      screen: AlcoholSurvey(),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TestButton(
                      type: 'psychological',
                      screen: PsychologicalSurvey(),
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
              text: '이번달 참은 일 수 \'13일\'\n',
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
          .map(
            (e) => Row(
              children: [
                Checkbox(
                  value: e,
                  onChanged: (value) {
                    checkBoxList[checkBoxList.indexOf(e)] = value!;
                  },
                ),
                Text(
                  list[checkBoxList.indexOf(e)],
                  style: const TextStyle(
                      fontSize: 16, color: Palette.mainTextColor),
                ),
              ],
            ),
          )
          .toList(),
    );
  }
}

class TestButton extends StatelessWidget {
  final String type;
  final screen;

  TestButton({
    super.key,
    required this.type,
    required this.screen,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => screen)); // 테스트중으로 변경함
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
            Text('$type Test',
                style: const TextStyle(
                    fontSize: 16, color: Palette.mainTextColor)),
            ClipOval(
              child: Container(
                width: 50,
                height: 50,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/icons/psychological_icon.png'),
                      fit: BoxFit.cover),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CalendarWidget extends StatelessWidget {
  const CalendarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final defalutBoxDeco = BoxDecoration(
      color: Colors.grey[200], // 평일 색상지정
      borderRadius: BorderRadius.circular(6),
    );
    final defaultTextStyle = TextStyle(
      color: Colors.grey[600], // 평일 색상지정
      fontWeight: FontWeight.w700,
    );
    const PRIMARY_COLOR = Color(0xFF0DB2B2);
    return TableCalendar(
      locale: 'en_US',
      focusedDay: DateTime.now(),
      firstDay: DateTime.utc(2023, 1, 1),
      lastDay: DateTime.utc(2023, 12, 31),
      calendarStyle: CalendarStyle(
          isTodayHighlighted: false, // 오늘 날짜를 하이라이트 처리할지 말지에 대해

          // 평일 날짜 디자인
          defaultDecoration: defalutBoxDeco,
          defaultTextStyle: defaultTextStyle,
          // 주말
          weekendDecoration: defalutBoxDeco,
          weekendTextStyle: defaultTextStyle,
          // 선택한 날짜
          selectedDecoration: BoxDecoration(
            color: Colors.white, // 평일 색상지정
            borderRadius: BorderRadius.circular(6),
            border: Border.all(
              color: PRIMARY_COLOR,
              width: 1,
            ),
          ),
          selectedTextStyle: defaultTextStyle.copyWith(
            color: PRIMARY_COLOR,
          ),
          // 해당 월이 아닌 이전달의 날이나 다음달의 날들
          outsideDecoration: BoxDecoration(
            shape: BoxShape.rectangle,
          )),
    );
  }
}
