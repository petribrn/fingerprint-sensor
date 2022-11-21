import 'package:get/get.dart';

import '../../../contracts/contracts.dart';
import '../../../modules/modules.dart';

VisualizarBiometriasController makeGetxVisualizarBiometriasController() {
  return GetxVisualizarBiometriasController(
    fingerprintRepository: Get.find<FingerprintRepository>(),
    bottomNavigationBarUtils: Get.find<BottomNavigationBarUtils>(),
  );
}
