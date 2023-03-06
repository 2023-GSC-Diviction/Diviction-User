import 'package:diviction_user/config/style.dart';
import 'package:diviction_user/config/text_for_survey.dart';
import 'package:diviction_user/widget/appbar.dart';
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
  List<List<int>> choosedAnswers = []; // 마약 선택시에 그 개수에 맞게 초기화
  ScrollController _scrollController = ScrollController(); // Next 버튼 누르면 스크롤 위치 초기화 되게할 때 사용

  @override
  Widget build(BuildContext context) {
    // checkBoxList에서 true인 값의 인덱스만 골라 배열로 가져오는 코드
    List<int> SelectedDrugs =
        List.generate(checkBoxList.length, (index) => index)
            .where((index) => checkBoxList[index] == true)
            .toList();
    // print(SelectedDrugs);
    if (SelectedDrugs.length != choosedAnswers.length) {
      choosedAnswers = List.generate(
          SelectedDrugs.length,
          (index) =>
              List.generate(answer[currentIndex]!.length, (index) => -1));
    }
    // print(choosedAnswers);
    return SafeArea(
      child: Scaffold(
        appBar: const MyAppbar(
          isMain: false,
          title: 'Drug Self Diagnosis',
          hasBack: true,
        ),
        body: Padding(
          padding: const EdgeInsets.only(left: 16, right: 16, bottom: 32),
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
              Text(question[currentIndex - 1],
                  style: TextStyles.questionTextStyle),
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
              if (currentIndex == 1)
                DrugChoose(
                  checkBoxList: checkBoxList,
                  drugCheckBoxPressed: drugCheckBoxPressed,
                ),
              if (currentIndex != 1)
                Expanded(
                  child: ListView.builder(
                    controller: _scrollController,
                    itemCount: SelectedDrugs.length,
                    itemBuilder: (context, index) {
                      return ExpectedAnswer(
                        DrugName: answer[1]![SelectedDrugs[index]],
                        currentIndex: currentIndex,
                        choosedAnswer: choosedAnswers[index],
                        onAnswerPressed: onAnswerPressed,
                        ID: index,
                      );
                    },
                  ),
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
    });
  }

  void onAnswerPressed(int ID, int index) {
    setState(() {
      choosedAnswers[ID][currentIndex - 2] = index;
    });
  }

  void onBackButtonPressed() {
    setState(() {
      if (currentIndex > 1) currentIndex -= 1;
    });
    _scrollToTop();
  }

  void onNextButtonPressed() {
    setState(() {
      if (currentIndex < 8) currentIndex += 1;
    });
    _scrollToTop();
  }

  void _scrollToTop() {
    _scrollController.animateTo(
      0,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
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
      height: MediaQuery.of(context).size.height*0.6,
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(16),
        border: Border.all(width: 1, color: Colors.black12),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 16, 16, 16),
        child: ListView.builder(
          itemCount: 10,
          itemBuilder: (context, index) {
            return Padding(
                padding: index != 9
                    ? const EdgeInsets.only(bottom: 15)
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
                          answer[1]![index],
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

// 2~8번 질문의 예상답변(중복선택x), 라디오 버튼
class ExpectedAnswer extends StatelessWidget {
  final int currentIndex;
  final List<int> choosedAnswer;
  final onAnswerPressed;
  final String DrugName;
  // choosedAnswers를 2중 리스트 배열로 변경하면서 약물 다중 선택시 어느 약물에 대한 응답인지 구별할때 필요하여 만듬
  final int ID;

  const ExpectedAnswer({
    Key? key,
    required this.currentIndex,
    required this.choosedAnswer,
    required this.onAnswerPressed,
    required this.DrugName,
    required this.ID,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ...List.generate(answer[currentIndex]!.length, (index) => index).map(
          (index) => Column(
            children: [
              if (index == 0) DrugNameTextWidget(),
              SizedBox(height: MediaQuery.of(context).size.height * 0.002),
              SizedBox(
                width: double.infinity, // 최대 너비로 설정
                child: InkWell(
                  onTap: () => onAnswerPressed(ID, index),
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.1,
                    decoration: BoxDecoration(
                      color: choosedAnswer[currentIndex - 2] == index
                          ? Colors.blue
                          : Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(width: 1, color: Colors.black12),
                    ),
                    child: Center(
                      child: Text(
                        answer[currentIndex]![index],
                        style: choosedAnswer[currentIndex - 2] == index
                            ? const TextStyle(fontSize: 20, color: Colors.white)
                            : const TextStyle(
                                fontSize: 20, color: Colors.black87),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 15),
            ],
          ),
        ),
        SizedBox(
            height: MediaQuery.of(context).size.height *
                0.03), // 약물 여러개 일때 UI가 붙어있어서 추가함
      ],
    );
  }

  Widget DrugNameTextWidget() {
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
            DrugName,
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
