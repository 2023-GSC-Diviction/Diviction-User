import 'dart:io';

import 'package:dio/dio.dart';
import 'package:diviction_user/service/image_picker_service.dart';
import 'package:diviction_user/widget/edit_profile_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:scroll_date_picker/scroll_date_picker.dart';

import '../../provider/auth_provider.dart';
import '../../widget/profile_image.dart';
import '../../widget/sign/custom_round_button.dart';
import '../../widget/sign/title_header.dart';
import 'login_screen.dart';
import 'package:http/http.dart' as http;

final authProvider = StateNotifierProvider.autoDispose<AuthState, LoadState>(
    (ref) => AuthState());

final imageProvider = StateProvider<String?>((ref) => null);

class SignUpProfileScreen extends ConsumerStatefulWidget {
  final String id;
  final String password;
  const SignUpProfileScreen({
    Key? key,
    required this.id,
    required this.password,
  }) : super(key: key);

  @override
  SignUpProfileScreenState createState() => SignUpProfileScreenState();
}

class SignUpProfileScreenState extends ConsumerState<SignUpProfileScreen> {
  DateTime selectedDate = DateTime.now();
  DateTime defaultDate = DateTime(
      DateTime.now().year - 19, DateTime.now().month, DateTime.now().day);

  // 회원가입시 프로필 이미지의 path를 DB에 저장하고 프로필 탭에서 DB에 접근하여 사진 로딩하기.
  bool isChoosedPicture = false;
  String path = 'asset/image/DefaultProfileImage.png';

  bool isGenderchoosed = false;
  String userGender = 'MALE';

  TextEditingController textEditingControllerForName = TextEditingController();
  TextEditingController textEditingControllerForBirth = TextEditingController();
  TextEditingController textEditingControllerForAddress =
      TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    ref.invalidate(authProvider);
    ref.invalidate(imageProvider);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isComplete = ref.watch(authProvider);
    final userImage = ref.watch(imageProvider);

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      switch (isComplete) {
        case LoadState.success:
          ref.invalidate(authProvider);
          toLogin();
          break;

        case LoadState.fail:
          showSnackbar();
          break;
        default:
          break;
      }
    });

    // GestureDetector를 최상단으로 두고, requestFocus(FocusNode())를 통해서 키보드를 닫을 수 있음.
    return GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Scaffold(
          body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 10),
              child: SingleChildScrollView(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                    Column(
                      children: [
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.1),
                        const TitleHeader(
                          titleContext: 'Profile',
                          subContext: '',
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.025),
                        EditProfileImage(
                          onProfileImagePressed: onProfileImagePressed,
                          path: userImage,
                          type: 1,
                          imageSize: MediaQuery.of(context).size.height * 0.12,
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.05),
                        _CustomInputField(
                          HintText: 'Name',
                          inputIcons: Icons.person_outline,
                          textEditingController: textEditingControllerForName,
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.01),
                        _CustomInputField(
                          HintText: 'Date of Birth',
                          inputIcons: Icons.cake_outlined,
                          textEditingController: textEditingControllerForBirth,
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.01),
                        _DatePicker(
                          onDateTimeChanged: onDateTimeChanged,
                          selectedDate: selectedDate,
                          defaultDate: defaultDate,
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.01),
                        _CustomInputField(
                          HintText: 'Street Address',
                          inputIcons: Icons.home_outlined,
                          textEditingController:
                              textEditingControllerForAddress,
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.01),
                        _GenderChoosed(
                          onGenderChoosedMale: onGenderChoosedMale,
                          onGenderChoosedFemale: onGenderChoosedFemale,
                          userGender: userGender,
                        ),
                      ],
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.1),
                    CustomRoundButton(
                        title: 'Profile completed!',
                        onPressed: () => onPressedSignupButton(userImage)),
                  ]))),
        ));
  }

  void showSnackbar() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('signUp fail'),
      ),
    );
  }

  toLogin() {
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (context) => const LoginScreen(),
        ),
        (route) => false);
  }

  onDateTimeChanged(DateTime value) {
    setState(() {
      selectedDate = value;
      textEditingControllerForBirth.text =
          '${value.year}-${value.month.toString().padLeft(2, '0')}-${value.day.toString().padLeft(2, '0')}';
    });
  }

  onProfileImagePressed() async {
    print("onProfileImagePressed 실행완료");
    final File? image = await ImagePickerService().pickSingleImage();

    if (image != null) {
      ref.read(imageProvider.notifier).state = image.path;
      setState(() {
        isChoosedPicture = true;
      });
    }
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

  onPressedSignupButton(String? image) async {
    print('프로필 완성 버튼 눌림');
    print('email : ${widget.id}');
    print('password : ${widget.password}');
    print('이름 : ${textEditingControllerForName.text}');
    print('생년월일 : ${textEditingControllerForBirth.text}');
    print('주소 : ${textEditingControllerForAddress.text}');
    print('성별 : ${userGender}');
    print('프로필 이미지 경로 : ${path}');
    // MultipartFile multipartFile = await MultipartFile.fromFile(ImageFile!.path, filename: 'upload');
    // print(multipartFile.toString());
    Map<String, String> user = {
      'email': widget.id,
      'password': widget.password,
      'name': textEditingControllerForName.text,
      'address': textEditingControllerForAddress.text,
      'birth': textEditingControllerForBirth.text,
      'gender': userGender,
      // 'multipartFile': multipartFile,
      // 'profile_img_url': path
    };
    print(user.toString());
    if (image != null) {
      ref.read(authProvider.notifier).SignupWithloadImage(image, user);
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
        color: const Color(0xFFEEEEEE),
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
        locale: const Locale('ko'),
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
                : const Color(0xFFEEEEEE),
            // 서브 컬러 - 글자 및 글자 및 애니메이션 색상
            onPrimary: Colors.black,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(56),
              side: const BorderSide(width: 1, color: Colors.black12),
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
