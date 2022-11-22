import 'package:get/get.dart';

import '../contracts/contracts.dart';
import '../factories/factories.dart';

class GlobalBindings extends Bindings {
  GlobalBindings();

  @override
  void dependencies() {
    // Repositories
    Get.put<FingerprintRepository>(makeHttpFingerprintRepository(), permanent: true);
    Get.put<HistoryRecordRepository>(makeHttpHistoryRecordRepository(), permanent: true);
    Get.put<NotificationRepository>(makeHttpNotificationRepository(), permanent: true);

    // Utils
    Get.put<UserSessionStorage>(makeUserSessionStorageImpl());
  }
}
