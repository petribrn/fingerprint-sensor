import '../../../contracts/contracts.dart';
import '../../../modules/modules.dart';
import '../../factories.dart';

SelecionarAcessoController makeSelecionarAcessoController() {
  return GetxSelecionarAcessoController(
    userSessionStorage: makeUserSessionStorage(),
  );
}
