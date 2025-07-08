import 'package:intl/intl.dart';

class DateCovert {
  static String dateTimeStringToDateOnly(String dateTime) {
    return DateFormat('yyyy-MM-dd')
        .format(DateFormat('yyyy-MM-dd HH:mm:ss').parse(dateTime));
  }
}
