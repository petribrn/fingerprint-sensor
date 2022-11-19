import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'default_dialog.dart';

class ConnectivityDialog extends StatelessWidget {
  const ConnectivityDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultDialog(
      title: 'Conexão perdida',
      content: 'Sua conexão com a internet falhou e algumas funcionalidades podem apresentar mau funcionamento.',
      mainButtonText: 'Entendi',
      mainButtonCallback: () => Get.back(),
    );
  }
}
