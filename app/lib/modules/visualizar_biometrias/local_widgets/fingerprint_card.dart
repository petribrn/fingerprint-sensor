import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/core.dart';
import '../../../data/data.dart';
import 'fingerprint_popup_menu.dart';

class FingerprintCard extends StatelessWidget {
  final Fingerprint fingerprintItem;

  const FingerprintCard({
    super.key,
    required this.fingerprintItem,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.centerLeft,
      children: [
        Container(
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
          padding: const EdgeInsets.all(8),
          margin: const EdgeInsets.only(left: 20),
          child: Row(
            children: [
              const SizedBox(width: 24),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        fingerprintItem.name == null || fingerprintItem.name == '' ? 'Digital sem nome' : fingerprintItem.name!,
                        style: Get.textTheme.headline6?.copyWith(
                          color: fingerprintItem.name == null || fingerprintItem.name == '' ? AppColors.greySmoke.withOpacity(0.54) : null,
                          fontStyle: fingerprintItem.name == null || fingerprintItem.name == '' ? FontStyle.italic : null,
                          letterSpacing: 0.5,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '${fingerprintItem.fingerprintId}',
                        style: Get.textTheme.subtitle1,
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              'Cadastrado em: ${fingerprintItem.creationDate.formatted}',
                              style: Get.textTheme.subtitle1?.copyWith(
                                color: AppColors.greySmoke.withOpacity(0.5),
                                fontStyle: FontStyle.italic,
                                letterSpacing: 0.5,
                              ),
                            ),
                          ),
                          FingerprintPopupMenu(
                            key: Key('${fingerprintItem.fingerprintId}'),
                            fingerprint: fingerprintItem,
                          ),
                          const SizedBox(width: 4),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        const Icon(
          Icons.person_outline_rounded,
          size: 42,
        ),
      ],
    );
  }
}
