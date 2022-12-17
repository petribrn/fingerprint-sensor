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
  final _fingerprintsToShow = <Fingerprint>[].obs;

  final _isLoading = true.obs;

  @override
  List<Fingerprint> get fingerprints => _fingerprints;

  @override
  List<Fingerprint> get fingerprintsToShow => _fingerprintsToShow;

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

    try {
      final fingerprintsFetched = await fingerprintRepository.fetchAllFingerprints() ?? [];

      // Sorting by latest creation date
      _fingerprints.value = fingerprintsFetched..sort((f1, f2) => f2.creationDate.compareTo(f1.creationDate));
      _fingerprintsToShow.value = _fingerprints;

      await Future.delayed(const Duration(milliseconds: 800));
      _isLoading.value = false;
    } on Result catch (error) {
      showSnackbar(text: error.error ?? 'Falha na conexão com o servidor. Tente novamente.');
    }
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
        _fingerprintsToShow.value = fingerprintsFiltered;
      }
    }
  }

  @override
  Future<void> onEditSelected(Fingerprint fingerprint) async {
    final fingerprintEdited = await showDialog<Fingerprint?>(
      context: Get.context!,
      builder: ((_) => EditionDialog(
            fingerprint: fingerprint,
          )),
    );

    try {
      if (fingerprintEdited != null) {
        if (fingerprint.name != fingerprintEdited.name) {
          await fingerprintRepository.updateFingerprint(fingerprintEdited);
          await reloadData();

          showSnackbar(text: 'Digital editada com sucesso');
        } else {
          showSnackbar(text: 'A digital não teve alterações');
        }
      }
    } on Result catch (error) {
      showSnackbar(text: error.error ?? 'Falha na conexão com o servidor. Tente novamente.');
    }
  }

  @override
  Future<void> onExcludeSelected(int fingerprintId) async {
    final hasConfirmedExclusion = await showDialog<bool>(
          context: Get.context!,
          builder: ((_) => const ExclusionDialog()),
        ) ??
        false;

    try {
      if (hasConfirmedExclusion) {
        await fingerprintRepository.deleteFingerprint(fingerprintId);
        await reloadData();

        showSnackbar(text: 'Digital excluída com sucesso');
      }
    } on Result catch (error) {
      showSnackbar(text: error.error ?? 'Falha na conexão com o servidor. Tente novamente.');
    }
  }

  @override
  Future<void> onClose() async {
    super.onClose();

    await tabSubscription?.cancel();
  }
}
