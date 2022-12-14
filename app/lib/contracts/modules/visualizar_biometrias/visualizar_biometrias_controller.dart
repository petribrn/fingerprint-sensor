import 'package:get/get.dart';

import '../../../data/data.dart';

abstract class VisualizarBiometriasController implements GetxController {
  List<Fingerprint> get fingerprints;
  List<Fingerprint> get fingerprintsToShow;
  bool get isLoading;

  Future<void> reloadData();
  Future<void> onSearchFieldSubmitted(String? name);

  Future<void> onEditSelected(Fingerprint fingerprint);
  Future<void> onExcludeSelected(int fingerprintId);
}
