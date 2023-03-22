import 'package:diviction_user/network/dio_client.dart';
import 'package:diviction_user/service/match_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import '../../config/style.dart';
import '../../model/counselor.dart';
import '../../service/auth_service.dart';
import '../../util/getUserData.dart';
import '../../widget/custom_textfiled.dart';
import '../../widget/profile_image.dart';

@override
class CounselorProfileScreen extends ConsumerStatefulWidget {
  const CounselorProfileScreen({Key? key, required this.counselor})
      : super(key: key);

  final Counselor counselor;
  @override
  CounselorProfileScreenState createState() => CounselorProfileScreenState();
}

class CounselorProfileScreenState
    extends ConsumerState<CounselorProfileScreen> {
  // '대표 서비스', '한줄소개', '활동 지역', '연락 가능 시간', '질문답변'
  List<String> title = [
    // 'Name',
    'Introduction',
    'Representative Service',
    'Activity Area',
    'Contact Hours',
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
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: SafeArea(
            child: Scaffold(
                backgroundColor: Palette.appColor,
                floatingActionButton: FloatingActionButton.extended(
                  onPressed: () async {
                    final user = await GetUser.getUserId();
                    MatchingService()
                        .createMatch(user, widget.counselor.id)
                        .then((value) {
                      if (value) {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text('request success'),
                        ));
                      } else {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text('request fail'),
                        ));
                      }
                    });
                  },
                  label: const Text('request consult'),
                  icon: const Icon(Icons.add_reaction_sharp),
                  backgroundColor: Palette.appColor,
                ),
                floatingActionButtonLocation:
                    FloatingActionButtonLocation.centerFloat,
                body: NestedScrollView(
                    headerSliverBuilder:
                        (BuildContext context, bool innerBoxIsScrolled) {
                      return <Widget>[
                        SliverAppBar(
                            backgroundColor: Palette.appColor,
                            leading: IconButton(
                                icon: const Icon(Icons.arrow_back_ios_new),
                                onPressed: () => Navigator.pop(context)),
                            expandedHeight:
                                MediaQuery.of(context).size.height * 0.45,
                            floating: false,
                            pinned: true,
                            toolbarHeight:
                                MediaQuery.of(context).size.height * 0.08,
                            title: Text(
                              'About ${widget.counselor.name}',
                              style: const TextStyle(
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                                fontSize: 23,
                              ),
                            ),
                            flexibleSpace: FlexibleSpaceBar(
                                background:
                                    _Header(counselor: widget.counselor))),
                      ];
                    },
                    body: SingleChildScrollView(
                        child: Container(
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
                            children: title
                                .map((e) => Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 10, horizontal: 20),
                                      child: Column(
                                        children: [
                                          Container(
                                            margin: const EdgeInsets.only(
                                                bottom: 8),
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            child: Text(
                                              e,
                                              style: const TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w600,
                                                color: Colors.black,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ))
                                .toList(),
                          ),
                        ],
                      ),
                    ))))));
  }
}

class _Header extends ConsumerStatefulWidget {
  const _Header({
    Key? key,
    required this.counselor,
  }) : super(key: key);

  final Counselor counselor;

  @override
  _HeaderState createState() => _HeaderState();
}

class _HeaderState extends ConsumerState<_Header> {
  bool isChoosedPicture = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: MediaQuery.of(context).size.height * 0.08),
        Padding(
          padding: const EdgeInsets.only(left: 35, right: 35),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.counselor
                      .name, // 이 정보는 회원가입 프로필 작성시에 받아옴. -> DB set -> 여기서 get
                  style: const TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w800,
                      color: Colors.white),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                Text(
                  widget.counselor
                      .address, // 이 정보는 회원가입 프로필 작성시에 받을 수 있게 추가해야 할 듯
                  style: const TextStyle(
                    fontSize: 17,
                    color: Colors.white54,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      ProfileImage(
                        onProfileImagePressed: () {},
                        isChoosedPicture: isChoosedPicture,
                        path: widget.counselor.profileUrl,
                        type: 1,
                        imageSize: MediaQuery.of(context).size.height * 0.15,
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.03),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: const [
                          ReviewCountTexts(
                            subContent: '200',
                            titleContent: 'Contacted',
                          ),
                          ReviewCountTexts(
                            subContent: '125',
                            titleContent: 'Consulting',
                          ),
                          ReviewCountTexts(
                            subContent: '29Y',
                            titleContent: 'Career',
                          ),
                        ],
                      ),
                    ]),
              ]),
        ),
      ],
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
              style: TextStyle(
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
