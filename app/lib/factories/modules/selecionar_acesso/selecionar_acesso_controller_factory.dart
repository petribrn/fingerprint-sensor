import '../../../contracts/contracts.dart';
import '../../../modules/modules.dart';
import '../../factories.dart';

SelecionarAcessoController makeGetxSelecionarAcessoController() {
  return GetxSelecionarAcessoController(
    userSessionStorage: makeUserSessionStorageImpl(),
  );
}
