import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../contracts/contracts.dart';
import '../../core/core.dart';
import '../../data/data.dart';

class SelecionarAcessoPage extends GetView<SelecionarAcessoController> {
  const SelecionarAcessoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.only(top: 96, left: 32, right: 32, bottom: 48),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Obx(
              () => Text(
                controller.isFirstAppUse ? 'Olá usuário! Bem-vindo ao Leitor Biométrico.' : 'Alterar modo de uso',
                style: Get.textTheme.headline5,
              ),
            ),
          ),
          const SizedBox(height: 20),
          Align(
            alignment: Alignment.centerLeft,
            child: Text('Escolha o modo de uso em que deseja utilizar o aplicativo:', style: Get.textTheme.bodyText2),
          ),
          const SizedBox(height: 36),
          SizedBox(
            width: Get.width / 1.3,
            height: 84,
            child: Obx(
              () => OutlinedButton.icon(
                onPressed: () => controller.onModeSelected(AccessMode.cadastro_biometria),
                icon: Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: Icon(
                    Icons.add,
                    color: controller.currentMode == AccessMode.cadastro_biometria ? Colors.white : null,
                  ),
                ),
                label: Text(
                  AccessMode.cadastro_biometria.name,
                  style: Get.textTheme.button,
                  textAlign: TextAlign.center,
                ),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color?>(
                    controller.currentMode == AccessMode.cadastro_biometria ? AppColors.bluePrimaryLight : null,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: Get.width / 1.3,
            height: 84,
            child: Obx(
              () => OutlinedButton.icon(
                onPressed: () => controller.onModeSelected(AccessMode.verificar_biometria),
                icon: Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: Icon(
                    Icons.fingerprint,
                    color: controller.currentMode == AccessMode.verificar_biometria ? Colors.white : null,
                  ),
                ),
                label: Text(
                  AccessMode.verificar_biometria.name,
                  style: Get.textTheme.button,
                  textAlign: TextAlign.center,
                ),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color?>(
                    controller.currentMode == AccessMode.verificar_biometria ? AppColors.bluePrimaryLight : null,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
