import 'package:diviction_user/model/counselor.dart';
import 'package:diviction_user/screen/profile/counselor_profile_screen.dart';
import 'package:diviction_user/screen/survey/alcohol_survey.dart';
import 'package:diviction_user/screen/survey/drug_survey.dart';
import 'package:diviction_user/screen/survey/psychological_survey.dart';
import 'package:diviction_user/screen/survey/survey_result.dart';
import 'package:diviction_user/service/counselor_service.dart';
import 'package:diviction_user/util/getUserData.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:table_calendar/table_calendar.dart';

import '../config/style.dart';
import '../provider/counselor_provider.dart';
import '../widget/appbar.dart';

final counselorListProvider = FutureProvider.autoDispose<List<Counselor>>(
    (ref) => CounselorService().getCounselors({}));

class HomeSceen extends StatefulWidget {
  const HomeSceen({super.key});

  @override
  State<HomeSceen> createState() => _HomeSceenState();
}

class _HomeSceenState extends State<HomeSceen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserData();
  }

  getUserData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      name = prefs.getString('name')!;
    });
  }

  String name = 'User';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const MyAppbar(
          isMain: true,
          hasBack: false,
        ),
        backgroundColor: Palette.appColor,
        body: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: SingleChildScrollView(
              child: Container(
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      recordText(),
                      const SizedBox(
                        height: 20,
                      ),
                      // const Text('My Check List',
                      //     style: TextStyle(
                      //         fontSize: 23,
                      //         color: Colors.white,
                      //         height: 1.4,
                      //         letterSpacing: 0.02,
                      //         fontWeight: FontWeight.w600)),
                      // const SizedBox(
                      //   height: 20,
                      // ),
                      checkList(),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text('Survey',
                          style: TextStyle(
                              fontSize: 23,
                              color: Colors.white,
                              height: 1.4,
                              letterSpacing: 0.02,
                              fontWeight: FontWeight.w600)),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(children: const [
                        SurveyButton(
                          title: 'Drug',
                          screen: DrugSurvey(),
                        ),
                        SizedBox(width: 20),
                        SurveyButton(
                          title: 'Alcohol',
                          screen: AlcoholSurvey(),
                        ),
                        SizedBox(width: 20),
                        SurveyButton(
                          title: 'Psychological',
                          screen: PsychologicalSurvey(),
                        )
                      ]),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text('Recommend Counselor',
                          style: TextStyle(
                              fontSize: 23,
                              color: Colors.white,
                              height: 1.4,
                              letterSpacing: 0.02,
                              fontWeight: FontWeight.w600)),
                      const SizedBox(
                        height: 20,
                      ),
                      Consumer(
                        builder: (context, ref, child) {
                          final counselor = ref.watch(counselorListProvider);
                          return counselor.when(
                            data: (data) {
                              if (data.isEmpty) {
                                return const Text('No Counselor');
                              } else {
                                return CounselorCard(counselor: data);
                              }
                            },
                            loading: () => const Text('Loading...',
                                style: TextStyle(color: Colors.white)),
                            error: (error, stackTrace) => const Text('Error...',
                                style: TextStyle(color: Colors.white)),
                          );
                        },
                      )
                    ],
                  )),
            )));
  }

  Widget recordText() {
    return Container(
        width: MediaQuery.of(context).size.width,
        child: Text.rich(
          TextSpan(
              text: 'Hello, ',
              style: const TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  letterSpacing: 0.02,
                  fontWeight: FontWeight.w400),
              children: <TextSpan>[
                TextSpan(
                  text: '\n$name!',
                  style: const TextStyle(
                      fontSize: 30,
                      color: Colors.white,
                      height: 1.4,
                      letterSpacing: 0.02,
                      fontWeight: FontWeight.w700),
                )
              ]),
          textAlign: TextAlign.start,
        ));
  }

  Widget checkList() {
    List<bool> checkBoxList = [false, true, false];
    List<String> list = [
      '한시간 이상 운동하기',
      '물 많이 마시기',
      '약 챙겨먹기',
    ];
    return Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white54,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: checkBoxList
              .map(
                (e) => Row(
                  children: [
                    Checkbox(
                      fillColor: MaterialStateProperty.all(Palette.appColor),
                      value: e,
                      onChanged: (value) {
                        checkBoxList[checkBoxList.indexOf(e)] = value!;
                      },
                    ),
                    Text(
                      list[checkBoxList.indexOf(e)],
                      style: const TextStyle(
                          fontSize: 18,
                          color: Colors.black87,
                          height: 1.4,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              )
              .toList(),
        ));
  }
}

class CounselorCard extends StatelessWidget {
  const CounselorCard({super.key, required this.counselor});

  final List<Counselor> counselor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: MediaQuery.of(context).size.width * 0.6,
        child: ListView.builder(
          itemCount: counselor.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return InkWell(
                onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CounselorProfileScreen(
                              counselor: counselor[index])),
                    ),
                child: Container(
                    width: MediaQuery.of(context).size.width * 0.6,
                    height: MediaQuery.of(context).size.width * 0.6,
                    alignment: Alignment.bottomCenter,
                    child: Stack(children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.6,
                        height: MediaQuery.of(context).size.width * 0.6,
                        margin: const EdgeInsets.only(right: 20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30),
                          image: DecorationImage(
                              image: counselor[index].profileUrl != null
                                  ? NetworkImage(
                                      // widget.path,
                                      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSeCrEganpCMO0qMEgtrYGYcyc9BLr6nQflaA&usqp=CAU')
                                  : const AssetImage(
                                          '/assets/icons/counselor.png')
                                      as ImageProvider,
                              fit: BoxFit.cover),
                        ),
                      ),
                      Positioned(
                          bottom: 0,
                          left: MediaQuery.of(context).size.width * 0.03,
                          right: MediaQuery.of(context).size.width * 0.03,
                          child: Container(
                            margin: EdgeInsets.only(
                              right: 20,
                              bottom: MediaQuery.of(context).size.width * 0.03,
                            ),
                            decoration: BoxDecoration(
                              color: Color.fromARGB(255, 255, 189, 193),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            alignment: Alignment.center,
                            width: MediaQuery.of(context).size.width * 0.54,
                            height: MediaQuery.of(context).size.width * 0.2,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  counselor[index].name,
                                  style: const TextStyle(
                                      fontSize: 24,
                                      color: Colors.white,
                                      letterSpacing: 0.02,
                                      fontWeight: FontWeight.w600),
                                ),
                                Text(
                                  counselor[index].address,
                                  style: const TextStyle(
                                      fontSize: 15,
                                      color: Colors.white,
                                      letterSpacing: 0.02,
                                      fontWeight: FontWeight.w400),
                                ),
                              ],
                            ),
                          ))
                    ])));
          },
        ));
  }
}

class SurveyButton extends StatelessWidget {
  const SurveyButton({super.key, required this.title, required this.screen});

  final String title;
  final Widget screen;

  @override
  Widget build(BuildContext context) {
    return Expanded(
        flex: 1,
        child: InkWell(
            onTap: () => Navigator.push(
                context, MaterialPageRoute(builder: (context) => screen)),
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 10),
              height: MediaQuery.of(context).size.height * 0.14,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Icon(
                    Icons.medication_liquid,
                    size: MediaQuery.of(context).size.height * 0.06,
                    color: Palette.appColor,
                  ),
                  Text(title,
                      style: const TextStyle(
                          fontSize: 16, color: Palette.mainTextColor))
                ],
              ),
            )));
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
