import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../theme/theme.dart';

InputDecoration getTextFormFieldDecoration({
  required String hintText,
  required IconData icon,
}) {
  return InputDecoration(
    enabled: false,
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: AppColors.greySmoke.withOpacity(0.6),
      ),
    ),
    focusedBorder: const OutlineInputBorder(
      borderSide: BorderSide(
        color: AppColors.greySmoke,
      ),
    ),
    disabledBorder: const OutlineInputBorder(
      borderSide: BorderSide(
        color: AppColors.primary,
      ),
    ),
    contentPadding: const EdgeInsets.only(left: 12),
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
    prefixIcon: Icon(
      icon,
      color: AppColors.greySmoke.withOpacity(0.6),
    ),
    hintText: hintText,
    hintStyle: Get.textTheme.bodyText1?.copyWith(color: AppColors.greySmoke.withOpacity(0.6)),
    helperText: '',
  );
}
