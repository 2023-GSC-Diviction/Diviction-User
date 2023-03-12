import 'package:diviction_user/screen/sign/signup_profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../config/style.dart';
import '../../provider/auth_provider.dart';
import '../../widget/sign/custom_round_button.dart';
import '../../widget/sign/title_header.dart';
import '../profile_screen.dart';

class CustomTextEditingController {
  final TextEditingController idController = TextEditingController();
  final TextEditingController pwController = TextEditingController();
  final TextEditingController checkPwController = TextEditingController();
}

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  TextEditingController textEditingController_id = TextEditingController();
  TextEditingController textEditingController_pw = TextEditingController();
  TextEditingController textEditingController_checkpw = TextEditingController();

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
              SizedBox(height: MediaQuery.of(context).size.height * 0.27),
              const TitleHeader(
                titleContext: 'Sign Up',
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
              SizedBox(height: MediaQuery.of(context).size.height * 0.015),
              _CustomInputField(
                HintText: 'Check your Password',
                textEditingController: textEditingController_checkpw,
              ),
              const _PopLoginPage(),
              SizedBox(height: MediaQuery.of(context).size.height * 0.115),
              CustomRoundButton(
                title: 'Create Account',
                onPressed: onPressedSignupButton,
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.10),
            ],
          ),
        ),
      ),
    );
  }

  onPressedSignupButton() {
    print('회원가입 버튼 눌림');
    print('아이디 : ${textEditingController_id.text}');
    print('비밀번호1 : ${textEditingController_pw.text}');
    print('비밀번호2 : ${textEditingController_checkpw.text}');

    // 비밀번호 일치 체크
    if (textEditingController_pw.text != textEditingController_checkpw.text) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('check your password')));
    } else if (textEditingController_id.text == '' ||
        textEditingController_pw.text == '' ||
        textEditingController_checkpw.text == '') {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('fill in the blanks')));
    } else {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (BuildContext context) => SignUpProfileScreen(
            id: textEditingController_id.text,
            password: textEditingController_pw.text,
          ),
        ),
      );
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

class _PopLoginPage extends StatelessWidget {
  const _PopLoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        const SizedBox(),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const Text(
                "Already have an account?",
                style: TextStyles.underlineTextStyle,
              ),
              SizedBox(width: MediaQuery.of(context).size.width * 0.02),
              const Text(
                'Log in',
                style: TextStyle(color: Color(0xFF3E3E3E)),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
