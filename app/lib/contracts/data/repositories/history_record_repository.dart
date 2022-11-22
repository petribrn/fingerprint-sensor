import '../../../data/data.dart';

abstract class HistoryRecordRepository {
  Future<List<HistoryRecord>?> fetchAllHistoryRecords();
}
