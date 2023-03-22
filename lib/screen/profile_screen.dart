import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../model/survey_result.dart';
import '../widget/custom_textfiled.dart';
import '../widget/profile_image.dart';
import '../widget/survey/survey_chart.dart';

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

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool isChoosedPicture = false;
  // 수정권한 부여, 프로필 수정 페이지와 미리보기 페이지의 차이점이 없어서 스크린을 2개로 만들기가 애매합니다.
  bool isMyPage = true; // 로그인시 받아온 이메일 값과 해당 정보의 이메일 값을 비교해서 초기화 시키기
  bool isEditMode = false; // Edit 버튼 눌림
  String path = 'asset/image/DefaultProfileImage.png';

  // '대표 서비스', '한줄소개', '활동 지역', '연락 가능 시간', '질문답변'
  List<String> Title = [
    // 'Name',
    'Introduction',
    'Representative Service',
    'Activity Area',
    'Contact Hours',
    'Question Answer' // Q&A에 대해서 질문 준비해야함(중독자, 상담자)
  ];
  List<TextEditingController> textEditingController = [
    // TextEditingController(), // 0 이름
    TextEditingController(), // 1 대표 서비스
    TextEditingController(), // 2 한줄 소개
    TextEditingController(), // 3 활동 지역
    TextEditingController(), // 4 연락 가능 시간
    TextEditingController(), // 5 질문과 답변
  ];

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: SafeArea(
        child: Scaffold(
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () {
              // 상담 요청
            },
            label: const Text('request consult'),
            icon: const Icon(Icons.favorite),
            backgroundColor: Colors.blue,
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(top: 12),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _Header(
                      isMyPage: isMyPage,
                      isEditMode: isEditMode,
                      onEditButtonpressed: onEditButtonpressed),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.0115),
                  ProfileImage(
                    onProfileImagePressed: onProfileImagePressed,
                    isChoosedPicture: isChoosedPicture,
                    path: path,
                    type: 0,
                    imageSize: MediaQuery.of(context).size.height * 0.12,
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.014),
                  const Text(
                    'Exodus Trivellan', // 이 정보는 회원가입 프로필 작성시에 받아옴. -> DB set -> 여기서 get
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                  Text(
                    'Alcoholism Counselor', // 이 정보는 회원가입 프로필 작성시에 받을 수 있게 추가해야 할 듯
                    style: TextStyle(
                      fontSize: 17,
                      color: Colors.grey[700],
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.032),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.symmetric(horizontal: 25),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        const ReviewCountTexts(
                          SubContent: '200',
                          TitleContent: 'Contacted',
                        ),
                        SizedBox(
                            width: MediaQuery.of(context).size.width * 0.1),
                        // SizedBox(child: right_line()),
                        const ReviewCountTexts(
                          SubContent: '125',
                          TitleContent: 'Consulting',
                        ),
                        SizedBox(
                            width: MediaQuery.of(context).size.width * 0.1),
                        // SizedBox(child: right_line()),
                        const ReviewCountTexts(
                          SubContent: '29Y',
                          TitleContent: 'Career',
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.032),
                  Column(
                    children: [0, 1, 2, 3, 4]
                        .map(
                          (index) => IntrinsicHeight(
                            child: CustomTextEditor(
                              TitleContent: Title[index],
                              textEditingController:
                                  textEditingController[index],
                              isreadOnly: !isEditMode,
                            ),
                          ),
                        )
                        .toList(),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.032),
                  SurveyChart(
                    list: surdata,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
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
    if (isEditMode) {
      // API Call - 회원 프로필 업데이트
    }
    setState(() {
      isEditMode = !isEditMode;
    });
  }
}

class _Header extends StatelessWidget {
  final bool isMyPage;
  final bool isEditMode;
  final VoidCallback onEditButtonpressed;

  const _Header({
    Key? key,
    required this.isMyPage,
    required this.isEditMode,
    required this.onEditButtonpressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.07,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Profile',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 23,
              ),
            ),
            if (isMyPage)
              TextButton(
                onPressed: onEditButtonpressed,
                child: Text(
                  isEditMode ? 'Done' : 'Edit',
                  style: TextStyle(
                    fontSize: 18,
                    color:
                        isEditMode ? Colors.redAccent : const Color(0xFF3AAFA1),
                    // color: Colors.white,
                  ),
                ),
              )
          ],
        ),
      ),
    );
  }
}

class ReviewCountTexts extends StatelessWidget {
  final String TitleContent;
  final String SubContent;

  const ReviewCountTexts({
    Key? key,
    required this.TitleContent,
    required this.SubContent,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flexible(
        flex: 1,
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                SubContent,
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w900,
                ),
                maxLines: 1,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.002,
              ),
              Text(
                TitleContent,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                  color: Colors.grey[700],
                ),
                maxLines: 1,
              ),
            ],
          ),
        ));
  }
}
