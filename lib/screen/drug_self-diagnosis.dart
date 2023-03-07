import 'package:diviction_user/config/style.dart';
import 'package:diviction_user/config/text_for_survey.dart';
import 'package:diviction_user/widget/appbar.dart';
import 'package:diviction_user/widget/survey_answer_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart';

class DrugSelfDiagnosis extends StatefulWidget {
  const DrugSelfDiagnosis({Key? key}) : super(key: key);

  @override
  State<DrugSelfDiagnosis> createState() => _DrugSelfDiagnosisState();
}

final int MaxValue = 12;

class _DrugSelfDiagnosisState extends State<DrugSelfDiagnosis> {
  int currentIndex = -1;
  List<bool> checkBoxList = List.generate(8, (index) => false); // false 8개
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
        List.generate(SelectedDrugs.length, (index) => answer[1]![index]);
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
                Text(question[currentIndex+1],
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
                    answerText: answer,
                  ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 56),
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
        currentIndex += 1;
        return;
      }
      // 하나라도 응답하지 않은 경우
      // if (choosedAnswers.any((value) => value == -1)) {
      //   print("응답되지 않은 문항이 있습니다."); // -> 나중엔 토스트로 띄우기
      //   _scrollToBottom();
      //   return;
      // }
      if (currentIndex != MaxValue) {
        currentIndex += 1;
        print('currentIndex $currentIndex');
        return;
      }
      if (currentIndex == MaxValue) {
        print("자가진단 완료");
        choosedAnswers.forEach(
          (innerList) {
            print(SelectedDrugsName[choosedAnswers.indexOf(innerList)]);
            print(innerList);
            // 계산로직 추가하기
            // API콜해서 데이터 저장하고
            // 화면 전환
            // Navigator.push(context,
            //     MaterialPageRoute(builder: (context) => DrugSurveyResult()));
          },
        );
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
          itemCount: answer[-1]!.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: index != answer[-1]!.length - 1
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
                        answer[-1]![index],
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



class QuestionTextWidget extends StatelessWidget {
  final String question;
  const QuestionTextWidget({
    Key? key,
    required this.question,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          // borderRadius: BorderRadius.circular(6),
          color: Colors.grey[200],
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 8),
          child: Text(
            question,
            style: const TextStyle(
              fontSize: 20,
              color: Colors.black,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
    );
  }
}

class PreOrNextButton extends StatelessWidget {
  final String content;
  final IconData? icondata;
  final VoidCallback onPressed;

  const PreOrNextButton({
    Key? key,
    required this.content,
    required this.icondata,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.3,
      height: MediaQuery.of(context).size.height * 0.07,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: content == 'Back'
              ? [
                  Icon(icondata),
                  SizedBox(width: MediaQuery.of(context).size.width * 0.02),
                  Text(
                    content,
                    style: const TextStyle(fontSize: 20),
                  ),
                ]
              : [
                  Text(
                    content,
                    style: const TextStyle(fontSize: 20),
                  ),
                  SizedBox(width: MediaQuery.of(context).size.width * 0.02),
                  Icon(icondata),
                ],
        ),
      ),
    );
  }
}
