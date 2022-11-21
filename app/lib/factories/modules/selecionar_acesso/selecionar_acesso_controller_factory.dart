import 'package:get/get.dart';

import '../../../contracts/contracts.dart';
import '../../../modules/modules.dart';

SelecionarAcessoController makeGetxSelecionarAcessoController() {
  return GetxSelecionarAcessoController(
    userSessionStorage: Get.find<UserSessionStorage>(),
  );
}
