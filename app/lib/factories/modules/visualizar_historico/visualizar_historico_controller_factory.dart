import 'package:get/get.dart';

import '../../../contracts/contracts.dart';
import '../../../modules/modules.dart';

VisualizarHistoricoController makeGetxVisualizarHistoricoController() {
  return GetxVisualizarHistoricoController(
    historyRecordRepository: Get.find<HistoryRecordRepository>(),
    bottomNavigationBarUtils: Get.find<BottomNavigationBarUtils>(),
  );
}
