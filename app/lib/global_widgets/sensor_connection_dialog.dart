import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'default_dialog.dart';

class SensorConnectionDialog extends StatelessWidget {
  const SensorConnectionDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultDialog(
      title: 'Sensor desconectado',
      content: Text(
        'A conexão serial com o sensor foi perdida.',
        style: Get.textTheme.subtitle1,
      ),
      mainButtonText: 'Entendi',
      mainButtonCallback: () => Get.back(),
    );
  }
}
