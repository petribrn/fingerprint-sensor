import 'package:get/get.dart';

import '../../../contracts/contracts.dart';
import '../../../modules/modules.dart';
import '../../factories.dart';

SelecionarAcessoController makeSelecionarAcessoController() {
  return GetxSelecionarAcessoController(
    acessoController: Get.find<AcessoController>(),
    userSessionStorage: makeUserSessionStorage(),
  );
}
