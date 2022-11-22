import '../../../contracts/contracts.dart';
import '../../../data/data.dart';
import '../../infra/infra.dart';

NotificationRepository makeHttpNotificationRepository() {
  return HttpNotificationRepository(httpClientAdapter: makeHttpClientAdapter());
}
