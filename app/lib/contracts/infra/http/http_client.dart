abstract class HttpClient {
  Future<Map<String, dynamic>?> request({
    required String url,
    required String method,
    Map<String, dynamic>? body,
  });

  Future<List<Map<String, dynamic>>?> requestAll({
    required String url,
    Map<String, dynamic>? body,
  });
}
