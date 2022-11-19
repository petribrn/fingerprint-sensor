extension DateTimeExtension on DateTime {
  String get formatted {
    var dayString = '$day';
    var monthString = '$month';

    if (day < 10) dayString = '0$dayString';
    if (month < 10) monthString = '0$monthString';

    return '$dayString/$monthString/$year';
  }
}
