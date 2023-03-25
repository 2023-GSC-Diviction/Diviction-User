import 'package:diviction_user/screen/sign/signup_profile_screen.dart';
import 'package:diviction_user/service/auth_service.dart';
import 'package:diviction_user/util/input_validate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../config/style.dart';
import '../../widget/sign/custom_round_button.dart';
import '../../widget/sign/title_header.dart';

enum EmailDuplicateState { proceeding, success, fail, apifail }

final idCheckProvider =
    StateProvider<EmailDuplicateState>((ref) => EmailDuplicateState.proceeding);

class SignupScreen extends ConsumerStatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  SignupScreenState createState() => SignupScreenState();
}

class SignupScreenState extends ConsumerState<SignupScreen> {
  TextEditingController textEditingControllerForId = TextEditingController();
  TextEditingController textEditingControllerForPw = TextEditingController();
  TextEditingController textEditingControllerForCheckPw =
      TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ref.read(idCheckProvider.notifier).state =
        EmailDuplicateState.proceeding; // 초기화
  }

  @override
  void dispose() {
    // TODO: implement dispose
    ref.invalidate(idCheckProvider);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final idCheckState = ref.watch(idCheckProvider);

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      switch (idCheckState) {
        case EmailDuplicateState.success:
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => SignUpProfileScreen(
                      id: textEditingControllerForId.text,
                      password: textEditingControllerForPw.text)));
          break;
        case EmailDuplicateState.fail:
          showSnackbar('duplicate email');
          break;
        case EmailDuplicateState.apifail:
          showSnackbar('sign up failed');
          break;
        default:
      }
      ref.read(idCheckProvider.notifier).state = EmailDuplicateState.proceeding;
    });

    // GestureDetector를 최상단으로 두고, requestFocus(FocusNode())를 통해서 키보드를 닫을 수 있음.
    return GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Scaffold(
            body: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: SingleChildScrollView(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                      Column(
                        children: [
                          SizedBox(
                              height: MediaQuery.of(context).size.height * 0.2),
                          const TitleHeader(
                            titleContext: 'Sign Up',
                            subContext:
                                'Experience a service that helps prevent and treat various addictions with Diviction.',
                          ),
                          SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.05),
                          _CustomInputField(
                            HintText: 'E-Mail',
                            textEditingController: textEditingControllerForId,
                          ),
                          SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.015),
                          _CustomInputField(
                            HintText: 'Password',
                            textEditingController: textEditingControllerForPw,
                          ),
                          SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.015),
                          _CustomInputField(
                            HintText: 'Check your Password',
                            textEditingController:
                                textEditingControllerForCheckPw,
                          ),
                          const _PopLoginPage(),
                        ],
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.05),
                      CustomRoundButton(
                          title: 'Create Account',
                          onPressed: onPressedSignupButton),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.10),
                    ])))));
  }

  void showSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  onPressedSignupButton() {
    print('회원가입 버튼 눌림');
    print('아이디 : ${textEditingControllerForId.text}');
    print('비밀번호1 : ${textEditingControllerForPw.text}');
    print('비밀번호2 : ${textEditingControllerForCheckPw.text}');

    // 비밀번호 일치 체크
    if (textEditingControllerForId.text == '' ||
        textEditingControllerForPw.text == '' ||
        textEditingControllerForCheckPw.text == '') {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('fill in the blanks')));
    } else if (textEditingControllerForPw.text !=
        textEditingControllerForCheckPw.text) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('check your password')));
    } else if (!InputValidate(textEditingControllerForId.text)
        .isValidEmailFormat()) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('check your email')));
    } else {
      // 이메일 중복 체크
      checkEmail(textEditingControllerForId.text);
    }
  }

  void checkEmail(String email) async {
    try {
      bool result = await AuthService().emailCheck(email, 'ROLE_USER');
      if (result) {
        ref.read(idCheckProvider.notifier).state = EmailDuplicateState.success;
      } else {
        ref.read(idCheckProvider.notifier).state = EmailDuplicateState.fail;
      }
    } catch (e) {
      ref.read(idCheckProvider.notifier).state = EmailDuplicateState.apifail;
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
