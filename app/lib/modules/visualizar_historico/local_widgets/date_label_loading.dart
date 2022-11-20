import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../core/core.dart';

class DateLabelLoading extends StatelessWidget {
  const DateLabelLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Shimmer.fromColors(
        baseColor: AppColors.primary,
        highlightColor: AppColors.primaryLight,
        child: Container(
          width: 96,
          height: 16,
          decoration: const BoxDecoration(
            color: AppColors.grey600,
            shape: BoxShape.rectangle,
          ),
        ),
      ),
    );
  }
}
