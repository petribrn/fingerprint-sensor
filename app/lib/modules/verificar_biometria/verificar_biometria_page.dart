import 'package:fingerprint_sensor/contracts/contracts.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/core.dart';
import '../../data/data.dart';
import '../../global_widgets/global_widgets.dart';

class VerificarBiometriaPage extends GetView<VerificarBiometriaController> {
  const VerificarBiometriaPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const emptyTitle = 'Inicie uma verificação de leitura clicando no botão abaixo';

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Verificar', style: Get.textTheme.headline6),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 64, horizontal: 16),
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Painel da leitura',
                style: Get.textTheme.headline5?.copyWith(letterSpacing: 0.5),
              ),
            ),
            const SizedBox(height: 16),
            Flexible(
              child: Container(
                height: Get.height - 560,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: AppColors.greySmoke),
                ),
                child: LayoutBuilder(builder: (_, constraints) {
                  return Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 32),
                      child: Obx(
                        () => controller.willStartVerification
                            ? StreamBuilder<Result>(
                                stream: controller.verifyFingerprintInSensor(),
                                builder: (_, snapshot) {
                                  if (!snapshot.hasData) {
                                    return const Text(emptyTitle);
                                  }

                                  final result = snapshot.data as Result;

                                  // No content to show
                                  if (result.isEmpty) {
                                    return Text(
                                      emptyTitle,
                                      style: Get.textTheme.subtitle1?.copyWith(
                                        fontWeight: FontWeight.w500,
                                        color: AppColors.greySmoke,
                                      ),
                                    );
                                  }

                                  // Error catch during reading
                                  if (result.hasError) {
                                    return Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          margin: const EdgeInsets.only(bottom: 36),
                                          padding: const EdgeInsets.all(16),
                                          width: constraints.maxWidth - 36,
                                          decoration: BoxDecoration(
                                            color: AppColors.greySmoke,
                                            borderRadius: BorderRadius.circular(6),
                                            border: Border.all(color: AppColors.red700),
                                          ),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              const Icon(
                                                Icons.close,
                                                color: AppColors.red700,
                                                size: 20,
                                              ),
                                              const SizedBox(width: 4),
                                              Text(
                                                result.error ?? '',
                                                style: Get.textTheme.subtitle1?.copyWith(
                                                  fontWeight: FontWeight.w500,
                                                  color: AppColors.red700,
                                                ),
                                                textAlign: TextAlign.center,
                                              ),
                                            ],
                                          ),
                                        ),
                                        PrimaryButton(
                                          onPressed: () => controller.onFinishVerification(),
                                          label: 'Finalizar',
                                        ),
                                        const SizedBox(height: 8),
                                      ],
                                    );
                                  }

                                  // Fingerprint was registered successfully
                                  if (result.hasData) {
                                    switch (result.data) {
                                      case 'Posicione o dedo no sensor':
                                        return Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Container(
                                              margin: const EdgeInsets.only(bottom: 36),
                                              padding: const EdgeInsets.all(16),
                                              width: constraints.maxWidth - 36,
                                              decoration: BoxDecoration(
                                                color: AppColors.greySmoke,
                                                borderRadius: BorderRadius.circular(6),
                                                border: Border.all(color: AppColors.primaryDark),
                                              ),
                                              child: Text(
                                                result.data,
                                                style: Get.textTheme.subtitle1?.copyWith(
                                                  fontWeight: FontWeight.w500,
                                                  color: AppColors.primaryDark,
                                                ),
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                            const SizedBox(height: 8),
                                          ],
                                        );

                                      case 'Digital encontrada':
                                        return Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Container(
                                              margin: const EdgeInsets.only(bottom: 36),
                                              padding: const EdgeInsets.all(16),
                                              width: constraints.maxWidth - 36,
                                              decoration: BoxDecoration(
                                                color: AppColors.greySmoke,
                                                borderRadius: BorderRadius.circular(6),
                                                border: Border.all(color: AppColors.greenCheck),
                                              ),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  const Icon(
                                                    Icons.check,
                                                    color: AppColors.greenCheck,
                                                    size: 20,
                                                  ),
                                                  const SizedBox(width: 4),
                                                  Text(
                                                    result.data,
                                                    style: Get.textTheme.subtitle1?.copyWith(
                                                      fontWeight: FontWeight.w500,
                                                      color: AppColors.greenCheck,
                                                    ),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                ],
                                              ),
                                            ),
                                            PrimaryButton(
                                              onPressed: () => controller.onFinishVerification(),
                                              label: 'Finalizar',
                                            ),
                                            const SizedBox(height: 8),
                                          ],
                                        );
                                    }
                                  }

                                  return Container();
                                })
                            : Text(
                                emptyTitle,
                                style: Get.textTheme.subtitle1?.copyWith(
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.greySmoke,
                                ),
                              ),
                      ),
                    ),
                  );
                }),
              ),
            ),
            const SizedBox(height: 16),
            Align(
              alignment: Alignment.center,
              child: Obx(
                () => PrimaryButton(
                  onPressed: () => controller.onVerifyButtonPressed(),
                  label: 'Ler digital',
                  backgroundColor: controller.isVerifyButtonDisabled ? AppColors.primaryLight : null,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
