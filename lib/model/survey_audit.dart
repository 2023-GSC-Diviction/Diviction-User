class SurveyAUDIT {
  int memberId;
  int q1;
  int score;

  SurveyAUDIT({
    required this.memberId,
    required this.q1,
    required this.score,
  });

  Map<String, dynamic> toJson() => {
    'memberId': memberId,
    'q1': q1,
    'score': score,
  };
}