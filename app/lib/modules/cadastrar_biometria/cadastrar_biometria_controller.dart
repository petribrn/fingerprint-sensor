import 'package:connectivity/connectivity.dart';
import 'package:fingerprint_sensor/data/data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../contracts/contracts.dart';
import '../../core/core.dart';
import '../../global_widgets/global_widgets.dart';
import 'local_widgets/local_widgets.dart';

class GetxCadastrarBiometriaController extends GetxController implements CadastrarBiometriaController {
  final FingerprintRepository fingerprintRepository;

  GetxCadastrarBiometriaController({
    required this.fingerprintRepository,
  });

  final _willStartRegister = false.obs;
  final _isFabDisabled = false.obs;

  @override
  bool get willStartRegister => _willStartRegister.value;

  @override
  bool get isFabDisabled => _isFabDisabled.value;

  @override
  Future<void> onAddFingerprintPressed() async {
    if (_isFabDisabled.value) {
      return showSnackbar(text: 'Aguarde o cadastro ser finalizado.');
    }

    final connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      return await Get.dialog(const ConnectivityDialog());
    }

    final id = await showDialog<int?>(
      context: Get.context!,
      builder: ((_) => AddFingerprintDialog(
            fieldKey: GlobalKey<FormFieldState>(),
          )),
    );

    if (id != null) {
      final resultId = await _checkFingerprintId(id);

      if (resultId.hasError) {
        if (resultId.error?.contains('Connection') ?? false) {
          return showSnackbar(
            text: 'Falha na conexão com o servidor. Tente novamente.',
            duration: const Duration(seconds: 3),
          );
        }

        if (resultId.error?.contains('existing') ?? false) {
          return showSnackbar(
            text: 'O código informado já pertence a uma digital cadastrada. ${resultId.error}',
            duration: const Duration(seconds: 3),
          );
        }
      }

      final resultSensor = await _checkSensorConnectionState();

      if (resultSensor.hasError) {
        if (resultSensor.error?.contains('Connection') ?? false) {
          return showSnackbar(
            text: 'Falha na conexão com o servidor. Tente novamente.',
            duration: const Duration(seconds: 3),
          );
        }
      }

      if (resultSensor.hasData) {
        final dataTyped = resultSensor.data as Map<String, dynamic>;

        if (dataTyped.containsKey('sensor')) {
          return await Get.dialog(const SensorConnectionDialog());
        }
      }

      _willStartRegister.value = true;
      _isFabDisabled.value = true;
    }
  }

  @override
  int? onFingerprintIdEntered({
    required String? value,
    required GlobalKey<FormFieldState> fieldKey,
  }) {
    final fieldCurrentState = fieldKey.currentState;

    if (fieldCurrentState == null) {
      showSnackbar(text: 'Não foi possível enviar o código. Tente novamente.');
      return null;
    }

    final isValid = fieldCurrentState.validate();
    if (isValid) {
      fieldCurrentState.save();

      return int.tryParse(value ?? '');
    }

    return null;
  }

  Future<Result> _checkFingerprintId(int id) async {
    return await fingerprintRepository.sendFingerprint(
      Fingerprint(fingerprintId: id),
    );
  }

  Future<Result> _checkSensorConnectionState() async {
    return await fingerprintRepository.sendMessage('sensor_state', AccessMode.cadastro_biometria);
  }

  @override
  Stream<Result> registerFingerprintInSensor() async* {
    await Future.delayed(const Duration(seconds: 3));

    yield Result.data('Posicione o dedo no sensor');

    await Future.delayed(const Duration(seconds: 3));

    yield Result.data('Retire o dedo do sensor');

    await Future.delayed(const Duration(seconds: 3));

    yield Result.data('Encoste o mesmo dedo no sensor');

    await Future.delayed(const Duration(seconds: 3));

    yield Result.error('Erro na leitura da digital');

    // yield Result.data('Digital cadastrada com sucesso');
  }

  @override
  void onFinishRegister() {
    _willStartRegister.value = true;
    _isFabDisabled.value = false;
  }
}
