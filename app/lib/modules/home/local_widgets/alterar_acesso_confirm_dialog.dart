import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../global_widgets/global_widgets.dart';
import '../../../routes/routes.dart';

class AlterarAcessoConfirmDialog extends StatelessWidget {
  const AlterarAcessoConfirmDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultDialog(
      title: 'Alterar acesso?',
      content: 'Você será redirecionado para outra tela.',
      mainButtonText: 'Confirmar',
      secondaryButtonText: 'Cancelar',
      mainButtonCallback: () async => await Get.offAllNamed(AppRoutes.ACESSO),
      secondaryButtonCallback: () => Get.back(),
    );
  }
}
