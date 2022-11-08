import '../../../contracts/contracts.dart';
import '../../../data/data.dart';
import '../../infra/infra.dart';

FingerprintRepository makeHttpFingerprintRepository() {
  return HttpFingerprintRepository(httpClientAdapter: makeHttpClientAdapter());
}
