class SurveyDAST {
  List<String> drug;
  String date;
  String userId;
  int frequency;
  int injection;
  int cure;
  int question;

  SurveyDAST({
    required this.drug,
    required this.date,
    required this.userId,
    required this.frequency,
    required this.injection,
    required this.cure,
    required this.question,
  });

  Map<String, dynamic> toJson() => {
        'drug': drug,
        'date': date,
        'userId': userId,
        'frequency': frequency,
        'injection': injection,
        'cure': cure,
        'question': question,
      };
}
