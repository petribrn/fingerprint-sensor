import 'package:fingerprint_sensor/core/core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../contracts/contracts.dart';

class SobrePage extends GetView<SobreController> {
  const SobrePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Sobre o aplicativo', style: Get.textTheme.headline6),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/fingerprint.png'),
            const SizedBox(height: 20),
            Text('Sensor Biométrico', style: Get.textTheme.headline4),
            const SizedBox(height: 20),
            Obx(() => Text('Versão ${controller.appVersion}', style: Get.textTheme.bodyText2)),
            const SizedBox(height: 8),
            Obx(() => Text('Última atualização em ${controller.appReleaseDate}', style: Get.textTheme.bodyText2)),
            const SizedBox(height: 34),
            Text('Desenvolvido com', style: Get.textTheme.bodyText1),
            const SizedBox(height: 20),
            Wrap(
              spacing: 12,
              children: [
                Image.asset('assets/images/flutter-logo.png', color: AppColors.greySmoke),
                Image.asset('assets/images/nodejs-logo.png', color: AppColors.greySmoke),
                Image.asset('assets/images/arduino-logo.png', color: AppColors.greySmoke),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
