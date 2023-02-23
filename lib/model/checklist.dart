enum CheckListState { before, running, uccess, fail }

class CheckList {
  String startDate;
  String endDate;
  String content;
  CheckListState state;

  CheckList(
      {required this.content,
      required this.endDate,
      required this.startDate,
      required this.state});
}
