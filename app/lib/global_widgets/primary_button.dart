import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../core/core.dart';

// ignore: must_be_immutable
class PrimaryButton extends StatelessWidget {
  final Function() onPressed;
  final String label;
  final Color backgroundColor;

  const PrimaryButton({
    super.key,
    required this.onPressed,
    required this.label,
    backgroundColor,
  }) : backgroundColor = backgroundColor ?? AppColors.greenCheck;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        padding: const MaterialStatePropertyAll(
          EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        ),
        backgroundColor: MaterialStatePropertyAll(backgroundColor),
      ),
      child: Text(
        label,
        style: Get.textTheme.button,
      ),
    );
  }
}
