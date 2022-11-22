import 'package:get/get.dart';

import '../../../data/data.dart';

abstract class CadastrarBiometriaController implements GetxController {
  bool get willStartRegister;
  bool get isFabDisabled;

  Future<void> onAddFingerprintPressed();

  Stream<Result> registerFingerprintInSensor();

  void onFinishRegister();
}
