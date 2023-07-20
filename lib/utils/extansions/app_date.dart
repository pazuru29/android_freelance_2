import 'package:intl/intl.dart';

extension AppDate on DateTime {
  static String dateFormatter(DateTime dateTime) {
    return DateFormat('dd.MM.yyyy').format(dateTime);
  }

  static String monthFormatter(DateTime dateTime) {
    return DateFormat('MMMM').format(dateTime);
  }

  static String dataBaseFormatter(DateTime dateTime) {
    return DateFormat('yyyy-MM-dd').format(dateTime);
  }

  static DateTime fromDataBaseFormatter(String date) {
    return DateTime.parse(date);
  }

  static String dateForPaymentsFormatter(DateTime date) {
    return DateFormat('dd MMMM yyyy').format(date);
  }

  static String getDateForPaymentsStatistic(String date) {
    DateTime currentDate = AppDate.fromDataBaseFormatter(date);

    return AppDate.dateForPaymentsFormatter(currentDate);
  }
}
