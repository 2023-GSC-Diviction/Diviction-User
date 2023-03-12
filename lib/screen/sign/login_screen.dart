import 'package:diviction_user/provider/auth_provider.dart';
import 'package:diviction_user/screen/sign/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../config/style.dart';
import '../../model/network_result.dart';
import '../../network/dio_client.dart';
import '../../widget/sign/custom_round_button.dart';
import '../../widget/sign/title_header.dart';
import '../bottom_nav.dart';

final authProvider =
    StateNotifierProvider.autoDispose<AuthState, bool>((ref) => AuthState());

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  TextEditingController textEditingController_id = TextEditingController();
  TextEditingController textEditingController_pw = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final isLogin = ref.watch(authProvider);
    // GestureDetector를 최상단으로 두고, requestFocus(FocusNode())를 통해서 키보드를 닫을 수 있음.

    if (isLogin) {
      Navigator.of(context).push(MaterialPageRoute(
              builder: (_) =>
                  const BottomNavigation()) // 리버팟 적용된 HomeScreen 만들기
          );
    }

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
              const TitleHeader(
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
              const _PushSignupPage(),
              SizedBox(height: MediaQuery.of(context).size.height * 0.20),
              CustomRoundButton(
                title: 'Log In',
                onPressed: onPressedLoginButton,
              ),
              Center(
                child: TextButton(
                  onPressed: () {},
                  child: const Text(
                    "Forget Password?",
                    style: TextStyles.underlineTextStyle,
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

    ref
        .read(authProvider.notifier)
        .login(textEditingController_id.text, textEditingController_pw.text);
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
        color: Colors.white,
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
        const SizedBox(),
        TextButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context) => const SignupScreen(),
              ),
            );
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const Text(
                "Don't have an account?",
                style: TextStyles.underlineTextStyle,
              ),
              SizedBox(width: MediaQuery.of(context).size.width * 0.02),
              const Text(
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
