import 'package:fingerprint_sensor/factories/data/data.dart';
import 'package:get/get.dart';

import '../../../contracts/contracts.dart';
import '../../../modules/modules.dart';

VisualizarHistoricoController makeGetxVisualizarHistoricoController() {
  return GetxVisualizarHistoricoController(
    fingerprintRepository: makeHttpFingerprintRepository(),
    bottomNavigationBarUtils: Get.find<BottomNavigationBarUtils>(),
  );
}
