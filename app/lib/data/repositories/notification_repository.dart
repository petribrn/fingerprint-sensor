import 'package:fingerprint_sensor/data/data.dart';

import '../../contracts/contracts.dart';
import '../../factories/factories.dart';

class HttpNotificationRepository implements NotificationRepository {
  HttpClient httpClientAdapter;

  HttpNotificationRepository({
    required this.httpClientAdapter,
  });

  @override
  Future<Result> fetchSensorState() async {
    final url = makeApiUrl(path: 'users/status');

    try {
      final resultNotification = await httpClientAdapter.request(
        url: url,
        method: 'get',
      );

      return resultNotification == null ? Result.empty() : Result.data(resultNotification);
    } on Exception catch (error) {
      if (error is AppException) {
        return Result.error(error.message);
      }

      return Result.error('$error');
    }
  }
}
