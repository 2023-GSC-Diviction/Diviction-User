import 'package:diviction_user/config/style.dart';
import 'package:diviction_user/model/network_result.dart';
import 'package:diviction_user/provider/survey_provider.dart';
import 'package:diviction_user/service/survey_service.dart';
import 'package:diviction_user/widget/appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../model/counselor.dart';
import '../../model/survey_result.dart';
import '../../model/user.dart';
import '../../service/auth_service.dart';
import '../../widget/custom_textfiled.dart';
import '../../widget/profile_image.dart';
import '../../widget/survey/survey_chart.dart';
import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';

final surdata = [
  SurveyData(
    date: '2021-08-01',
    score: 30,
  ),
  SurveyData(
    date: '2021-08-02',
    score: 13,
  ),
  SurveyData(
    date: '2021-08-06',
    score: 22,
  ),
];

final editModeProvider = StateProvider((ref) => false);

@override
class UserProfileScreen extends ConsumerStatefulWidget {
  const UserProfileScreen({Key? key}) : super(key: key);

  @override
  UserProfileScreenState createState() => UserProfileScreenState();
}

class UserProfileScreenState extends ConsumerState<UserProfileScreen> {
  List<String> title = [
    'Introduction',
    'Activity Area',
    'Contact Hours',
    'Question Answer' // Q&A에 대해서 질문 준비해야함(중독자, 상담자)
  ];
  List<TextEditingController> textEditingController = [
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
  ];

  late Map<String, List<Map<String, dynamic>>> datas;
  late Future<Map<String, List<Map<String, dynamic>>>> futureData;

  @override
  void initState() {
    super.initState();
    futureData = loadData();
  }

  Future<Map<String, List<Map<String, dynamic>>>> loadData() async {
    final List<Map<String, dynamic>> DASS_result =
        await SurveyService().DASSdataGet();
    final List<Map<String, dynamic>> DAST_result =
        await SurveyService().DASTdataGet();
    final List<Map<String, dynamic>> AUDIT_result =
        await SurveyService().AUDITdataGet();
    datas = {
      'DASS': [],
      'DAST': [],
      'AUDIT': [],
    };
    setState(() {
      DASS_result.forEach((data) {
        datas['DASS']!.add({
          'date': data['date'],
          'melancholyScore': data['melancholyScore'],
          'unrestScore': data['unrestScore'],
          'stressScore': data['stressScore'],
        });
      });
      print('DAST_result.length : ${DAST_result.length}');
      DAST_result.forEach((data) {
        Map<String, dynamic> surveyData = {
          'date': data['date'],
          'score': data['question'],
        };
        datas['DAST']!.add(surveyData);
      });
      print(datas);
      AUDIT_result.forEach((data) {
        Map<String, dynamic> surveyData = {
          'date': data['date'],
          'score': data['score'],
        };
        datas['AUDIT']!.add(surveyData);
      });
    });
    return datas;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    ref.invalidate(editModeProvider);
  }

  @override
  Widget build(BuildContext context) {
    final editMode = ref.watch(editModeProvider);

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Palette.appColor,
          body: NestedScrollView(
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                SliverAppBar(
                    backgroundColor: Palette.appColor,
                    leading: null,
                    toolbarHeight: 0,
                    automaticallyImplyLeading: false,
                    expandedHeight: MediaQuery.of(context).size.height * 0.37,
                    floating: false,
                    pinned: true,
                    flexibleSpace:
                        const FlexibleSpaceBar(background: _Header())),
              ];
            },
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      ),
                    ),
                    padding: const EdgeInsets.only(top: 30),
                    child: Column(
                      children: [
                        Column(
                          children: [0, 1, 2, 3]
                              .map(
                                (index) => IntrinsicHeight(
                                  child: CustomTextEditor(
                                    TitleContent: title[index],
                                    textEditingController:
                                        textEditingController[index],
                                    isreadOnly: !editMode,
                                  ),
                                ),
                              )
                              .toList(),
                        ),
                        const SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 8),
                          child: Container(
                            decoration: BoxDecoration(
                              // color: Colors.white, // grey[100], Color(0x00FFFFFF)
                              borderRadius: BorderRadius.circular(16),
                              border:
                                  Border.all(width: 1, color: Colors.black12),
                            ),
                            padding: const EdgeInsets.all(8.0),
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height * 0.33,
                            child: FutureBuilder<
                                Map<String, List<Map<String, dynamic>>>>(
                              future: futureData,
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  // 로딩 중일 때 표시할 UI
                                  return Center(
                                      child: CircularProgressIndicator());
                                } else if (snapshot.hasData) {
                                  // 데이터를 성공적으로 받아올 때 표시할 UI
                                  Map<String, List<Map<String, dynamic>>> data =
                                      snapshot.data!;
                                  return ContainedTabBarView(
                                    tabs: [
                                      Text('DASS',
                                          style:
                                              TextStyle(color: Colors.black)),
                                      Text('DAST',
                                          style:
                                              TextStyle(color: Colors.black)),
                                      Text('AUDIT',
                                          style:
                                              TextStyle(color: Colors.black)),
                                    ],
                                    views: [
                                      Survey_Chart(data: data['DASS']!, maxY: 42),
                                      Survey_Chart(data: data['DAST']!, maxY: 10),
                                      Survey_Chart(data: data['DAST']!, maxY: 40), // AUDIT
                                    ],
                                    onChange: (index) => print(index),
                                  );
                                } else if (snapshot.hasError) {
                                  // 에러가 발생했을 때 표시할 UI
                                  return Text('Error: ${snapshot.error}');
                                } else {
                                  // 아직 로딩 중이거나 데이터를 받아오지 못했을 때 표시할 UI
                                  return Center(child: Text('Data Load Error'));
                                }
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class Survey_Chart extends StatefulWidget {
  final List<Map<String, dynamic>> data;
  final double maxY;

  const Survey_Chart({
    Key? key,
    required this.data,
    required this.maxY,
  }) : super(key: key);

  @override
  State<Survey_Chart> createState() => _Survey_ChartState();
}

class _Survey_ChartState extends State<Survey_Chart> {
  @override
  Widget build(BuildContext context) {
    print('widget.data : ${widget.data.toString()}');
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // dividingLine,
        Padding(
          padding: const EdgeInsets.only(left: 3),
          child: (widget.data != null && widget.data != [])
              ? SurveyChart(
                  list: widget.data,
                  maxY: widget.maxY,
                )
              : Center(child: CircularProgressIndicator()),
        ),
      ],
    );
  }
}

