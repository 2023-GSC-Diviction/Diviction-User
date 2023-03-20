import 'package:diviction_user/config/style.dart';
import 'package:diviction_user/config/text_for_survey.dart';
import 'package:diviction_user/model/survey_dast.dart';
import 'package:diviction_user/screen/survey/survey_result.dart';
import 'package:diviction_user/widget/appbar.dart';
import 'package:diviction_user/widget/survey/answer_button.dart';
import 'package:diviction_user/widget/survey/back_and_next_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../provider/survey_provider.dart';

class DrugSurvey extends StatefulWidget {
  const DrugSurvey({Key? key}) : super(key: key);

  @override
  State<DrugSurvey> createState() => _DrugSurveyState();
}

final int MaxValue = 12;

class _DrugSurveyState extends State<DrugSurvey> {
  int currentIndex = -1;
  List<bool> checkBoxList = List.generate(9, (index) => false); // false 8개
  // choosedAnswers : 0번 질문 부터 12번 질문까지에 대한 응답을 저장함 13개
  List<int> choosedAnswers = List.generate(MaxValue + 1, (index) => -1);
  List<String> SelectedDrugsName = []; // 마약 선택시에 초기화
  ScrollController _scrollController =
      ScrollController(); // Next 버튼 누르면 스크롤 위치 초기화 되게할 때 사용

  @override
  Widget build(BuildContext context) {
    // checkBoxList에서 true인 값의 인덱스만 골라 배열로 가져오는 코드
    List<int> SelectedDrugs =
        List.generate(checkBoxList.length, (index) => index)
            .where((index) => checkBoxList[index] == true)
            .toList();
    SelectedDrugsName =
        List.generate(SelectedDrugs.length, (index) => drug_answer[-1]![index]);
    return SafeArea(
      child: Scaffold(
        appBar: const MyAppbar(
          isMain: false,
          title: 'Drug Self Diagnosis',
          hasBack: true,
        ),
        body: Padding(
          padding: const EdgeInsets.only(left: 16, right: 16, bottom: 32),
          child: SingleChildScrollView(
            child: Column(
              children: [
                FAProgressBar(
                  currentValue: ((currentIndex + 2) / (MaxValue + 2)) * 100,
                  displayText: '%',
                  size: 24, // 높이
                  progressColor: Colors.blue,
                  border: Border.all(width: 1.5, color: Colors.black12),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                Text(drug_question[currentIndex + 1],
                    style: TextStyles.questionTextStyle),
                SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                if (currentIndex == -1)
                  DrugChoose(
                    checkBoxList: checkBoxList,
                    drugCheckBoxPressed: drugCheckBoxPressed,
                  ),
                if (currentIndex != -1)
                  SurveyAnswerButton(
                    currentIndex: currentIndex,
                    choosedAnswer: choosedAnswers,
                    onAnswerPressed: onAnswerPressed,
                    answerText: drug_answer,
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

  void drugCheckBoxPressed(int index) {
    setState(() {
      checkBoxList[index] = !checkBoxList[index];
    });
  }

  void onAnswerPressed(int index) {
    setState(() {
      choosedAnswers[currentIndex] = index;
      print(choosedAnswers);
    });
  }

  void onBackButtonPressed() {
    setState(() {
      if (currentIndex >= 0) {
        currentIndex -= 1;
        print('currentIndex $currentIndex');
      }
    });
  }

  void onNextButtonPressed() {
    setState(() {
      if (currentIndex == -1) {
        if (SelectedDrugsName.length == 0) {
          print('어떤 약물을 사용했는지 입력하지 않았습니다.'); // -> 나중엔 토스트로 띄우기
          return;
        }
        currentIndex += 12; // test로 += 1을 12로 변경함
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
        print("약물 선별검사 완료");
        print(choosedAnswers);
        // 점수 합산 - (drug) 제일 앞 값과 제일 뒤에 값은 제거
        var AnswerResult = choosedAnswers.sublist(1, choosedAnswers.length - 2);
        var sum = AnswerResult.reduce((value, element) => value + element);
        print('1~10번 문항에 대한 응답값 : $AnswerResult');
        print('총 점수 : $sum');
        // 화면 전환 - 결과화면으로 이동
        SurveyDAST surveyDAST = SurveyDAST(
            drug: SelectedDrugsName,
            date: DateTime.now().toString().split(' ')[0],
            userId: 'user1@gmail.com',
            frequency: choosedAnswers[0],
            injection: choosedAnswers[11],
            cure: choosedAnswers[12],
            question: sum,
        );
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => SurveyResult(),
          settings: RouteSettings(arguments: [surveyDAST, 'DAST']),
        ));
      }
    });
  }
}

// 마약 선택, 0번 질문의 예상답변(중복선택o), 체크박스
class DrugChoose extends StatelessWidget {
  final checkBoxList;
  final drugCheckBoxPressed;
  const DrugChoose({
    Key? key,
    required this.checkBoxList,
    required this.drugCheckBoxPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.5,
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(16),
        border: Border.all(width: 1, color: Colors.black12),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 16, 16, 16),
        child: ListView.builder(
          itemCount: drug_answer[-1]!.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: index != drug_answer[-1]!.length - 1
                  ? const EdgeInsets.only(bottom: 12)
                  : EdgeInsets.zero,
              child:
                  // 전체를 InkWell로 감싸서 체크박스는 UI로 사용하고 한 라인 어디든 클릭시 체크되게 구현함
                  InkWell(
                onTap: () => drugCheckBoxPressed(index),
                child: Row(
                  children: [
                    Checkbox(
                      materialTapTargetSize: MaterialTapTargetSize.padded,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(3.0),
                      ),
                      value: checkBoxList[index],
                      onChanged: (value) {
                        drugCheckBoxPressed(index);
                      },
                    ),
                    Expanded(
                      child: Text(
                        drug_answer[-1]![index],
                        maxLines: null,
                        style: TextStyles.answerTextStyle,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
