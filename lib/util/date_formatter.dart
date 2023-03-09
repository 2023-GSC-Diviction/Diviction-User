import 'package:intl/intl.dart';

class DateTimeFormatter {
  static String format(DateTime dateTime) {
    return "${dateTime.year}-${dateTime.month}-${dateTime.day} ${dateTime.hour}:${dateTime.minute}:${dateTime.second}";
  }

  static DateTime parse(String dateTime) {
    return DateTime.parse(dateTime);
  }

  static String formatCustom(String dateTime) {
    DateTime date = DateTimeFormatter.parse(dateTime);
    return DateFormat('MM.dd').format(date);
  }
}
