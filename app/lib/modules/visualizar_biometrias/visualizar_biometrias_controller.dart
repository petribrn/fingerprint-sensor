import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../contracts/contracts.dart';
import '../../core/core.dart';
import '../../data/data.dart';
import '../../global_widgets/global_widgets.dart';
import '../modules.dart';

class GetxVisualizarBiometriasController extends GetxController implements VisualizarBiometriasController {
  final FingerprintRepository fingerprintRepository;
  final BottomNavigationBarUtils bottomNavigationBarUtils;

  StreamSubscription? tabSubscription;

  GetxVisualizarBiometriasController({
    required this.fingerprintRepository,
    required this.bottomNavigationBarUtils,
  });

  final _fingerprints = <Fingerprint>[].obs;
  final _isLoading = true.obs;

  @override
  List<Fingerprint> get fingerprints => _fingerprints;

  @override
  bool get isLoading => _isLoading.value;

  @override
  Future<void> onReady() async {
    super.onReady();

    _initOnPageOpenListener();
    await _fetchFingerprints();
  }

  void _initOnPageOpenListener() {
    tabSubscription = bottomNavigationBarUtils.onTabChangedStream.listen((mode) async {
      if (mode == AccessMode.cadastro_biometria) {
        await _fetchFingerprints();
      }
    });
  }

  Future<void> _fetchFingerprints() async {
    final connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      return await Get.dialog(const ConnectivityDialog());
    }

    _isLoading.value = true;

    final fingerprintsFetched = await fingerprintRepository.fetchAllFingerprints() ?? [];
    _fingerprints.value = fingerprintsFetched..sort((f1, f2) => f1.fingerprintId.compareTo(f2.fingerprintId));

    // Remove this mocks when API is fully integrated
    _fingerprints.value = [
      Fingerprint(fingerprintId: 1, creationDate: DateTime(2017, 9, 7)),
      Fingerprint(fingerprintId: 8, creationDate: DateTime(2021, 9, 7)),
      Fingerprint(fingerprintId: 2, creationDate: DateTime(2018, 9, 7)),
      Fingerprint(fingerprintId: 9, creationDate: DateTime(2021, 9, 7)),
      Fingerprint(fingerprintId: 3, name: 'André de Souza', creationDate: DateTime(2019, 9, 7)),
      Fingerprint(fingerprintId: 4, creationDate: DateTime(2020, 9, 7)),
      Fingerprint(fingerprintId: 5, creationDate: DateTime(2021, 9, 7)),
      Fingerprint(fingerprintId: 6, creationDate: DateTime(2021, 9, 7)),
      Fingerprint(fingerprintId: 7, creationDate: DateTime(2021, 9, 7)),
    ]..sort((f1, f2) => f1.fingerprintId.compareTo(f2.fingerprintId));

    await Future.delayed(const Duration(milliseconds: 1200));
    _isLoading.value = false;
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

  @override
  Future<void> onClose() async {
    super.onClose();

    await tabSubscription?.cancel();
  }
}
