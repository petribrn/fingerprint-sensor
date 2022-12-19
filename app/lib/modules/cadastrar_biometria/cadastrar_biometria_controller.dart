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
      return showSnackbar(
        text: 'Aguarde o cadastro da digital ser finalizado',
        duration: const Duration(seconds: 2),
      );
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

      if (resultSensor.hasError || resultSensor.isEmpty) {
        throw Result.empty();
      }

      if (resultSensor.hasData) {
        final dataTyped = resultSensor.data as Map<String, dynamic>;

        if (dataTyped['data']['isUp'] != true) {
          return await Get.dialog(const SensorConnectionDialog());
        }
      }
    } on Result catch (result) {
      return showSnackbar(text: result.error ?? 'Erro na conexão com o servidor. Tente novamente');
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
        throw Result.empty();
      } else if (resultId.hasData) {
        final dataIdTyped = resultId.data as Map<String, dynamic>;

        if (dataIdTyped['data']['error'] == 'Id da digital já cadastrado') {
          throw Result.error('O código informado já pertence a uma digital cadastrada');
        }

        if (dataIdTyped['data']['signUpMode'] != true) {
          // Erro na conexão do arduino ao enviar id da digital para iniciar cadastro
          throw Result.empty();
        }

        if (dataIdTyped['data']['message'] == 'Posicione o dedo no sensor') {
          await Future.delayed(const Duration(seconds: 2));
          yield Result.data(dataIdTyped['message']);
        }
      }

      // 4: Start of first read
      final resultFirstRead = await fingerprintRepository.executeFirstRead();
      if (resultFirstRead.hasError || resultFirstRead.isEmpty) {
        throw Result.empty();
      } else if (resultFirstRead.hasData) {
        final dataFirstReadTyped = resultFirstRead.data as Map<String, dynamic>;

        if (dataFirstReadTyped['data']['error'] == 'Erro image2Tz 1') {
          throw Result.error('Erro ao gravar imagem da primeira leitura da digital');
        }

        if (dataFirstReadTyped['data']['doneFirstRead'] == true && dataFirstReadTyped['data']['message'] == 'Retire o dedo do sensor') {
          await Future.delayed(const Duration(seconds: 2));
          yield Result.data(dataFirstReadTyped['message']);
        }
      }

      // VERIFICAR REMOÇÃO DO DEDO APÓS PRIMEIRA LEITURA
      // '''while (fingerprintSensor.getImage() != FINGERPRINT_NOFINGER);'''
      await Future.delayed(const Duration(seconds: 2));
      yield Result.data('Encoste o mesmo dedo no sensor');

      // 5: Start of second read
      final resultSecondRead = await fingerprintRepository.executeSecondRead();

      if (resultSecondRead.hasError || resultSecondRead.isEmpty) {
        throw Result.empty();
      } else if (resultSecondRead.hasData) {
        final dataSecondReadTyped = resultSecondRead.data as Map<String, dynamic>;

        if (dataSecondReadTyped['data']['error'] == 'Erro image2Tz 2') {
          throw Result.error('Erro ao gravar imagem da segunda leitura da digital');
        }

        if (dataSecondReadTyped['data']['error'] == 'Erro createModel') {
          throw Result.error('Erro criar modelo da digital após as duas leituras serem bem sucedidas');
        }

        if (dataSecondReadTyped['data']['error'] == 'Erro storeModel') {
          throw Result.error('Erro ao gravar digital no sensor após as duas leituras serem bem sucedidas');
        }

        if (dataSecondReadTyped['data']['doneSecondRead'] == true && dataSecondReadTyped['data']['message'] == 'Leitura concluída') {
          // 6: Store new fingeprint id in database
          final resultStore = await fingerprintRepository.sendFingerprint(
            Fingerprint(fingerprintId: _currentId!),
          );

          if (resultStore.hasError || resultStore.isEmpty) {
            if (resultStore.isEmpty) {
              throw Result.empty();
            } else if (resultStore.hasError) {
              throw Result.error('Erro ao salvar digital no banco de dados');
            }
          } else if (resultStore.hasData) {
            await Future.delayed(const Duration(seconds: 2));
            yield Result.data('Digital cadastrada com sucesso');

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
    } on Result catch (result) {
      showSnackbar(text: result.error ?? 'Erro na conexão com o servidor. Tente novamente');

      yield Result.error('Erro no cadastro da digital');
    }
  }

  @override
  void onFinishRegister() {
    _willStartRegister.value = false;
    _isFabDisabled.value = false;
  }
}
