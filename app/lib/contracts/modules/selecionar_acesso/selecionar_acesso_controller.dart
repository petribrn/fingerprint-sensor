import '../../../data/data.dart';

abstract class SelecionarAcessoController {
  bool get isFirstAppUse;
  AccessMode get currentMode;

  Future<void> onModeSelected(AccessMode accessMode);
}
