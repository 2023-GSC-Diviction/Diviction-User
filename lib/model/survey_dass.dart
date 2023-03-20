class SurveyDASS {
  int memberId;
  int melancholyScore;
  int unrestScore;
  int stressScore;

  SurveyDASS({
    required this.memberId,
    required this.melancholyScore,
    required this.unrestScore,
    required this.stressScore,
  });

  Map<String, dynamic> toJson() => {
    'memberId': memberId,
    'melancholyScore': melancholyScore,
    'unrestScore': unrestScore,
    'stressScore': stressScore,
  };
}
