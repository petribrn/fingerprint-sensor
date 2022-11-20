import 'package:get/get.dart';

import '../../../data/data.dart';

abstract class VisualizarHistoricoController implements GetxController {
  RxMap<String, List<HistoryRecord>> get historyRecordsRx;
  Map<String, List<HistoryRecord>> get historyRecords;

  bool get isLoading;
  int get latestDayReadCount;

  Future<void> reloadData();
}
