import 'package:connectivity/connectivity.dart';
import 'package:get/get.dart';

import '../../contracts/contracts.dart';
import '../../core/core.dart';
import '../../data/data.dart';
import '../../global_widgets/global_widgets.dart';

class GetxVerificarBiometriaController extends GetxController implements VerificarBiometriaController {
  final FingerprintRepository fingerprintRepository;
  final NotificationRepository notificationRepository;

  GetxVerificarBiometriaController({
    required this.fingerprintRepository,
    required this.notificationRepository,
  });

  final _willStartVerification = false.obs;
  final _isVerifyButtonDisabled = false.obs;

  @override
  bool get willStartVerification => _willStartVerification.value;

  @override
  bool get isVerifyButtonDisabled => _isVerifyButtonDisabled.value;

  @override
  Future<void> onVerifyButtonPressed() async {
    if (_isVerifyButtonDisabled.value) {
      return showSnackbar(
        text: 'Aguarde a verificação ser finalizada',
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

    _willStartVerification.value = true;
    _isVerifyButtonDisabled.value = true;
  }

  @override
  Stream<Result> verifyFingerprintInSensor() async* {
    await Future.delayed(const Duration(seconds: 2));
    yield Result.data('Posicione o dedo no sensor');

    try {
      // 3: Verify user fingerprint in sensor
      final resultVerify = await fingerprintRepository.verifyFingerprint();

      if (resultVerify.hasError || resultVerify.isEmpty) {
        throw Result.empty();
      } else if (resultVerify.hasData) {
        final dataTyped = resultVerify.data as Map<String, dynamic>;

        if (dataTyped['data']['error'] != null) {
          final error = dataTyped['error'];

          if (error == 'Fingerprint not found') {
            throw Result.error('Digital não foi encontrada no sensor');
          }

          if (error == 'Erro image2Tz') {
            throw Result.error('Erro ao ler imagem da digital no sensor. Tente novamente');
          }

          throw Result.empty();
        } else {
          await Future.delayed(const Duration(seconds: 2));
          yield Result.data('Digital encontrada com sucesso');

          Get.dialog(
            FinishReadDialog(
              dialogContent: FinishDialogContent(
                id: dataTyped['data']['foundId'],
                name: dataTyped['data']['name'],
                date: DateTime.now(),
                confidence: dataTyped['data']['confidence'],
              ),
            ),
          );
        }
      }
    } on Result catch (result) {
      showSnackbar(text: result.error ?? 'Erro na conexão com o servidor. Tente novamente');

      yield Result.error('Erro na verificação da digital');
    }
  }

  @override
  void onFinishVerification() {
    _willStartVerification.value = false;
    _isVerifyButtonDisabled.value = false;
  }
}
