import 'package:get/get.dart';

import '../../../contracts/contracts.dart';
import '../../../modules/modules.dart';

VerificarBiometriaController makeGetxVerificarBiometriaController() {
  return GetxVerificarBiometriaController(
    fingerprintRepository: Get.find<FingerprintRepository>(),
    notificationRepository: Get.find<NotificationRepository>(),
  );
}
