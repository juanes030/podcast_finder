import 'package:intl/intl.dart';

class DateFormatter {
  static String formatFromMilliseconds(int milliseconds) {
    final date =
        DateTime.fromMillisecondsSinceEpoch(milliseconds);
    return DateFormat('MMM dd, yyyy').format(date);
  }
}