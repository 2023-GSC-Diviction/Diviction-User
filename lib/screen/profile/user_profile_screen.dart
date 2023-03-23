import 'package:diviction_user/config/style.dart';
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
  SurveyData(
    date: '2021-08-08',
    score: 14,
  ),
  SurveyData(
    date: '2021-08-02',
    score: 38,
  ),
  SurveyData(
    date: '2021-08-01',
    score: 33,
  ),
  SurveyData(
    date: '2021-08-09',
    score: 7,
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

  @override
  void initState() {
    super.initState();
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
                            expandedHeight:
                                MediaQuery.of(context).size.height * 0.37,
                            floating: false,
                            pinned: true,
                            flexibleSpace:
                                const FlexibleSpaceBar(background: _Header())),
                      ];
                    },
                    body: SingleChildScrollView(
                        child: Column(children: [
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
                            SurveyChart(
                              list: surdata,
                            )
                          ],
                        ),
                      )
                    ]))))));
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
