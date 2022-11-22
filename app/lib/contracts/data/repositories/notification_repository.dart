import '../../../data/data.dart';

abstract class NotificationRepository {
  Future<Result> sendNotification(Map<String, dynamic> message);
}
