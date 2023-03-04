import 'package:diviction_user/config/style.dart';
import 'package:diviction_user/config/text_for_survey.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart';

class DrugSelfDiagnosis extends StatefulWidget {
  const DrugSelfDiagnosis({Key? key}) : super(key: key);

  @override
  State<DrugSelfDiagnosis> createState() => _DrugSelfDiagnosisState();
}

class _DrugSelfDiagnosisState extends State<DrugSelfDiagnosis> {
  int currentIndex = 1;
  int MaxValue = 8;
  List<bool> checkBoxList = List.generate(10, (index) => false); // false 10개
  List<int> choosedAnswer = List.generate(7, (index) => -1); // -1로 초기화함

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
          child: Column(
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.005),
              FAProgressBar(
                currentValue: (currentIndex / MaxValue) * 100,
                displayText: '%',
                size: 20, // 높이
                progressColor: Colors.blue,
                border: Border.all(width: 2, color: Colors.black12),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.01),
              Text(
                question[currentIndex - 1],
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
              if (currentIndex == 1)
                DrugChoose(
                  checkBoxList: checkBoxList,
                  drugCheckBoxPressed: drugCheckBoxPressed,
                ),
              if (currentIndex != 1)
                ExpectedAnswer(
                  currentIndex: currentIndex,
                  choosedAnswer: choosedAnswer,
                  onAnswerPressed: onAnswerPressed,
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
                      content: 'Next',
                      icondata: Icons.east,
                      onPressed: onNextButtonPressed,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void drugCheckBoxPressed(int index) {
    setState(() {
      checkBoxList[index] = !checkBoxList[index];
      print(checkBoxList);
    });
  }

  void onAnswerPressed(int index) {
    setState(() {
      choosedAnswer[currentIndex-2] = index;
      print(index);
      print(choosedAnswer);
    });
  }

  void onBackButtonPressed() {
    setState(() {
      if (currentIndex > 1) currentIndex -= 1;
    });
  }

  void onNextButtonPressed() {
    setState(() {
      if (currentIndex < 8) currentIndex += 1;
      print(choosedAnswer);
    });
  }
}

// 1번 질문의 예상답변(중복선택o), 체크박스
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
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(16),
        border: Border.all(width: 1, color: Colors.black12),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 16, 16, 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: List.generate(10, (index) => index)
              .map(
                (index) => Column(
                  children: [
                    // 전체를 ElevatedButton으로 감싸서 체크박스는 UI로 사용하고 한 라인 어디든 클릭시 체크되게 구현함
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
                              answer[1]![index],
                              maxLines: null,
                              style: const TextStyle(
                                  fontSize: 20, color: Palette.mainTextColor),
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (index != 9) const SizedBox(height: 15),
                  ],
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}

// 2~8번 질문의 예상답변(중복선택x), 라디오 버튼
class ExpectedAnswer extends StatelessWidget {
  final int currentIndex;
  final List<int> choosedAnswer;
  final onAnswerPressed;

  const ExpectedAnswer({
    Key? key,
    required this.currentIndex,
    required this.choosedAnswer,
    required this.onAnswerPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(answer[currentIndex]!.length, (index) => index)
          .map(
            (index) => Column(
              children: [
                SizedBox(
                  width: double.infinity, // 최대 너비로 설정
                  child: InkWell(
                    onTap: () => onAnswerPressed(index),
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.1,
                      decoration: BoxDecoration(
                        color: choosedAnswer[currentIndex-2] == index
                            ? Colors.blue
                            : Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(width: 1, color: Colors.black12),
                      ),
                      child: Center(
                        child: Text(
                          answer[currentIndex]![index],
                          style: const TextStyle(fontSize: 20),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 15),
              ],
            ),
          )
          .toList(),
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
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: content == 'Back'
              ? [
                  Icon(icondata),
                  SizedBox(width: MediaQuery.of(context).size.width * 0.02),
                  Text(
                    content,
                    style: TextStyle(fontSize: 20),
                  ),
                ]
              : [
                  Text(
                    content,
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(width: MediaQuery.of(context).size.width * 0.02),
                  Icon(icondata),
                ],
        ),
      ),
    );
  }
}
