import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/core.dart';
import '../default_dialog.dart';

class FinishReadDialog extends StatelessWidget {
  final bool isCadastro;
  final FinishDialogContent dialogContent;

  const FinishReadDialog({
    super.key,
    this.isCadastro = false,
    required this.dialogContent,
  });

  @override
  Widget build(BuildContext context) {
    return DefaultDialog(
      icon: isCadastro ? Icons.check_circle_outline : Icons.fingerprint_outlined,
      title: isCadastro ? 'Digital cadastrada' : 'Digital encontrada',
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (isCadastro) ...[
            Text(
              'Código: ${dialogContent.id}',
              style: Get.textTheme.subtitle1,
            ),
            const SizedBox(height: 4),
            Text(
              dialogContent.date.formattedDateTime,
              style: Get.textTheme.subtitle1,
            ),
          ] else ...[
            Text(
              'Código: ${dialogContent.id}',
              style: Get.textTheme.subtitle1,
            ),
            const SizedBox(height: 4),
            Text(
              '${dialogContent.name}',
              style: Get.textTheme.subtitle1?.copyWith(fontStyle: dialogContent.name != null ? null : FontStyle.italic),
            ),
            const SizedBox(height: 4),
            Text(
              dialogContent.date.formattedDateTime,
              style: Get.textTheme.subtitle1,
            ),
            const SizedBox(height: 4),
            Text(
              'Confiança: ${dialogContent.confidence}%',
              style: Get.textTheme.subtitle1,
            ),
          ]
        ],
      ),
      mainButtonText: 'Fechar',
      mainButtonCallback: () => Get.back(),
    );
  }
}

class FinishDialogContent {
  final int id;
  final String? name;
  final DateTime date;
  final double? confidence;

  const FinishDialogContent({
    required this.id,
    this.name = 'Digital sem nome',
    required this.date,
    this.confidence,
  });
}
