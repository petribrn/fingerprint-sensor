extension DateTimeExtension on DateTime {
  String get formattedDate {
    var dayString = '$day';
    var monthString = '$month';

    if (day < 10) dayString = '0$dayString';
    if (month < 10) monthString = '0$monthString';

    return '$dayString/$monthString/$year';
  }

  String get formattedTime {
    var hourString = '$hour';
    var minuteString = '$minute';

    if (hour < 10) hourString = '0$hourString';
    if (minute < 10) minuteString = '0$minuteString';

    return '$hourString:$minuteString';
  }
}
