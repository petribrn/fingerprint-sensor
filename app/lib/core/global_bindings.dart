import 'package:get/get.dart';

import '../contracts/contracts.dart';
import '../factories/factories.dart';

class GlobalBindings extends Bindings {
  GlobalBindings();

  @override
  void dependencies() {
    Get.put<FingerprintRepository>(makeHttpFingerprintRepository(), permanent: true);
  }
}
