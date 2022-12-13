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
      return showSnackbar(text: 'Aguarde a verificação ser finalizada.');
    }

    // 1: Check device connectivity state
    final connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      return await Get.dialog(const ConnectivityDialog());
    }

    // 2: Check sensor connection state
    final resultSensor = await notificationRepository.fetchSensorState();

    if (resultSensor.hasError) {
      return showSnackbar(text: 'Falha na conexão com o servidor. Tente novamente.');
    }

    if (resultSensor.hasData) {
      final dataTyped = resultSensor.data as Map<String, dynamic>;

      if (dataTyped['data'] != true) {
        return await Get.dialog(const SensorConnectionDialog());
      }
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
        throw Result.error('Erro na verificação da digital');
      } else if (resultVerify.hasData) {
        final dataTyped = resultVerify.data as Map<String, dynamic>;

        if (dataTyped['data']['error'] != null) {
          final error = dataTyped['data']['error'];

          if (error == 'Connection lost' || error == 'Did not get any response from arduino') {
            showSnackbar(
              text: 'Falha na conexão com o servidor. Tente novamente.',
            );
          } else if (error == 'Fingerprint not found') {
            showSnackbar(
              text: 'Digital não foi encontrada no sensor',
            );
          } else if (error == 'User not found in cloud db.') {
            showSnackbar(
              text: 'Digital não foi encontrada no servidor',
            );
          }
        } else {
          await Future.delayed(const Duration(seconds: 2));
          yield Result.data('Digital encontrada');

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
    } on Result catch (error) {
      yield error;
    }
  }

  @override
  void onFinishVerification() {
    _willStartVerification.value = false;
    _isVerifyButtonDisabled.value = false;
  }
}
