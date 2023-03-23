import 'package:diviction_user/model/checklist.dart';
import 'package:diviction_user/model/counselor.dart';
import 'package:diviction_user/screen/profile/counselor_profile_screen.dart';
import 'package:diviction_user/screen/survey/alcohol_survey.dart';
import 'package:diviction_user/screen/survey/drug_survey.dart';
import 'package:diviction_user/screen/survey/psychological_survey.dart';
import 'package:diviction_user/screen/survey/survey_result.dart';
import 'package:diviction_user/service/auth_service.dart';
import 'package:diviction_user/service/checklist_service.dart';
import 'package:diviction_user/service/counselor_service.dart';
import 'package:diviction_user/service/match_service.dart';
import 'package:diviction_user/util/getUserData.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:table_calendar/table_calendar.dart';

import '../config/style.dart';
import '../provider/counselor_provider.dart';
import '../widget/appbar.dart';
import '../widget/survey/survey_button.dart';

final counselorProvider = FutureProvider.autoDispose<List<Counselor>>((ref) {
  final isMatched = ref.watch(matchingProvider);
  if (isMatched) {
    return CounselorService().getCounselors({});
  } else {
    return [
      Counselor(
        id: 6,
        email: 'email',
        password: 'password',
        name: 'Nick',
        address: 'address',
        birth: 'birth',
        gender: 'gender',
        profileUrl:
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSeCrEganpCMO0qMEgtrYGYcyc9BLr6nQflaA&usqp=CAU',
        confirm: true,
      )
    ];
  }
});

final checkListProvider = FutureProvider.autoDispose<List<CheckList>>(
    (ref) => ChecklistService().getChecklists());

final matchingProvider = StateProvider<bool>((ref) => false);

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

  bool isMatched = false;
  String name = 'User';

  getUserData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      name = prefs.getString('name')!;
      isMatched = prefs.getBool('isMatched') ?? false;
    });
  }

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
                      _Header(name: name),
                      const SizedBox(
                        height: 20,
                      ),
                      _Bottom(isMatched: isMatched)
                    ],
                  )),
            )));
  }
}

class _Header extends StatelessWidget {
  const _Header({super.key, required this.name});
  final String name;

  @override
  Widget build(BuildContext context) {
    Widget recordText() => Container(
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

    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
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
      CheckListWidget(),
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
    ]);
  }
}

class _Bottom extends StatelessWidget {
  const _Bottom({super.key, required this.isMatched});

  final bool isMatched;

  @override
  Widget build(BuildContext context) {
    return !isMatched
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
                  final counselor = ref.watch(counselorProvider);
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
          )
        : Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const Text('My Counselor',
                style: TextStyle(
                    fontSize: 23,
                    color: Colors.white,
                    height: 1.4,
                    letterSpacing: 0.02,
                    fontWeight: FontWeight.w600)),
            const SizedBox(
              height: 20,
            ),
            Consumer(builder: (context, ref, child) {
              final counselor = ref.watch(counselorProvider);
              return counselor.when(
                data: (data) {
                  if (data.isEmpty) {
                    return const Text('No Counselor');
                  } else {
                    return CounselorCard(
                      counselor: data,
                      size: MediaQuery.of(context).size.width - 60,
                    );
                  }
                },
                loading: () => const Text('Loading...',
                    style: TextStyle(color: Colors.white)),
                error: (error, stackTrace) => const Text('Error...',
                    style: TextStyle(color: Colors.white)),
              );
            })
          ]);
  }
}

class CheckListWidget extends ConsumerWidget {
  const CheckListWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final checkList = ref.watch(checkListProvider);
    return Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white38,
          borderRadius: BorderRadius.circular(20),
        ),
        width: double.infinity,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: checkList.when(
                data: ((data) {
                  if (data.isEmpty) {
                    return [
                      Container(
                        padding: const EdgeInsets.only(left: 15),
                        child: const Text(
                          'no checkList in today',
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                              height: 1.4,
                              fontWeight: FontWeight.w600),
                        ),
                      )
                    ];
                  } else {
                    return data
                        .map(
                          (e) => Row(
                            children: [
                              Checkbox(
                                fillColor:
                                    MaterialStateProperty.all(Palette.appColor),
                                value: false,
                                onChanged: (value) {
                                  if (value!) {
                                    e.state = CheckListState.SUCCESS;
                                  } else {
                                    e.state = CheckListState.FAILL;
                                  }
                                },
                              ),
                              Text(
                                e.content,
                                style: const TextStyle(
                                    fontSize: 18,
                                    color: Colors.black87,
                                    height: 1.4,
                                    fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                        )
                        .toList();
                  }
                }),
                loading: () => [const Text('Loading...')],
                error: (error, stackTrace) => [
                      const Text(
                        'fail to load checkList',
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.black87,
                            height: 1.4,
                            fontWeight: FontWeight.w600),
                      ),
                    ])));
  }
}

class CounselorCard extends StatelessWidget {
  const CounselorCard({super.key, required this.counselor, this.size});

  final List<Counselor> counselor;
  final double? size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: size ?? MediaQuery.of(context).size.width * 0.6,
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
                    width: size ?? MediaQuery.of(context).size.width * 0.6,
                    height: size ?? MediaQuery.of(context).size.width * 0.6,
                    alignment: Alignment.bottomCenter,
                    child: Stack(children: [
                      Container(
                        width: size ?? MediaQuery.of(context).size.width * 0.6,
                        height: size ?? MediaQuery.of(context).size.width * 0.6,
                        margin: const EdgeInsets.only(right: 20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30),
                          image: DecorationImage(
                              image: counselor[index].profileUrl != null
                                  ? const NetworkImage(
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
                              color: const Color.fromARGB(255, 255, 189, 193),
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
