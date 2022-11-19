import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../contracts/contracts.dart';
import '../../../core/core.dart';
import '../../../data/data.dart';

class FingerprintPopupMenu extends GetView<VisualizarBiometriasController> {
  final Fingerprint fingerprint;

  const FingerprintPopupMenu({super.key, required this.fingerprint});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<FingerprintPopupMenuOptions>(
      key: key,
      onSelected: (result) async => await onSelected(result),
      offset: const Offset(0, 36),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
      ),
      color: AppColors.primaryDark,
      tooltip: 'Opções da digital',
      itemBuilder: (_) {
        return <PopupMenuEntry<FingerprintPopupMenuOptions>>[
          PopupMenuItem(
            value: FingerprintPopupMenuOptions.editar,
            child: Row(
              children: const [
                Icon(
                  Icons.edit,
                  color: AppColors.greySmoke,
                ),
                SizedBox(width: 8),
                Text(
                  'Editar',
                  style: TextStyle(
                    color: AppColors.greySmoke,
                  ),
                ),
              ],
            ),
          ),
          PopupMenuItem(
            value: FingerprintPopupMenuOptions.excluir,
            child: Row(
              children: const [
                Icon(
                  Icons.delete,
                  color: AppColors.greySmoke,
                ),
                SizedBox(width: 8),
                Text(
                  'Excluir',
                  style: TextStyle(
                    color: AppColors.greySmoke,
                  ),
                ),
              ],
            ),
          ),
        ];
      },
      child: Container(
        alignment: Alignment.centerRight,
        height: 24,
        width: 24,
        child: const Icon(Icons.more_vert, color: AppColors.greySmoke),
      ),
    );
  }

  Future<void> onSelected(FingerprintPopupMenuOptions result) async {
    switch (result) {
      case FingerprintPopupMenuOptions.editar:
        return await controller.onEditSelected(fingerprint);

      case FingerprintPopupMenuOptions.excluir:
        return await controller.onExcludeSelected(fingerprint.fingerprintId);
    }
  }
}
