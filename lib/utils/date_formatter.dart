import 'package:intl/intl.dart';

class DateTimeFormatter {
  static String formatDate(String dateTime) {
    final formatter = DateFormat('dd MMM yyyy');
    return formatter.format(DateTime.parse(dateTime));
  }
}