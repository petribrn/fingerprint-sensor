import 'package:fingerprint_sensor/core/core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../contracts/contracts.dart';
import 'local_widgets/local_widgets.dart';

class VisualizarBiometriasPage extends GetView<VisualizarBiometriasController> {
  const VisualizarBiometriasPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: FocusScope.of(context).unfocus,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text('Registros salvos', style: Get.textTheme.headline6),
        ),
        body: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1080),
          child: RefreshIndicator(
            backgroundColor: AppColors.primaryLight,
            color: AppColors.greenCheck,
            strokeWidth: 3,
            onRefresh: () async => await controller.reloadData(),
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
                height: MediaQuery.of(context).size.height,
                child: Obx(
                  () => Column(
                    children: [
                      if (controller.fingerprints.isEmpty)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'Você não possui nenhuma digital cadastrada.',
                              style: Get.textTheme.subtitle1?.copyWith(
                                fontWeight: FontWeight.w500,
                                color: AppColors.greySmoke,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Inicie um cadastro na aba "Cadastrar"',
                              style: Get.textTheme.bodyText1?.copyWith(
                                fontWeight: FontWeight.w400,
                                fontStyle: FontStyle.italic,
                                color: AppColors.greySmoke.withOpacity(0.64),
                              ),
                            ),
                          ],
                        )
                      else ...[
                        TextFormField(
                          enabled: true,
                          onFieldSubmitted: controller.onSearchFieldSubmitted,
                          decoration: getTextFormFieldDecoration(
                            hintText: 'Nome da digital',
                            icon: Icons.search,
                          ),
                          keyboardType: TextInputType.text,
                        ),
                        const Divider(),
                        Flexible(
                          child: ListView.separated(
                            shrinkWrap: true,
                            physics: const AlwaysScrollableScrollPhysics(),
                            separatorBuilder: (_, __) => const SizedBox(height: 16),
                            itemCount: controller.fingerprints.length,
                            itemBuilder: (_, i) {
                              final fingerprintItem = controller.fingerprints[i];

                              return Padding(
                                padding: EdgeInsets.only(
                                  top: (i == 0) ? 16 : 0,
                                  bottom: (i == controller.fingerprints.length - 1) ? 42 : 0,
                                ),
                                child: Obx(
                                  () => controller.isLoading
                                      ? const FingerprintCardLoading()
                                      : FingerprintCard(
                                          fingerprintItem: fingerprintItem,
                                        ),
                                ),
                              );
                            },
                          ),
                        ),
                      ]
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