final userProvider = FutureProvider<User>((ref) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  String email = prefs.getString('email')!;

  return await AuthService().getUser(email);
});

class _Header extends ConsumerStatefulWidget {
  const _Header({
    Key? key,
  }) : super(key: key);

  @override
  _HeaderState createState() => _HeaderState();
}

class _HeaderState extends ConsumerState<_Header> {
  bool isChoosedPicture = false;
  // 수정권한 부여, 프로필 수정 페이지와 미리보기 페이지의 차이점이 없어서 스크린을 2개로 만들기가 애매합니다.
  // 로그인시 받아온 이메일 값과 해당 정보의 이메일 값을 비교해서 초기화 시키기
  String path = 'asset/image/DefaultProfileImage.png';

  @override
  Widget build(BuildContext context) {
    final editMode = ref.watch(editModeProvider);
    final user = ref.watch(userProvider);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _TopBar(onEditButtonpressed: onEditButtonpressed),
        SizedBox(height: MediaQuery.of(context).size.height * 0.0115),
        Padding(
            padding: const EdgeInsets.only(top: 12, left: 35, right: 35),
            child: user.when(
              data: (data) => Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.15,
                      child: Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            ProfileImage(
                              onProfileImagePressed: onProfileImagePressed,
                              isChoosedPicture: isChoosedPicture,
                              path: data.profile_img_url,
                              type: editMode ? 0 : 1,
                              imageSize:
                                  MediaQuery.of(context).size.height * 0.15,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: const [],
                            ),
                          ]),
                    ),
                    SizedBox(
                        height: MediaQuery.of(context).size.height * 0.032),
                    Text(
                      data.name, // 이 정보는 회원가입 프로필 작성시에 받아옴. -> DB set -> 여기서 get
                      style: const TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w800,
                          color: Colors.white),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                    Text(
                      data.address, // 이 정보는 회원가입 프로필 작성시에 받을 수 있게 추가해야 할 듯
                      style: const TextStyle(
                        fontSize: 17,
                        color: Colors.white54,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ]),
              loading: () => const CircularProgressIndicator(),
              error: (error, stackTrace) => const Center(
                child: Text('fail to load'),
              ),
            )),
      ],
    );
  }

  onProfileImagePressed() async {
    print("onProfileImagePressed 실행완료");
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        this.isChoosedPicture = true;
        this.path = image.path;
      });
    }
    print(image);
  }

  onEditButtonpressed() {
    // 수정후 Done 버튼이 눌렸을 때 API Call을 통해서 내용 업데이트 해줘야 함
    if (ref.read(editModeProvider.notifier).state) {
      // API Call - 회원 프로필 업데이트
    }
    ref.read(editModeProvider.notifier).state = !ref.read(editModeProvider);
  }
}

class _TopBar extends ConsumerWidget {
  final VoidCallback onEditButtonpressed;

  const _TopBar({
    Key? key,
    required this.onEditButtonpressed,
  }) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isEditMode = ref.watch(editModeProvider);
    // TODO: implement build
    return Container(
      padding: EdgeInsets.only(
        left: MediaQuery.of(context).size.width * 0.05,
        right: MediaQuery.of(context).size.width * 0.05,
      ),
      height: MediaQuery.of(context).size.height * 0.07,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'Profile',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.w700,
              color: Colors.white,
              fontSize: 23,
            ),
          ),
          TextButton(
            onPressed: onEditButtonpressed,
            child: Text(
              isEditMode ? 'Done' : 'Edit',
              style: TextStyle(
                fontSize: 18,
                color: isEditMode
                    ? Colors.redAccent
                    : const Color.fromARGB(255, 227, 250, 247),
                // color: Colors.white,
              ),
            ),
          )
        ],
      ),
    );
  }
}

class ReviewCountTexts extends StatelessWidget {
  final String titleContent;
  final String subContent;

  const ReviewCountTexts({
    Key? key,
    required this.titleContent,
    required this.subContent,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flexible(
        flex: 1,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              subContent,
              style: const TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.w900,
                  color: Colors.white),
              maxLines: 1,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.002,
            ),
            Text(
              titleContent,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: Color.fromARGB(165, 255, 255, 255),
              ),
              maxLines: 1,
            ),
          ],
        ));
  }
}
