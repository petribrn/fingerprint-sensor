import 'package:get/get.dart';

import '../../../contracts/contracts.dart';
import '../../../modules/modules.dart';
import '../../infra/infra.dart';

HomeController makeHomeController() {
  return GetxHomeController(
    userSessionStorage: makeUserSessionStorage(),
    bottomNavigationBarUtils: Get.find<BottomNavigationBarUtils>(),
  );
}
