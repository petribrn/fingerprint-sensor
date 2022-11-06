import '../../../contracts/contracts.dart';
import '../../../modules/modules.dart';
import '../../factories.dart';

SplashScreenController makeSplashScreenController() {
  return GetxSplashScreenController(
    userSessionStorage: makeUserSessionStorage(),
  );
}
