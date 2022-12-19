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
  final NotificationRepository notificationRepository;

  GetxCadastrarBiometriaController({
    required this.fingerprintRepository,
    required this.notificationRepository,
  });

  final _willStartRegister = false.obs;
  final _isFabDisabled = false.obs;

  @override
  bool get willStartRegister => _willStartRegister.value;

  @override
  bool get isFabDisabled => _isFabDisabled.value;

  int? _currentId;

  @override
  Future<void> onAddFingerprintPressed() async {
    if (_isFabDisabled.value) {
      return showSnackbar(text: 'Aguarde o cadastro ser finalizado.');
    }

    // 1: Check device connectivity state
    final connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      return await Get.dialog(const ConnectivityDialog());
    }

    // 2: Check sensor connection state
    Result resultSensor = Result();
    try {
      resultSensor = await notificationRepository.fetchSensorState();
    } on Result catch (error) {
      return showSnackbar(text: error.error ?? 'Falha na conexão com o servidor. Tente novamente.');
    }

    if (resultSensor.hasError) {
      return showSnackbar(text: 'Falha na conexão com o servidor. Tente novamente.');
    }

    if (resultSensor.hasData) {
      final dataTyped = resultSensor.data as Map<String, dynamic>;

      if (dataTyped['isUp'] != true) {
        return await Get.dialog(const SensorConnectionDialog());
      }
    }

    final id = await showDialog<int?>(
      context: Get.context!,
      builder: ((_) => AddFingerprintDialog()),
    );

    if (id != null) {
      _currentId = id;

      _willStartRegister.value = true;
      _isFabDisabled.value = true;
    }
  }

  @override
  Stream<Result> registerFingerprintInSensor() async* {
    try {
      if (_currentId == null) throw Result.error('Id da digital nulo');

      // 3: Send id, check it and start sign up
      final resultId = await fingerprintRepository.initSignUp(_currentId!);

      if (resultId.hasError || resultId.isEmpty) {
        showSnackbar(
          text: 'Falha na conexão com o servidor. Tente novamente.',
        );

        throw Result.error('Erro durante o cadastro da digital');
      } else if (resultId.hasData) {
        final dataTyped = resultId.data as Map<String, dynamic>;

        if (resultId.error == 'Id da digital já cadastrado') {
          showSnackbar(
            text: 'O código informado já pertence a uma digital cadastrada. ${resultId.error}',
            duration: const Duration(seconds: 3),
          );
        }

        if (dataTyped['message'] == 'Posicione o dedo no sensor') {
          await Future.delayed(const Duration(seconds: 2));
          yield Result.data(dataTyped['message']);
        }
      }

      // 4: Start of first read
      final resultFirstRead = await fingerprintRepository.executeFirstRead();
      if (resultFirstRead.hasError || resultFirstRead.isEmpty) {
        showSnackbar(
          text: 'Falha na conexão com o servidor. Tente novamente.',
        );

        throw Result.error('Erro durante o cadastro da digital');
      } else if (resultFirstRead.hasData) {
        final dataTyped = resultFirstRead.data as Map<String, dynamic>;

        if (dataTyped['message'] == 'Retire o dedo do sensor') {
          await Future.delayed(const Duration(seconds: 2));
          yield Result.data(dataTyped['message']);
        }
      }

      // VERIFICAR REMOÇÃO DO DEDO APÓS PRIMEIRA LEITURA
      // '''while (fingerprintSensor.getImage() != FINGERPRINT_NOFINGER);'''
      await Future.delayed(const Duration(seconds: 2));
      yield Result.data('Encoste o mesmo dedo no sensor');

      // 5: Start of second read
      final resultSecondRead = await fingerprintRepository.executeSecondRead();

      if (resultSecondRead.hasError || resultSecondRead.isEmpty) {
        showSnackbar(
          text: 'Falha na conexão com o servidor. Tente novamente.',
        );

        throw Result.error('Erro durante o cadastro da digital');
      } else if (resultSecondRead.hasData) {
        final dataTyped = resultSecondRead.data as Map<String, dynamic>;

        if (dataTyped['message'] == 'Digital cadastrada com sucesso') {
          // 6: Store new fingeprint id in database
          final resultStore = await fingerprintRepository.sendFingerprint(
            Fingerprint(fingerprintId: _currentId!),
          );

          if (resultStore.hasError || resultStore.isEmpty) {
            if (resultStore.isEmpty) {
              showSnackbar(
                text: 'Falha na conexão com o servidor. Tente novamente.',
              );
            } else if (resultStore.hasError) {
              showSnackbar(
                text: 'Erro ao salvar digital no banco de dados. Tente novamente.',
                duration: const Duration(seconds: 3),
              );
            }

            throw Result.error('Erro durante o cadastro da digital');
          } else {
            await Future.delayed(const Duration(seconds: 2));
            yield Result.data(dataTyped['message']);

            Get.dialog(
              FinishReadDialog(
                isCadastro: true,
                dialogContent: FinishDialogContent(
                  id: _currentId!,
                  date: DateTime.now(),
                ),
              ),
            );
          }
        }
      }
    } on Result catch (error) {
      yield error;
    }
  }

  @override
  void onFinishRegister() {
    _willStartRegister.value = false;
    _isFabDisabled.value = false;
  }
}
