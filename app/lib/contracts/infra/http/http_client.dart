abstract class HttpClient {
  Future request({
    required String url,
    required String method,
    Map<String, dynamic>? body,
  });

  Future<List?> requestAll({
    required String url,
    Map<String, dynamic>? body,
  });
}
