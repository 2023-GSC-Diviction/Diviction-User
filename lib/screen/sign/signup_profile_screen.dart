import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:scroll_date_picker/scroll_date_picker.dart';

import '../../model/network_result.dart';
import '../../network/dio_client.dart';
import '../../widget/profile_image.dart';
import '../../widget/sign/custom_round_button.dart';
import '../../widget/sign/title_header.dart';
import 'login_screen.dart';

class SignUpProfileScreen extends StatefulWidget {
  final String id;
  final String password;
  const SignUpProfileScreen({
    Key? key,
    required this.id,
    required this.password,
  }) : super(key: key);

  @override
  State<SignUpProfileScreen> createState() => _SignUpProfileScreenState();
}

class _SignUpProfileScreenState extends State<SignUpProfileScreen> {
  DateTime selectedDate = DateTime.now();
  DateTime defaultDate = DateTime(
      DateTime.now().year - 19, DateTime.now().month, DateTime.now().day);

  // 회원가입시 프로필 이미지의 path를 DB에 저장하고 프로필 탭에서 DB에 접근하여 사진 로딩하기.
  bool isChoosedPicture = false;
  String path = 'asset/image/DefaultProfileImage.png';

  bool isGenderchoosed = false;
  String userGender = 'MALE';

  TextEditingController textEditingController_name = TextEditingController();
  TextEditingController textEditingController_birth = TextEditingController();
  TextEditingController textEditingController_address = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // GestureDetector를 최상단으로 두고, requestFocus(FocusNode())를 통해서 키보드를 닫을 수 있음.
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.11),
              TitleHeader(
                titleContext: 'Profile',
                subContext: '',
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.025),
              ProfileImage(
                onProfileImagePressed: onProfileImagePressed,
                isChoosedPicture: isChoosedPicture,
                path: path,
                type: 0,
                imageSize: MediaQuery.of(context).size.height * 0.12,
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              _CustomInputField(
                HintText: 'Name',
                inputIcons: Icons.person_outline,
                textEditingController: textEditingController_name,
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.015),
              _CustomInputField(
                HintText: 'Date of Birth',
                inputIcons: Icons.cake_outlined,
                textEditingController: textEditingController_birth,
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.015),
              _DatePicker(
                onDateTimeChanged: onDateTimeChanged,
                selectedDate: selectedDate,
                defaultDate: defaultDate,
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.015),
              _CustomInputField(
                HintText: 'Street Address',
                inputIcons: Icons.home_outlined,
                textEditingController: textEditingController_address,
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.015),
              _GenderChoosed(
                onGenderChoosedMale: onGenderChoosedMale,
                onGenderChoosedFemale: onGenderChoosedFemale,
                userGender: userGender,
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.17),
              CustomRoundButton(
                  title: 'Profile completed!',
                  onPressed: onPressedSignupButton),
              SizedBox(height: MediaQuery.of(context).size.height * 0.10),
            ],
          ),
        ),
      ),
    );
  }

  onDateTimeChanged(DateTime value) {
    setState(() {
      selectedDate = value;
      textEditingController_birth.text =
          '${value.year}-${value.month.toString().padLeft(2, '0')}-${value.day.toString().padLeft(2, '0')}';
    });
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

  onGenderChoosedMale() {
    setState(() {
      isGenderchoosed = true;
      userGender = 'MALE';
    });
    print(userGender);
  }

  onGenderChoosedFemale() {
    setState(() {
      isGenderchoosed = true;
      userGender = 'FEMALE';
    });
    print(userGender);
  }

  onPressedSignupButton() async {
    print('프로필 완성 버튼 눌림');
    print('email : $widget.id');
    print('password : $widget.password');
    print('이름 : ${textEditingController_name.text}');
    print('생년월일 : ${textEditingController_birth.text}');
    print('주소 : ${textEditingController_address.text}');
    print('성별 : ${userGender}');
    print('프로필 이미지 경로 : ${path}');

    // API Call
    String result = await AccountSignup();
    if (result == "200") {
      print("회원가입 성공, 로그인 페이지로 이동하기");
      // 회원가입 성공! 이것도 넣어야 할까요.... 흠
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (_) => LoginScreen()));
    } else {
      print('회원가입 - 오류 발생 $result');
    }
  }

  Future<String> AccountSignup() async {
    var response = await DioClient().post(
      'http://15.164.100.67:8080/auth/signUp/counselor',
      {
        'email': widget.id,
        'password': widget.password,
        'name': textEditingController_name.text,
        'address': textEditingController_address.text,
        'birth': textEditingController_birth.text,
        'gender':
            'MAIL', // Male / Female로 구현했는데 백엔드에서 MAIL이 아니면 error 떠서 수정 요청할 계획임
        'profile_img_url': path,
        'confirm': false,
      },
      false,
    );

    if (response.result == Result.success) {
      return '200';
    } else {
      return response.toString();
    }
  }
}

