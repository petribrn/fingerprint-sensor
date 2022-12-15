import '../../contracts/contracts.dart';
import '../../factories/factories.dart';
import '../data.dart';

class HttpHistoryRecordRepository implements HistoryRecordRepository {
  HttpClient httpClientAdapter;

  HttpHistoryRecordRepository({
    required this.httpClientAdapter,
  });

  @override
  Future<List<HistoryRecord>?> fetchAllHistoryRecords() async {
    final url = makeApiUrl(path: 'history_records');

    try {
      final historyRecordsResponse = await httpClientAdapter.requestAll(
        url: url.toString(),
      );

      if (historyRecordsResponse == null) return null;

      final historyRecordsRaw = historyRecordsResponse.map((historyRecordMap) {
        try {
          return HistoryRecord.fromMap(historyRecordMap);
        } on AppException {
          return HistoryRecord(fingerprint: Fingerprint(fingerprintId: -1));
        }
      }).toList();

      final historyRecords = historyRecordsRaw.where((historyRecord) => historyRecord.fingerprint.fingerprintId != -1).toList();

      return historyRecords;
    } on Exception catch (_) {
      return null;
    }
  }
}
