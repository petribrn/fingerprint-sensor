import 'package:get/get.dart';

import '../../../contracts/contracts.dart';
import '../../../modules/modules.dart';
import '../../infra/infra.dart';

HomeController makeGetxHomeController() {
  return GetxHomeController(
    userSessionStorage: makeUserSessionStorageImpl(),
    bottomNavigationBarUtils: Get.find<BottomNavigationBarUtils>(),
  );
}
