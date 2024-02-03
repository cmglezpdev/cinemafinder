import 'package:intl/intl.dart';


class HumanFormants {
  static String number(double number) {
    final formatterNumber = NumberFormat.compactCurrency(
      decimalDigits: 0,
      symbol: '',
      locale: 'en'
    ).format(number);

    return formatterNumber;
  }

  static String date(DateTime date) {
    final formatterDate = DateFormat.yMMMd('en_US').format(date);

    return formatterDate;
  }

  static String time(int time) {
    final [hours, minutes] = Duration(minutes: time)
      .toString()
      .split('.')
      .first
      .split(':')
      .sublist(0, 2);

    return '${hours}h ${minutes.padLeft(2, '0')}m';
  }
}