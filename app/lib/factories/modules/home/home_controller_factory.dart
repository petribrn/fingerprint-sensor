import 'package:get/get.dart';

import '../../../contracts/contracts.dart';
import '../../../modules/modules.dart';

HomeController makeGetxHomeController() {
  return GetxHomeController(
    userSessionStorage: Get.find<UserSessionStorage>(),
    bottomNavigationBarUtils: Get.find<BottomNavigationBarUtils>(),
  );
}
