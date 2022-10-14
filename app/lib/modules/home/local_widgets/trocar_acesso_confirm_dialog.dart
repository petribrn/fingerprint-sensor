import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../routes/routes.dart';

class TrocarAcessoConfirmDialog extends StatelessWidget {
  const TrocarAcessoConfirmDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Trocar acesso?', style: Get.textTheme.headline5),
      content: Text('Você será redirecionado para outra tela.', style: Get.textTheme.subtitle1),
      actions: [
        Wrap(
          textDirection: TextDirection.rtl,
          children: [
            TextButton(
              onPressed: () => Get.offAllNamed(AppRoutes.ACESSO),
              child: const Text('Confirmar'),
            ),
            TextButton(
              onPressed: () => Get.back(),
              child: const Text('Cancelar'),
            ),
          ],
        ),
      ],
    );
  }
}
