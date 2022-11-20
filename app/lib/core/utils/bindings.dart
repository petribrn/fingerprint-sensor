import 'package:get/get.dart';

import '../../contracts/contracts.dart';
import '../../modules/modules.dart';

class BindingsUtils {
  static bool get isFingerprintRepositoryRegistered => Get.isRegistered<FingerprintRepository>();

  static bool get isSplashControllerRegistered => Get.isRegistered<SplashScreenController>();

  static bool get isSelecionarAcessoControllerRegistered => Get.isRegistered<SelecionarAcessoController>();

  static bool get isBottomNavigationUtilsRegistered => Get.isRegistered<BottomNavigationBarUtils>();

  static bool get isHomeControllerRegistered => Get.isRegistered<HomeController>();

  static bool get isCadastrarBiometriaControllerRegistered => Get.isRegistered<CadastrarBiometriaController>();

  static bool get isVisualizarBiometriasControllerRegistered => Get.isRegistered<VisualizarBiometriasController>();

  static bool get isVerificarBiometriaControllerRegistered => Get.isRegistered<VerificarBiometriaController>();

  static bool get isVisualizarHistoricoControllerRegistered => Get.isRegistered<VisualizarHistoricoController>();

  static bool get isSobreControllerRegistered => Get.isRegistered<SobreController>();
}
