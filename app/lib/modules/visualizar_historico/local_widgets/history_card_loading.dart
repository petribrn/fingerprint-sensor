import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import '../../../core/core.dart';

class HistoryCardLoading extends StatelessWidget {
  const HistoryCardLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
      child: Shimmer.fromColors(
        baseColor: AppColors.primary,
        highlightColor: AppColors.primaryLight,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 64,
              height: 32,
              decoration: const BoxDecoration(
                color: AppColors.grey600,
                shape: BoxShape.rectangle,
              ),
            ),
            const SizedBox(width: 16),
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(height: 10, width: Get.width / 1.6, color: AppColors.primary),
                const SizedBox(height: 8),
                Container(height: 10, width: Get.width / 8, color: AppColors.primaryLight),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
