import 'package:get/get.dart';

import '../../../contracts/contracts.dart';
import '../../../modules/modules.dart';

CadastrarBiometriaController makeGetxCadastrarBiometriaController() {
  return GetxCadastrarBiometriaController(
    fingerprintRepository: Get.find<FingerprintRepository>(),
    notificationRepository: Get.find<NotificationRepository>(),
  );
}
