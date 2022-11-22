import '../../contracts/contracts.dart';
import '../../factories/factories.dart';
import '../models/models.dart';

class HttpHistoryRecordRepository implements HistoryRecordRepository {
  HttpClient httpClientAdapter;

  HttpHistoryRecordRepository({
    required this.httpClientAdapter,
  });

  @override
  Future<List<HistoryRecord>?> fetchAllHistoryRecords() async {
    // Include a new route in API later
    final url = makeApiUrl(path: 'history_records');

    try {
      final historyRecordsResponse = await httpClientAdapter.requestAll(
        url: url.toString(),
      );

      if (historyRecordsResponse == null) return null;

      final historyRecords = historyRecordsResponse.map((historyRecordMap) {
        return HistoryRecord.fromMap(historyRecordMap);
      }).toList();

      return historyRecords;
    } on Exception catch (_) {
      return null;
    }
  }
}
