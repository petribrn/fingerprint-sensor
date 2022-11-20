import 'package:get/get.dart';

import '../../../contracts/contracts.dart';
import '../../../modules/modules.dart';
import '../../data/data.dart';

VisualizarBiometriasController makeGetxVisualizarBiometriasController() {
  return GetxVisualizarBiometriasController(
    fingerprintRepository: makeHttpFingerprintRepository(),
    bottomNavigationBarUtils: Get.find<BottomNavigationBarUtils>(),
  );
}
