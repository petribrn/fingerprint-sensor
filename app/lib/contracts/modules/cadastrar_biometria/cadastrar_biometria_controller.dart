import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/data.dart';

abstract class CadastrarBiometriaController implements GetxController {
  bool get willStartRegister;
  bool get isFabDisabled;

  Future<void> onAddFingerprintPressed();

  int? onFingerprintIdEntered({
    required String? value,
    required GlobalKey<FormFieldState> fieldKey,
  });

  Stream<Result> registerFingerprintInSensor();

  void onFinishRegister();
}
