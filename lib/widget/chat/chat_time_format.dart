import 'package:intl/intl.dart';

String dataTimeFormat(String lastMessageTime) {
  DateTime lastMessageTimeFormat =
      DateFormat('yyyy-MM-dd hh:mm:ss').parse(lastMessageTime);

  String result = '';
  DateTime now = DateTime.now();
  Duration diff = now.difference(lastMessageTimeFormat);
  if (diff.inDays > 0) {
    result = '${diff.inDays} days ago';
  } else if (diff.inHours > 0 && diff.inDays == 0) {
    result = '${diff.inHours} hours ago';
  } else if (diff.inMinutes > 0) {
    result = '${diff.inMinutes} minutes ago';
  } else {
    result = 'now';
  }
  return result;
}
