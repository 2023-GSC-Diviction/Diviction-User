import 'package:flutter/material.dart';

// 0~12번 질문의 예상답변(중복선택x), 라디오 버튼
class SurveyAnswerButton extends StatelessWidget {
  final int currentIndex;
  final List<int> choosedAnswer;
  final onAnswerPressed;
  final answerText;
  final type;

  const SurveyAnswerButton({
    Key? key,
    required this.currentIndex,
    required this.choosedAnswer,
    required this.onAnswerPressed,
    required this.answerText,
    this.type,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var answerList = List.generate(4, (index) => index); // 심리검사
    if (type != 'psychological') // 약물, 알코올
      answerList =
          List.generate(answerText[currentIndex]!.length, (index) => index);

    return Column(
      children: [
        ...answerList.map(
          (index) => Column(
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.002),
              SizedBox(
                width: double.infinity, // 최대 너비로 설정
                child: InkWell(
                  onTap: () => onAnswerPressed(index),
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.1,
                    decoration: BoxDecoration(
                      color: choosedAnswer[currentIndex] == index
                          ? Colors.blue
                          : Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(width: 1, color: Colors.black12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Center(
                        child: Text(
                          type != 'psychological'
                              ? answerText[currentIndex]![index]
                              : answerText['All']![index],
                          style: choosedAnswer[currentIndex] == index
                              ? const TextStyle(fontSize: 20, color: Colors.white)
                              : const TextStyle(
                                  fontSize: 20, color: Colors.black87),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),
            ],
          ),
        ),
      ],
    );
  }
}
