import 'package:flutter/material.dart';

// 0~12번 질문의 예상답변(중복선택x), 라디오 버튼
class SurveyAnswerButton extends StatelessWidget {
  final int currentIndex;
  final List<int> choosedAnswer;
  final onAnswerPressed;
  final answerText;

  const SurveyAnswerButton({
    Key? key,
    required this.currentIndex,
    required this.choosedAnswer,
    required this.onAnswerPressed,
    required this.answerText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ...List.generate(answerText[currentIndex]!.length, (index) => index).map(
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
                    child: Center(
                      child: Text(
                        answerText[currentIndex]![index],
                        style: choosedAnswer[currentIndex] == index
                            ? const TextStyle(fontSize: 20, color: Colors.white)
                            : const TextStyle(
                            fontSize: 20, color: Colors.black87),
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