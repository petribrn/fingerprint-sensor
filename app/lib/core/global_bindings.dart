import 'package:get/get.dart';

import '../contracts/contracts.dart';
import 'controllers/controllers.dart';

class GlobalBindings extends Bindings {
  GlobalBindings();

  @override
  void dependencies() {
    Get.put<AcessoController>(GetxAcessoController(), permanent: true);
  }
}