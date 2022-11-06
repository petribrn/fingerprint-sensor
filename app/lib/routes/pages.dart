export 'pages.dart';

import 'package:get/get.dart';

import '../contracts/contracts.dart';
import '../factories/factories.dart';
import '../modules/modules.dart';
import 'routes.dart';

List<GetPage> makeAppPages() {
  return [
    GetPage(
      name: AppRoutes.SPLASH,
      page: () => const SplashScreenPage(),
      binding: BindingsBuilder(() => Get.lazyPut<SplashScreenController>(() => makeGetxSplashScreenController())),
    ),
    GetPage(
      name: AppRoutes.ACESSO,
      page: () => const SelecionarAcessoPage(),
      binding: BindingsBuilder(() => Get.lazyPut<SelecionarAcessoController>(() => makeGetxSelecionarAcessoController(), fenix: true)),
    ),
    GetPage(
      name: AppRoutes.HOME,
      page: () => const HomePage(),
      binding: BindingsBuilder(() {
        // Bindings: Local Utils
        Get.put(BottomNavigationBarUtils());

        // Bindings: Local Pages
        Get.lazyPut<HomeController>(() => makeGetxHomeController(), fenix: true);

        Get.lazyPut<CadastrarBiometriaController>(() => makeGetxCadastrarBiometriaController());

        Get.lazyPut<VisualizarBiometriasController>(() => makeGetxVisualizarBiometriasController());

        Get.lazyPut<VerificarBiometriaController>(() => makeGetxVerificarBiometriaController());

        Get.lazyPut<VisualizarHistoricoController>(() => makeGetxVisualizarHistoricoController());

        Get.lazyPut<SelecionarAcessoController>(() => makeGetxSelecionarAcessoController(), fenix: true);

        Get.lazyPut<SobreController>(() => makeGetxSobreController());
      }),
    ),
  ];
}
