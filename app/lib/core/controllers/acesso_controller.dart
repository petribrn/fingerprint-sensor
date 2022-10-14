import 'package:get/get.dart';

import '../../contracts/contracts.dart';
import '../../data/data.dart';

class GetxAcessoController extends GetxController implements AcessoController {
  static final _accessModeSelected = Rx(AccessMode.none);

  @override
  AccessMode get accessModeSelected => _accessModeSelected.value;

  @override
  set accessModeSelected(AccessMode accessModeSelected) => _accessModeSelected.value = accessModeSelected;

  GetxAcessoController();
}
