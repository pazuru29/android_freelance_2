import 'package:intl/intl.dart';

extension AppDate on DateTime {
  static String dateFormatter(DateTime dateTime) {
    return DateFormat('dd.MM.yyyy').format(dateTime);
  }

  static String dataBaseFormatter(DateTime dateTime) {
    return DateFormat('yyyy-MM-dd HH:mm:ss.ms').format(dateTime);
  }

  static DateTime fromDataBaseFormatter(String date) {
    return DateTime.parse(date);
  }
}
