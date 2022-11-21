import 'package:get/get.dart';

import '../../../contracts/contracts.dart';
import '../../../modules/modules.dart';

SplashScreenController makeGetxSplashScreenController() {
  return GetxSplashScreenController(
    userSessionStorage: Get.find<UserSessionStorage>(),
  );
}
