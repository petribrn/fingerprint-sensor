import 'package:connectivity/connectivity.dart';
import 'package:fingerprint_sensor/global_widgets/connectivity_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../contracts/contracts.dart';
import '../../core/core.dart';
import '../../data/data.dart';
import 'local_widgets/local_widgets.dart';

class GetxVisualizarBiometriasController extends GetxController implements VisualizarBiometriasController {
  final FingerprintRepository fingerprintRepository;

  GetxVisualizarBiometriasController({
    required this.fingerprintRepository,
  });

  final _fingerprints = <Fingerprint>[].obs;

  @override
  List<Fingerprint> get fingerprints => _fingerprints;

  @override
  Future<void> onReady() async {
    super.onReady();

    await _fetchFingerprints();
  }

  Future<void> _fetchFingerprints() async {
    final connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      return Get.dialog(const ConnectivityDialog());
    }

    final fingerprintsFetched = await fingerprintRepository.fetchAllFingerprints() ?? [];
    _fingerprints.value = fingerprintsFetched..sort((f1, f2) => f1.fingerprintId.compareTo(f2.fingerprintId));
  }

  @override
  Future<void> reloadData() async => await _fetchFingerprints();

  @override
  Future<void> onSearchFieldSubmitted(String? name) async {
    if (name == null || name.isEmpty) {
      return await reloadData();
    } else {
      final fingerprintsFiltered = _fingerprints.where(
        (fingerprint) {
          final objectNameFormatted = fingerprint.name?.removeAllWhitespace.removeDiacritics().toLowerCase() ?? '';
          final valueNameFormatted = name.removeAllWhitespace.removeDiacritics().toLowerCase();

          return objectNameFormatted.contains(valueNameFormatted);
        },
      ).toList();

      if (fingerprintsFiltered.isNotEmpty) {
        _fingerprints.value = fingerprintsFiltered;
      }
    }
  }

  @override
  Future<void> onEditSelected(Fingerprint fingerprint) async {
    final fingerprintEdited = await showDialog<Fingerprint?>(
      context: Get.context!,
      builder: ((_) => EditionDialog(
            fieldKey: GlobalKey<FormFieldState>(),
            fingerprint: fingerprint,
            onSaved: _onSavePressed,
          )),
    );

    if (fingerprintEdited != null) {
      await fingerprintRepository.updateFingerprint(fingerprint);
      await reloadData();

      showSnackbar(
        text: fingerprint.name != fingerprintEdited.name ? 'Digital editada com sucesso' : 'A digital não teve alterações',
      );
    }
  }

  @override
  Future<void> onExcludeSelected(int fingerprintId) async {
    final hasConfirmedExclusion = await showDialog<bool>(
          context: Get.context!,
          builder: ((_) => const ExclusionDialog()),
        ) ??
        false;

    if (hasConfirmedExclusion) {
      await fingerprintRepository.deleteFingerprint(fingerprintId);
      await reloadData();
    }
  }

  Fingerprint? _onSavePressed({
    required String? value,
    required Fingerprint fingerprint,
    required GlobalKey<FormFieldState> fieldKey,
  }) {
    final fieldCurrentState = fieldKey.currentState;

    if (fieldCurrentState == null) {
      showSnackbar(text: 'Não foi possível editar a digital. Tente novamente.');
      return null;
    }

    final isValid = fieldCurrentState.validate();
    if (isValid) {
      fieldCurrentState.save();

      final fingerprintEdited = fingerprint.copyWith(name: value);
      return fingerprintEdited;
    }

    return null;
  }
}
