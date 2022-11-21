import 'package:connectivity/connectivity.dart';
import 'package:get/get.dart';

import '../../contracts/contracts.dart';
import '../../core/core.dart';
import '../../data/data.dart';
import '../../global_widgets/global_widgets.dart';

class GetxVerificarBiometriaController extends GetxController implements VerificarBiometriaController {
  final FingerprintRepository fingerprintRepository;

  GetxVerificarBiometriaController({
    required this.fingerprintRepository,
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

    final connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      return await Get.dialog(const ConnectivityDialog());
    }

    final resultSensor = await _checkSensorConnectionState();

    if (resultSensor.hasError) {
      if (resultSensor.error?.contains('Connection') ?? false) {
        return showSnackbar(
          text: 'Falha na conexão com o servidor. Tente novamente.',
          duration: const Duration(seconds: 3),
        );
      }

      return showSnackbar(
        text: 'Erro durante a verificação da digital. Tente novamente.',
        duration: const Duration(seconds: 3),
      );
    }

    if (resultSensor.hasData) {
      final dataTyped = resultSensor.data as Map<String, dynamic>;

      if (dataTyped.containsKey('sensor')) {
        return await Get.dialog(const SensorConnectionDialog());
      }
    }

    _willStartVerification.value = true;
    _isVerifyButtonDisabled.value = true;
  }

  Future<Result> _checkSensorConnectionState() async {
    return await fingerprintRepository.sendMessage('sensor_state', AccessMode.verificar_biometria);
  }

  @override
  Stream<Result> verifyFingerprintInSensor() async* {
    await Future.delayed(const Duration(seconds: 3));

    yield Result.data('Posicione o dedo no sensor');

    await Future.delayed(const Duration(seconds: 3));

    // yield Result.error('Erro na leitura da digital');

    yield Result.data('Digital encontrada');
  }

  @override
  void onFinishVerification() {
    _willStartVerification.value = true;
    _isVerifyButtonDisabled.value = false;
  }
}
