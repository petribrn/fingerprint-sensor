import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../core/core.dart';

class DefaultDialog extends StatelessWidget {
  final String title;
  final Widget content;

  final String mainButtonText;
  final String? secondaryButtonText;

  final Function() mainButtonCallback;
  final Function()? secondaryButtonCallback;

  const DefaultDialog({
    super.key,
    required this.title,
    required this.content,
    required this.mainButtonText,
    this.secondaryButtonText,
    required this.mainButtonCallback,
    this.secondaryButtonCallback,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title, style: Get.textTheme.headline5),
      content: content,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8))),
      actions: [
        Wrap(
          textDirection: TextDirection.rtl,
          children: [
            TextButton(
              onPressed: mainButtonCallback,
              style: const ButtonStyle(overlayColor: MaterialStatePropertyAll(AppColors.primary)),
              child: Text(mainButtonText, style: Get.textTheme.button),
            ),
            if (secondaryButtonText != null && secondaryButtonCallback != null)
              TextButton(
                onPressed: secondaryButtonCallback,
                style: const ButtonStyle(overlayColor: MaterialStatePropertyAll(AppColors.primary)),
                child: Text(secondaryButtonText!, style: Get.textTheme.button),
              ),
          ],
        ),
      ],
    );
  }
}
