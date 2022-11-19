import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../global_widgets/global_widgets.dart';

class ExclusionDialog extends StatelessWidget {
  const ExclusionDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultDialog(
      title: 'Excluir a digital?',
      content: 'A digital cadastrada será excluída permanentemente.',
      mainButtonText: 'Confirmar',
      mainButtonCallback: () => Get.back(result: true),
      secondaryButtonText: 'Cancelar',
      secondaryButtonCallback: () => Get.back(result: false),
    );
  }
}
