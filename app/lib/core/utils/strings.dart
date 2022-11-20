extension StringExtension on String {
  // Padrão para remover todos os acentos da palavra
  String removeDiacritics() {
    const diacritics = 'ÀÁÂÃÄÅàáâãäåÒÓÔÕÕÖØòóôõöøÈÉÊËèéêëðÇçÐÌÍÎÏìíîïÙÚÛÜùúûüÑñŠšŸÿýŽž';
    const nonDiacritics = 'AAAAAAaaaaaaOOOOOOOooooooEEEEeeeeeCcDIIIIiiiiUUUUuuuuNnSsYyyZz';
    return splitMapJoin(
      '',
      onNonMatch: (char) => char.isNotEmpty && diacritics.contains(char) ? nonDiacritics[diacritics.indexOf(char)] : char,
    );
  }

  DateTime get toDateTime {
    final day = int.parse('${[0]}${[1]}');
    final month = int.parse('${[3]}${[4]}');
    final year = int.parse('${[6]}${[7]}${[8]}${[9]}');

    int? hour;
    int? minute;
    int? second;

    if (length > 10) {
      hour = int.parse('${[11]}${[12]}');
      minute = int.parse('${[14]}${[15]}');
      second = int.parse('${[17]}${[18]}');
    }

    return DateTime(year, month, day, hour ?? 0, minute ?? 0, second ?? 0);
  }
}
