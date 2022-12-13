import '../../contracts/contracts.dart';
import '../../factories/factories.dart';
import '../models/models.dart';

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
    } on Exception catch (e) {
      return Result.error('$e');
    }
  }
}
