import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';

import '../../contracts/contracts.dart';

class HttpClientAdapter implements HttpClient {
  Client client;
  final Map<String, String> _headers;

  HttpClientAdapter({
    required this.client,
  }) : _headers = {
          'content-type': 'application/json',
          'accept': 'application/json',
        };

  @override
  Future<Map<String, dynamic>?> request({
    required String url,
    required String method,
    Map<String, dynamic>? body,
  }) async {
    final bodyJson = body == null ? null : jsonEncode(body);
    var response = Response('', 500);

    try {
      switch (method) {
        case 'get':
          response = await client.get(Uri.parse(url), headers: _headers);
          break;
        case 'post':
          response = await client.post(Uri.parse(url), headers: _headers, body: bodyJson);
          break;
        case 'put':
          response = await client.put(Uri.parse(url), headers: _headers, body: bodyJson);
          break;
        case 'delete':
          response = await client.delete(Uri.parse(url), headers: _headers);
          break;
      }
    } on Exception catch (_) {
      rethrow;
    }

    return _checkResponseAndReturn(response) as Map<String, dynamic>?;
  }

  @override
  Future<List<Map<String, dynamic>>?> requestAll({
    required String url,
    Map<String, dynamic>? body,
  }) async {
    var response = Response('', 500);

    try {
      response = await client.get(Uri.parse(url), headers: _headers);
    } on Exception catch (_) {
      rethrow;
    }

    return _checkResponseAndReturn(response) as List<Map<String, dynamic>>?;
  }

  Future<dynamic> _checkResponseAndReturn(Response response) async {
    // Success
    if (response.statusCode == 200) {
      return response.body.isEmpty ? null : jsonDecode(response.body);
    }
    // No Content
    if (response.statusCode == 204) {
      return null;
    // Errors
    } else if (response.statusCode == 400) {
      throw const HttpException('400 - Bad Request');
    } else if (response.statusCode == 401) {
      throw const HttpException('401 - Unauthorized');
    } else if (response.statusCode == 403) {
      throw const HttpException('403 - Forbidden');
    } else if (response.statusCode == 404) {
      throw const HttpException('404 - Not Found');
    } else {
      throw const HttpException('500 - Server Error');
    }
  }
}
