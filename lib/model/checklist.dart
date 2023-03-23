enum CheckListState { BEFORE, ING, SUCCESS, FAILL }

class CheckList {
  int checkListId;
  int patientId;
  String startDate;
  String endDate;
  String content;
  CheckListState state;

  CheckList(
      {required this.checkListId,
      required this.patientId,
      required this.startDate,
      required this.endDate,
      required this.content,
      required this.state});

  factory CheckList.fromJson(Map<String, dynamic> json) {
    return CheckList(
        checkListId: json['checklist_id'],
        patientId: json['patient_id'],
        startDate: json['start_date'],
        endDate: json['end_date'],
        content: json['content'],
        state: CheckListState.values[json['state']]);
  }
}
