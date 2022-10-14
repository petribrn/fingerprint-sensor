import 'package:get/get.dart';

import '../../../contracts/contracts.dart';
import '../../../modules/modules.dart';

HomeController makeHomeController() {
  return GetxHomeController(
    acessoController: Get.find<AcessoController>(),
    bottomNavigationBarUtils: Get.find<BottomNavigationBarUtils>(),
  );
}
