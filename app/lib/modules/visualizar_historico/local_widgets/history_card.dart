import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/core.dart';
import '../../../data/data.dart';

class HistoryCard extends StatelessWidget {
  final HistoryRecord historyItem;

  const HistoryCard({
    super.key,
    required this.historyItem,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Get.theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(8),
        boxShadow: const [
          BoxShadow(
            offset: Offset(0, 2),
            blurRadius: 2,
            spreadRadius: 0,
            color: AppColors.primary,
          ),
        ],
      ),
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            historyItem.readDate.formattedTime,
            style: Get.textTheme.headline5?.copyWith(letterSpacing: 0.5),
          ),
          const SizedBox(width: 16),
          const VerticalDivider(thickness: 2),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  historyItem.fingerprint.name == null || historyItem.fingerprint.name == '' ? 'Digital sem nome' : historyItem.fingerprint.name!,
                  style: Get.textTheme.headline6?.copyWith(
                    color: historyItem.fingerprint.name == null || historyItem.fingerprint.name == '' ? AppColors.greySmoke.withOpacity(0.54) : null,
                    fontStyle: historyItem.fingerprint.name == null || historyItem.fingerprint.name == '' ? FontStyle.italic : null,
                    letterSpacing: 0.5,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  '${historyItem.fingerprint.fingerprintId}',
                  style: Get.textTheme.subtitle1,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
