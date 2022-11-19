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
}
