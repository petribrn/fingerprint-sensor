import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../contracts/contracts.dart';
import '../../core/core.dart';
import 'local_widgets/local_widgets.dart';

class VisualizarHistoricoPage extends StatefulWidget {
  const VisualizarHistoricoPage({Key? key}) : super(key: key);

  @override
  State<VisualizarHistoricoPage> createState() => _VisualizarHistoricoPageState();
}

class _VisualizarHistoricoPageState extends State<VisualizarHistoricoPage> {
  VisualizarHistoricoController? controller;
  bool showHeader = false;

  Worker? headerWorkerEmpty;

  @override
  void initState() {
    super.initState();

    controller = Get.find<VisualizarHistoricoController>();

    headerWorkerEmpty = ever(controller!.historyRecordsRx, (historyRecords) {
      if (historyRecords.isNotEmpty) {
        setState(() {
          showHeader = true;
        });
      }
    });
  }

  @override
  void dispose() {
    super.dispose();

    if (headerWorkerEmpty != null) {
      headerWorkerEmpty!.dispose();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Histórico de leituras', style: Get.textTheme.headline6),
        bottom: showHeader ? const VisualizarHistoricoHeader() : null,
      ),
      body: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 1080),
        child: Obx(
          () => controller!.historyRecords.isEmpty
              ? RefreshIndicator(
                  backgroundColor: AppColors.primaryLight,
                  color: AppColors.greenCheck,
                  strokeWidth: 3,
                  onRefresh: () async => await controller!.reloadData(),
                  child: buildHistoryRecords(),
                )
              : buildHistoryRecords(),
        ),
      ),
    );
  }

  Widget buildHistoryRecords() {
    return SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      child: Obx(
        () => Container(
          padding: EdgeInsets.only(
            top: controller!.historyRecords.isEmpty ? 24 : 0,
            bottom: 24,
            left: 16,
            right: 16,
          ),
          height: MediaQuery.of(Get.context!).size.height - 176,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (controller!.historyRecords.isEmpty)
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
                    const SizedBox(height: 8),
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
                    onRefresh: () async => await controller!.reloadData(),
                    child: ListView.separated(
                      shrinkWrap: true,
                      physics: const AlwaysScrollableScrollPhysics(),
                      separatorBuilder: (_, __) => const SizedBox(height: 16),
                      itemCount: controller!.historyRecords.keys.length,
                      itemBuilder: (_, i) {
                        final date = controller!.historyRecords.keys.toList().elementAt(i);
                        final historyItemsInDate = controller!.historyRecords[date] ?? [];

                        return Padding(
                          padding: EdgeInsets.only(
                            top: (i == 0) ? 16 : 0,
                            bottom: (i == controller!.historyRecords.length - 1) ? 42 : 0,
                          ),
                          child: Column(
                            children: [
                              if (i == 0) const SizedBox(height: 8),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Obx(
                                  () => controller!.isLoading
                                      ? const DateLabelLoading()
                                      : Text(
                                          date,
                                          style: Get.theme.textTheme.bodyText1,
                                        ),
                                ),
                              ),
                              const SizedBox(height: 12),
                              for (final historyItem in historyItemsInDate) ...[
                                Obx(
                                  () => controller!.isLoading
                                      ? const HistoryCardLoading()
                                      : HistoryCard(
                                          historyItem: historyItem,
                                        ),
                                ),
                                const SizedBox(height: 16),
                              ]
                            ],
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
    );
  }
}
