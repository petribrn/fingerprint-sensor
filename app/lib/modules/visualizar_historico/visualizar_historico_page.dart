import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../contracts/contracts.dart';
import '../../core/core.dart';
import 'local_widgets/local_widgets.dart';

class VisualizarHistoricoPage extends GetView<VisualizarHistoricoController> {
  const VisualizarHistoricoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Histórico de leituras', style: Get.textTheme.headline6),
        bottom: PreferredSize(
          preferredSize: Size(Get.width, 56),
          child: Padding(
            padding: const EdgeInsets.only(left: 16),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Column(
                children: [
                  Text(
                    '2 Leituras nas últimas 24 horas',
                    style: Get.textTheme.bodyText1,
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ),
      ),
      body: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 1080),
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Obx(
            () => Container(
              padding: EdgeInsets.only(
                top: controller.historyRecords.isEmpty ? 24 : 0,
                bottom: 24,
                left: 16,
                right: 16,
              ),
              height: MediaQuery.of(context).size.height,
              child: Column(
                children: [
                  if (controller.historyRecords.isEmpty)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Não há histórico de leituras.',
                          style: Get.textTheme.subtitle1?.copyWith(
                            fontWeight: FontWeight.w500,
                            color: AppColors.greySmoke,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Inicie uma verificação de leitura na aba "Verificar"',
                          style: Get.textTheme.bodyText1?.copyWith(
                            fontWeight: FontWeight.w400,
                            fontStyle: FontStyle.italic,
                            color: AppColors.greySmoke.withOpacity(0.64),
                          ),
                        ),
                      ],
                    )
                  else
                    Flexible(
                      child: RefreshIndicator(
                        backgroundColor: AppColors.primaryLight,
                        color: AppColors.greenCheck,
                        strokeWidth: 3,
                        onRefresh: () async => await controller.reloadData(),
                        child: ListView.separated(
                          shrinkWrap: true,
                          physics: const AlwaysScrollableScrollPhysics(),
                          separatorBuilder: (_, __) => const SizedBox(height: 16),
                          itemCount: controller.historyRecords.length,
                          itemBuilder: (_, i) {
                            final historyItem = controller.historyRecords[i];

                            return Padding(
                              padding: EdgeInsets.only(
                                top: (i == 0) ? 16 : 0,
                                bottom: (i == controller.historyRecords.length - 1) ? 236 : 0,
                              ),
                              child: Obx(
                                () => controller.isLoading
                                    ? const HistoryCardLoading()
                                    : HistoryCard(
                                        historyItem: historyItem,
                                      ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
