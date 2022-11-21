import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../default_dialog.dart';

class ConnectivityDialog extends StatelessWidget {
  const ConnectivityDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultDialog(
      title: 'Conexão perdida',
      content: Text(
        'Sua conexão com a internet falhou e algumas funcionalidades podem apresentar mau funcionamento.',
        style: Get.textTheme.subtitle1,
      ),
      mainButtonText: 'Entendi',
      mainButtonCallback: () => Get.back(),
    );
  }
}
