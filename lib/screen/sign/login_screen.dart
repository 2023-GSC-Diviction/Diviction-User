import 'package:diviction_user/screen/sign/signup_screen.dart';
import 'package:flutter/material.dart';

import '../../model/network_result.dart';
import '../../network/dio_client.dart';
import '../../widget/sign/custom_round_button.dart';
import '../../widget/sign/title_header.dart';
import '../bottom_nav.dart';

final underlineTextStyle = TextStyle(
  color: Color(0xFFC3C3C3),
  decoration: TextDecoration.underline, // 밑줄 넣기
  decorationThickness: 1.5, // 밑줄 두께
  // fontStyle: FontStyle
);

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController textEditingController_id = TextEditingController();
  TextEditingController textEditingController_pw = TextEditingController();

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
              SizedBox(height: MediaQuery.of(context).size.height * 0.21),
              TitleHeader(
                titleContext: 'Log In',
                subContext:
                    'Experience a service that helps prevent and treat various addictions with Diviction.',
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              _CustomInputField(
                HintText: 'E-Mail',
                textEditingController: textEditingController_id,
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.015),
              _CustomInputField(
                HintText: 'Password',
                textEditingController: textEditingController_pw,
              ),
              _PushSignupPage(),
              SizedBox(height: MediaQuery.of(context).size.height * 0.20),
              CustomRoundButton(
                title: 'Log In',
                onPressed: onPressedLoginButton,
              ),
              Center(
                child: TextButton(
                  onPressed: () {},
                  child: Text(
                    "Forget Password?",
                    style: underlineTextStyle,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  onPressedLoginButton() async {
    print('로그인 버튼 눌림');
    print('아이디 : ${textEditingController_id.text}');
    print('비밀번호 : ${textEditingController_pw.text}');

    // id, pw 검증하는 API Call

    // 로그인 성공
    // API Call
    String result = await AccountLogin();
    if (result == "200") {
      print("로그인 성공, 바텀 네비게이션 가진 스크린으로 이동");
      Navigator.of(context).push(MaterialPageRoute(
              builder: (_) => BottomNavigation()) // 리버팟 적용된 HomeScreen 만들기
          );
    }
    // 로그인 실패
    else {
      print('로그인 - 오류 발생 $result');
    }
  }

  Future<String> AccountLogin() async {
    var response = await DioClient().post(
      'http://15.164.100.67:8080/auth/signIn/counsleor', // path counselor가 맞음 오타있음
      {
        'email': textEditingController_id.text,
        'password': textEditingController_pw.text,
        'authority': 'ROLE_COUNSELOR', // 혜진님 : ROLE_USER
      },
      false,
    );

    if (response.result == Result.success) {
      // 여기서 회원 정보 가져오고 UI 구성에 필요한 값들 미리 저장?
      storage.write(
          key: 'accessToken', value: response.response['accessToken']);
      storage.write(
          key: 'refreshToken', value: response.response['refreshToken']);
      final AT = await storage.read(key: 'accessToken');
      final RT = await storage.read(key: 'refreshToken');
      print('accessToken : $AT');
      print('refreshToken : $RT');
      return '200';
    } else {
      return response.toString();
    }
  }
}

class _CustomInputField extends StatelessWidget {
  final HintText;
  final textEditingController;

  const _CustomInputField({
    Key? key,
    required this.HintText,
    required this.textEditingController,
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
              HintText == 'E-Mail' ? Icons.email_outlined : Icons.key_outlined,
              size: 30,
            ),
            SizedBox(width: MediaQuery.of(context).size.width * 0.01),
            Expanded(
              child: TextField(
                obscureText: HintText != 'E-Mail',
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

class _PushSignupPage extends StatelessWidget {
  const _PushSignupPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        SizedBox(),
        TextButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context) => SignupScreen(),
              ),
            );
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                "Don't have an account?",
                style: underlineTextStyle,
              ),
              SizedBox(width: MediaQuery.of(context).size.width * 0.02),
              Text(
                'Sign up',
                style: TextStyle(color: Color(0xFF3E3E3E)),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
