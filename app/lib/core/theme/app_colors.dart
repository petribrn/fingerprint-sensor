import 'package:flutter/material.dart';

abstract class AppColors {
  AppColors._();

  static const greenPrimary = Color(0xFF2EBB55);
  static const greenPrimaryDark = Color.fromARGB(255, 31, 155, 66);
  static const greenPrimaryLight = Color.fromARGB(255, 55, 199, 96);

  static const red700 = Color(0xFFD32F2F);
  static const red900 = Color(0xFFB71C1C);

  static const whiteSmoke = Color(0xFFF5F5F5);
  static final whiteDisabled = Colors.white.withOpacity(0.5);
  static final whiteInactive = Colors.white.withOpacity(0.54);

  static const grey100 = Color(0xFFF5F5F5);
  static const grey200 = Color(0xFFEEEEEE);
  static const grey300 = Color(0xFFE0E0E0);
  static const grey600 = Color(0xFF757575);
  static const grey700 = Color(0xFF616161);
  static const grey800 = Color(0xFF424242);
  static const grey900 = Color(0xFF212121);

  static const black12 = Colors.black12;
  static const blackInactive = Colors.black54;
  static const blackSurface = Color(0xFF202020);
  static final blackDisabled = Colors.black.withOpacity(0.38);
  static final blackPressedOverlay = Colors.black.withOpacity(0.16);
  static final blackMediumEmphasis = Colors.black.withOpacity(0.6);
}
