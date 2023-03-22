import 'package:intl/intl.dart';

String dataTimeFormat(String lastMessageTime) {
  DateTime lastMessageTimeFormat =
      DateFormat('yyyy-MM-dd hh:mm:ss').parse(lastMessageTime);

  String result = '';
  DateTime now = DateTime.now();
  Duration diff = now.difference(lastMessageTimeFormat);
  if (diff.inDays > 0) {
    result = '${diff.inDays}일 전';
  } else if (diff.inHours > 0 && diff.inDays == 0) {
    result = '${diff.inHours}시간 전';
  } else if (diff.inMinutes > 0) {
    result = '${diff.inMinutes}분 전';
  } else {
    result = '방금 전';
  }
  return result;
}
