import 'package:flutter/material.dart';

import 'app_colors.dart';

ThemeData makeAppTheme() {
  return ThemeData(
    primaryColor: AppColors.primary,
    primaryColorDark: AppColors.primaryDark,
    primaryColorLight: AppColors.primaryLight,
    colorScheme: ColorScheme.fromSwatch().copyWith(primary: AppColors.primaryDark, secondary: AppColors.primary, error: AppColors.red700),
    textTheme: makeTextTheme(),
    scaffoldBackgroundColor: AppColors.primaryDark,
    splashColor: AppColors.greySmoke,
    dividerTheme: const DividerThemeData(space: 0, color: AppColors.primary),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: AppColors.greenCheck,
      splashColor: AppColors.greenCheckPressed,
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        side: const BorderSide(color: AppColors.greenCheck),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    ),
    buttonTheme: const ButtonThemeData(textTheme: ButtonTextTheme.primary),
    iconTheme: const IconThemeData(color: AppColors.greySmoke),
    appBarTheme: const AppBarTheme(color: AppColors.primaryDark),
    dialogBackgroundColor: AppColors.primaryDark,
  );
}

TextTheme makeTextTheme() {
  const color = AppColors.greySmoke;

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
