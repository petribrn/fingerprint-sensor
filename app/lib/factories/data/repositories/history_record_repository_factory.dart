import '../../../contracts/contracts.dart';
import '../../../data/data.dart';
import '../../infra/infra.dart';

HistoryRecordRepository makeHttpHistoryRecordRepository() {
  return HttpHistoryRecordRepository(httpClientAdapter: makeHttpClientAdapter());
}
