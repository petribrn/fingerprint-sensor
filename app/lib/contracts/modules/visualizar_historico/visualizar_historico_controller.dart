import '../../../data/data.dart';

abstract class VisualizarHistoricoController {
  List<HistoryRecord> get historyRecords;
  bool get isLoading;

  Future<void> reloadData();
}
