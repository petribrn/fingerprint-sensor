import 'package:get/get.dart';

import '../../contracts/contracts.dart';
import '../../core/core.dart';
import '../../data/data.dart';
import '../../routes/routes.dart';

class GetxSelecionarAcessoController extends GetxController implements SelecionarAcessoController {
  final AcessoController acessoController;
  final UserSessionStorage userSessionStorage;

  final _isFirstAppUse = true.obs;
  final _currentMode = Rx(AccessMode.none);

  @override
  bool get isFirstAppUse => _isFirstAppUse.value;

  @override
  AccessMode get currentMode => _currentMode.value;

  GetxSelecionarAcessoController({
    required this.acessoController,
    required this.userSessionStorage,
  });

  @override
  Future<void> onInit() async {
    super.onInit();

    final idAcessoSelected = await userSessionStorage.getAcessoSelectedId();

    _isFirstAppUse.value = await userSessionStorage.isFirstAppUse();
    _currentMode.value = getAccessModeById(idAcessoSelected);
  }

  @override
  Future<void> onModeSelected(AccessMode accessMode) async {
    if (!AccessMode.values.contains(accessMode)) {
      return showSnackbar(text: 'Ops, houve um problema ao selecionar um modo de acesso!');
    }

    if (accessMode == _currentMode.value) {
      return showSnackbar(text: 'Modo de acesso já selecionado');
    }

    acessoController.accessModeSelected = accessMode;
    Get.offAllNamed(AppRoutes.HOME);

    if (_isFirstAppUse.value) {
      await userSessionStorage.writeFirstAppUse();
    }

    await userSessionStorage.writeAcessoSelectedId(accessMode.index);
  }
}
