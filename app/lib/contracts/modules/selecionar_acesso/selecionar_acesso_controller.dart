import 'package:get/get.dart';

import '../../../data/data.dart';

abstract class SelecionarAcessoController implements GetxController {
  bool get isFirstAppUse;
  AccessMode get currentMode;

  Future<void> onModeSelected(AccessMode accessMode);
}
