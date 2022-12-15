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
    final day = int.parse('${this[0]}${this[1]}');
    final month = int.parse('${this[3]}${this[4]}');
    final year = int.parse('${this[6]}${this[7]}${this[8]}${this[9]}');

    int? hour;
    int? minute;
    int? second;

    if (length > 10) {
      hour = int.parse('${this[11]}${this[12]}');
      minute = int.parse('${this[14]}${this[15]}');
      second = int.parse('${this[17]}${this[18]}');
    }

    return DateTime(year, month, day, hour ?? 0, minute ?? 0, second ?? 0);
  }

  DateTime get utcToDateTime {
    final year = int.parse('${this[0]}${this[1]}${this[2]}${this[3]}');
    final month = int.parse('${this[5]}${this[6]}');
    final day = int.parse('${this[8]}${this[9]}');

    final second = int.parse('${this[11]}${this[12]}');
    final minute = int.parse('${this[14]}${this[15]}');
    final hour = int.parse('${this[17]}${this[18]}');

    return DateTime(year, month, day, hour, minute, second);
  }
}
