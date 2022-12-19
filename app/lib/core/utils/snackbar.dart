import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../core.dart';

void showSnackbar({
  required String text,
  String? buttonText,
  SnackPosition position = SnackPosition.BOTTOM,
  Duration duration = const Duration(seconds: 3),
}) {
  if (Get.isSnackbarOpen) Get.closeCurrentSnackbar();

  Get.rawSnackbar(
    snackPosition: position,
    duration: duration,
    borderRadius: 6,
    backgroundColor: AppColors.blackSurface,
    margin: const EdgeInsets.only(right: 8, bottom: 16, left: 8),
    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
    messageText: Text(text, style: Get.theme.textTheme.caption!.copyWith(color: AppColors.greySmoke, fontSize: 14)),
    borderColor: AppColors.greySmoke,
  );
}
