import 'package:get/get.dart';

import '../../../data/data.dart';

abstract class VerificarBiometriaController implements GetxController {
  bool get willStartVerification;
  bool get isVerifyButtonDisabled;

  Future<void> onVerifyButtonPressed();
  Stream<Result> verifyFingerprintInSensor();
  void onFinishVerification();
}
