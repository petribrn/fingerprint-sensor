import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../contracts/contracts.dart';
import '../../../core/core.dart';

class VisualizarHistoricoHeader extends GetView<VisualizarHistoricoController> with PreferredSizeWidget {
  const VisualizarHistoricoHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: preferredSize,
      child: Padding(
        padding: const EdgeInsets.only(left: 16),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Obx(
            () => Column(
              children: [
                Row(
                  children: [
                    Icon(Icons.history, color: AppColors.greySmoke.withOpacity(0.54)),
                    const SizedBox(width: 12),
                    Text(
                      '${controller.latestDayReadCount} Leitura${controller.latestDayReadCount == 1 ? '' : 's'} nas últimas 24 horas',
                      style: Get.textTheme.bodyText1?.copyWith(
                        color: AppColors.greySmoke.withOpacity(0.54),
                        letterSpacing: 0.75,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(56);
}
