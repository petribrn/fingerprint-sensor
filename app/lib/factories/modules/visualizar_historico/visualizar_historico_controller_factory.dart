import 'package:get/get.dart';

import '../../../contracts/contracts.dart';
import '../../../modules/modules.dart';

VisualizarHistoricoController makeGetxVisualizarHistoricoController() {
  return GetxVisualizarHistoricoController(
    fingerprintRepository: Get.find<FingerprintRepository>(),
    bottomNavigationBarUtils: Get.find<BottomNavigationBarUtils>(),
  );
}
