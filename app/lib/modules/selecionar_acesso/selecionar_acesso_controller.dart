import 'package:get/get.dart';

import '../../contracts/contracts.dart';
import '../../core/core.dart';
import '../../data/data.dart';
import '../../routes/routes.dart';

class GetxSelecionarAcessoController extends GetxController implements SelecionarAcessoController {
  final UserSessionStorage userSessionStorage;

  final _isFirstAppUse = true.obs;
  final _currentMode = Rx(AccessMode.none);

  @override
  bool get isFirstAppUse => _isFirstAppUse.value;

  @override
  AccessMode get currentMode => _currentMode.value;

  GetxSelecionarAcessoController({
    required this.userSessionStorage,
  });

  @override
  Future<void> onInit() async {
    super.onInit();
    _isFirstAppUse.value = await userSessionStorage.isFirstAppUse();

    final idAccessModeSelected = await userSessionStorage.getAccessSelectedId();
    _currentMode.value = getAccessModeById(idAccessModeSelected);
  }

  @override
  Future<void> onModeSelected(AccessMode accessMode) async {
    if (!AccessMode.values.contains(accessMode)) {
      return showSnackbar(text: 'Ops, houve um problema ao selecionar um modo de acesso!');
    }

    if (accessMode == _currentMode.value) {
      return showSnackbar(text: 'Modo de acesso já selecionado');
    }

    if (_isFirstAppUse.value) {
      await userSessionStorage.writeNotFirstAppUse();
    }
    await userSessionStorage.writeAccessSelectedId(accessMode.index);

    Get.offAllNamed(AppRoutes.HOME);
  }
}
