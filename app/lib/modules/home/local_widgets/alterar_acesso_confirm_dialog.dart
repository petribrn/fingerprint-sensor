import 'package:fingerprint_sensor/core/core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../routes/routes.dart';

class AlterarAcessoConfirmDialog extends StatelessWidget {
  const AlterarAcessoConfirmDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Alterar acesso?', style: Get.textTheme.headline5),
      content: Text('Você será redirecionado para outra tela.', style: Get.textTheme.subtitle1),
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8))),
      actions: [
        Wrap(
          textDirection: TextDirection.rtl,
          children: [
            TextButton(
              onPressed: () => Get.offAllNamed(AppRoutes.ACESSO),
              style: const ButtonStyle(overlayColor: MaterialStatePropertyAll(AppColors.primary)),
              child: Text('Confirmar', style: Get.textTheme.subtitle1),
            ),
            TextButton(
              onPressed: () => Get.back(),
              style: const ButtonStyle(overlayColor: MaterialStatePropertyAll(AppColors.primary)),
              child: Text('Cancelar', style: Get.textTheme.subtitle1),
            ),
          ],
        ),
      ],
    );
  }
}
