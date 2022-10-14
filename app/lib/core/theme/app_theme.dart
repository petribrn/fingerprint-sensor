import 'package:flutter/material.dart';

import 'app_colors.dart';

ThemeData makeAppTheme() {
  return ThemeData(
    primaryColor: AppColors.bluePrimary,
    primaryColorDark: AppColors.bluePrimaryDark,
    primaryColorLight: AppColors.bluePrimaryLight,
    colorScheme: ColorScheme.fromSwatch().copyWith(secondary: AppColors.bluePrimary, error: AppColors.red700),
    textTheme: makeTextTheme(),
    backgroundColor: Colors.white,
    highlightColor: Colors.transparent,
    dividerTheme: const DividerThemeData(space: 0, color: AppColors.grey300),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(backgroundColor: AppColors.bluePrimary),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        side: const BorderSide(color: AppColors.bluePrimary),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    ),
    iconTheme: const IconThemeData(color: Colors.white),
  );
}

TextTheme makeTextTheme() {
  const color = AppColors.grey900;

  return const TextTheme(
    headline1: TextStyle(fontWeight: FontWeight.normal, fontSize: 96, color: color),
    headline2: TextStyle(fontWeight: FontWeight.normal, fontSize: 60, color: color),
    headline3: TextStyle(fontWeight: FontWeight.normal, fontSize: 32, color: color),
    headline4: TextStyle(fontWeight: FontWeight.w600, fontSize: 24, color: color),
    headline5: TextStyle(fontWeight: FontWeight.w500, fontSize: 20, color: color),
    headline6: TextStyle(fontWeight: FontWeight.w500, fontSize: 18, color: color),
    bodyText1: TextStyle(fontWeight: FontWeight.normal, fontSize: 16, color: color),
    bodyText2: TextStyle(fontWeight: FontWeight.normal, fontSize: 14, color: color),
    subtitle1: TextStyle(fontWeight: FontWeight.normal, fontSize: 16, color: color),
    subtitle2: TextStyle(fontWeight: FontWeight.normal, fontSize: 14, color: color),
    caption: TextStyle(fontWeight: FontWeight.normal, fontSize: 14, color: color),
    overline: TextStyle(fontWeight: FontWeight.w600, fontSize: 12, color: color),
    button: TextStyle(fontWeight: FontWeight.w500, fontSize: 18, color: color),
  );
}
