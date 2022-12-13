import '../../../data/data.dart';

abstract class NotificationRepository {
  Future<Result> fetchSensorState();
}