class _CustomInputField extends StatelessWidget {
  final HintText;
  final textEditingController;
  final inputIcons;

  const _CustomInputField({
    Key? key,
    required this.HintText,
    required this.textEditingController,
    required this.inputIcons,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.055,
      decoration: BoxDecoration(
        color: Color(0xFFEEEEEE),
        borderRadius: BorderRadius.circular(56),
        border: Border.all(width: 1, color: Colors.black12),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              inputIcons,
              size: 30,
            ),
            SizedBox(width: MediaQuery.of(context).size.width * 0.01),
            Expanded(
              child: TextField(
                controller: textEditingController,
                cursorColor: Colors.grey,
                keyboardType: TextInputType.multiline,
                decoration: InputDecoration(
                  border: InputBorder.none, // TextField 아래 밑줄 제거
                  hintText: HintText,
                  hintStyle: TextStyle(
                    color: Colors.grey[500],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DatePicker extends StatelessWidget {
  final DateTime selectedDate;
  final DateTime defaultDate;
  final ValueChanged<DateTime> onDateTimeChanged;
  const _DatePicker({
    Key? key,
    required this.onDateTimeChanged,
    required this.selectedDate,
    required this.defaultDate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.12,
      child: ScrollDatePicker(
        selectedDate:
            selectedDate == DateTime.now() ? defaultDate : selectedDate,
        locale: Locale('ko'),
        onDateTimeChanged: onDateTimeChanged,
      ),
    );
  }
}

class _GenderChoosed extends StatelessWidget {
  final String userGender;
  final VoidCallback onGenderChoosedMale;
  final VoidCallback onGenderChoosedFemale;

  const _GenderChoosed({
    Key? key,
    required this.userGender,
    required this.onGenderChoosedMale,
    required this.onGenderChoosedFemale,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        GenderButton(
          gender: 'Male',
          onGenderChoosed: onGenderChoosedMale,
          userGender: userGender,
        ),
        SizedBox(width: MediaQuery.of(context).size.width * 0.02),
        GenderButton(
          gender: 'Female',
          onGenderChoosed: onGenderChoosedFemale,
          userGender: userGender,
        ),
      ],
    );
  }
}

class GenderButton extends StatelessWidget {
  final String gender;
  final String userGender;
  final VoidCallback onGenderChoosed;

  const GenderButton({
    Key? key,
    required this.gender,
    required this.userGender,
    required this.onGenderChoosed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: MediaQuery.of(context).size.height * 0.055,
        child: ElevatedButton(
          onPressed: onGenderChoosed,
          style: ElevatedButton.styleFrom(
            // 메인 컬러 - 배경색
            primary: (userGender[0] == gender[0])
                ? Colors.blue[300]
                : Color(0xFFEEEEEE),
            // 서브 컬러 - 글자 및 글자 및 애니메이션 색상
            onPrimary: Colors.black,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(56),
              side: BorderSide(width: 1, color: Colors.black12),
            ),
            textStyle: TextStyle(
              fontWeight: FontWeight.w500,
              color: Colors.grey[500],
              fontSize: 18,
            ),
          ),
          child: Text(gender),
        ),
      ),
    );
  }
}
