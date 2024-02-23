import 'package:intl/intl.dart';

class DateUtil {
  static const String format = 'HHmm';

  static String toStringFromDateTimeNow() {
    DateTime now = DateTime.now();

    return toStringFromDate(now);
  }

  static String toStringFromDate(DateTime time) {
    return DateFormat(format).format(time);
  }

  static String toFormattedStringFromDateTime(DateTime time) {
    return DateFormat.Hm().format(time);
  }

  static DateTime toDateTimeFromString(String time) {
    int hour = int.parse(time.substring(0, 2));
    int minute = int.parse(time.substring(2, 4));
    DateTime today = DateTime.now();
    DateTime combinedDateTime = DateTime(
      today.year,
      today.month,
      today.day,
      hour,
      minute,
    );

    return combinedDateTime;
  }
}
