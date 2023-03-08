import 'package:diviction_user/config/style.dart';
import 'package:diviction_user/config/text_for_survey.dart';
import 'package:diviction_user/widget/appbar.dart';
import 'package:diviction_user/widget/survey/back_and_next_button.dart';
import 'package:diviction_user/widget/survey/answer_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart';

class PsychologicalSurvey extends StatefulWidget {
  const PsychologicalSurvey({Key? key}) : super(key: key);

  @override
  State<PsychologicalSurvey> createState() => _PsychologicalSurveyState();
}

final int MaxValue = 21;

class _PsychologicalSurveyState extends State<PsychologicalSurvey> {
  int currentIndex = 1;
  // choosedAnswers : 1번 질문 부터 11번 질문까지에 대한 응답을 저장함 12개
  List<int> choosedAnswers = List.generate(MaxValue + 1, (index) => -1);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: const MyAppbar(
          isMain: false,
          title: 'Psychological Self Diagnosis',
          hasBack: true,
        ),
        body: Padding(
          padding: const EdgeInsets.only(left: 16, right: 16, bottom: 32),
          child: SingleChildScrollView(
            child: Column(
              children: [
                FAProgressBar(
                  currentValue: (currentIndex / MaxValue) * 100,
                  displayText: '%',
                  size: 24, // 높이
                  progressColor: Colors.blue,
                  border: Border.all(width: 1.5, color: Colors.black12),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                Text(psychological_question[currentIndex],
                    style: TextStyles.questionTextStyle),
                SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                SurveyAnswerButton(
                  currentIndex: currentIndex,
                  choosedAnswer: choosedAnswers,
                  onAnswerPressed: onAnswerPressed,
                  answerText: psychological_answer,
                  type: "psychological",
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 45),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      PreOrNextButton(
                        content: 'Back',
                        icondata: Icons.west,
                        onPressed: onBackButtonPressed,
                      ),
                      PreOrNextButton(
                        content: currentIndex != MaxValue ? 'Next' : 'Result',
                        icondata:
                            currentIndex != MaxValue ? Icons.east : Icons.done,
                        onPressed: onNextButtonPressed,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void onAnswerPressed(int index) {
    setState(() {
      choosedAnswers[currentIndex] = index;
      print(choosedAnswers);
    });
  }

  void onBackButtonPressed() {
    setState(() {
      if (currentIndex >= 1) {
        currentIndex -= 1;
        print('currentIndex $currentIndex');
      }
    });
  }

  void onNextButtonPressed() {
    setState(() {
      if (currentIndex == 0) {
        currentIndex += 1;
        return;
      }
      // currentIndex 문항에 대해 응답하지 않은 경우 - 개발을 위해 주석처리
      // if (choosedAnswers[currentIndex] == -1) {
      //   print('$currentIndex번 문항이 응답되지 않았습니다.'); // -> 나중엔 토스트로 띄우기
      //   return;
      // }
      if (currentIndex != MaxValue) {
        currentIndex += 1;
        print('currentIndex $currentIndex');
        return;
      }
      if (currentIndex == MaxValue) {
        print("심리검사 완료");
        // 점수 합산 - (psychological) 제일 앞 값 제거
        var AnswerResult = choosedAnswers.sublist(1, choosedAnswers.length);
        var sum = AnswerResult.reduce((value, element) => value + element);
        print('1~21번 문항에 대한 응답값 : $AnswerResult');
        print('총 점수 : $sum');
        // 화면 전환 - 결과화면으로 이동
      }
    });
  }
}
