import 'package:get/get.dart';

import '../../contracts/contracts.dart';
import '../../routes/routes.dart';

class GetxSplashScreenController extends GetxController implements SplashScreenController {
  final UserSessionStorage userSessionStorage;

  final _isLoading = true.obs;

  @override
  bool get isLoading => _isLoading.value;

  GetxSplashScreenController({
    required this.userSessionStorage,
  });

  @override
  Future<void> onReady() async {
    super.onReady();

    // Load core data
    await Future.delayed(const Duration(seconds: 1));

    final isFirstUse = await userSessionStorage.isFirstAppUse();
    _isLoading.value = false;

    Get.offAllNamed(isFirstUse ? AppRoutes.ACESSO : AppRoutes.HOME);
  }
}
