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
      binding: BindingsBuilder(() => Get.lazyPut<SplashScreenController>(() => makeSplashScreenController())),
    ),
    GetPage(
      name: AppRoutes.ACESSO,
      page: () => const SelecionarAcessoPage(),
      binding: BindingsBuilder(() => Get.lazyPut<SelecionarAcessoController>(() => makeSelecionarAcessoController(), fenix: true)),
    ),
    GetPage(
      name: AppRoutes.HOME,
      page: () => const HomePage(),
      binding: BindingsBuilder(() {
        Get.put(BottomNavigationBarUtils());

        Get.lazyPut<HomeController>(() => makeHomeController(), fenix: true);

        Get.lazyPut<CadastrarBiometriaController>(() => makeCadastrarBiometriaController());

        Get.lazyPut<VisualizarBiometriasController>(() => makeVisualizarBiometriasController());

        Get.lazyPut<VerificarBiometriaController>(() => makeVerificarBiometriaController());

        Get.lazyPut<VisualizarHistoricoController>(() => makeVisualizarHistoricoController());

        Get.lazyPut<SelecionarAcessoController>(() => makeSelecionarAcessoController(), fenix: true);

        Get.lazyPut<SobreController>(() => makeSobreController());
      }),
    ),
  ];
}
