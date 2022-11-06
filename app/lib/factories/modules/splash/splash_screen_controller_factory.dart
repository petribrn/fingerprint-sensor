import '../../../contracts/contracts.dart';
import '../../../modules/modules.dart';
import '../../factories.dart';

SplashScreenController makeGetxSplashScreenController() {
  return GetxSplashScreenController(
    userSessionStorage: makeUserSessionStorageImpl(),
  );
}
