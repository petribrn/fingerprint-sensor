import '../../contracts/contracts.dart';
import '../../factories/factories.dart';
import '../models/models.dart';

class HttpNotificationRepository implements NotificationRepository {
  HttpClient httpClientAdapter;

  HttpNotificationRepository({
    required this.httpClientAdapter,
  });

  @override
  Future<Result> sendNotification(Map<String, dynamic> message) async {
    // Include a new route in API later
    final url = makeApiUrl(path: 'notifications');

    try {
      final resultNotification = await httpClientAdapter.request(
        url: url,
        method: 'post',
        body: message,
      );

      return resultNotification == null ? Result.empty() : Result.data(resultNotification);
    } on Exception catch (e) {
      return Result.error('$e');
    }
  }
}
