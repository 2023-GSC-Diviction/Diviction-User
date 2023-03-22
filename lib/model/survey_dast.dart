class SurveyDAST {
  List<String> drug;
  String date;
  String member_email;
  int frequency;
  int injection;
  int cure;
  int question;

  SurveyDAST({
    required this.drug,
    required this.date,
    required this.member_email,
    required this.frequency,
    required this.injection,
    required this.cure,
    required this.question,
  });

  Map<String, dynamic> toJson() => {
        'drug': drug,
        'date': date,
        'member_email': member_email,
        'frequency': frequency,
        'injection': injection,
        'cure': cure,
        'question': question,
      };
}
