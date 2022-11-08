import 'package:fingerprint_sensor/infra/infra.dart';
import 'package:http/http.dart';

import '../../../contracts/contracts.dart';

HttpClient makeHttpClientAdapter() {
  return HttpClientAdapter(client: Client());
}
