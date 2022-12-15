import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
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
  Future request({
    required String url,
    required String method,
    Map<String, dynamic>? body,
  }) async {
    final bodyJson = body == null ? null : jsonEncode(body);
    var response = Response('', 500);

    try {
      switch (method) {
        case 'get':
          response = await client.get(Uri.parse(url), headers: _headers).timeout(const Duration(seconds: 30));
          break;
        case 'post':
          response = await client.post(Uri.parse(url), headers: _headers, body: bodyJson).timeout(const Duration(seconds: 30));
          break;
        case 'put':
          response = await client.put(Uri.parse(url), headers: _headers, body: bodyJson).timeout(const Duration(seconds: 30));
          break;
        case 'delete':
          response = await client.delete(Uri.parse(url), headers: _headers).timeout(const Duration(seconds: 30));
          break;
      }
    } on Exception catch (_) {
      rethrow;
    }

    return _checkResponseAndReturn(response);
  }

  @override
  Future<List?> requestAll({
    required String url,
    Map<String, dynamic>? body,
  }) async {
    var response = Response('', 500);

    try {
      response = await client.get(Uri.parse(url), headers: _headers).timeout(const Duration(seconds: 30));
    } on Exception catch (error) {
      debugPrint('$error');

      throw const InternalServerException('Conexão com o servidor perdida');
    }

    return _checkResponseAndReturnAll(response);
  }

  dynamic _checkResponseAndReturn(Response response) {
    final responseBodyDecoded = jsonDecode(response.body);

    // Success
    if (response.statusCode == 200) {
      return response.body.isEmpty ? null : responseBodyDecoded;
    }
    // No Content
    if (response.statusCode == 204) {
      return null;
      // Errors
    } else if (response.statusCode == 400) {
      throw BadRequestException(responseBodyDecoded['error'] ?? '');
    } else if (response.statusCode == 401) {
      throw UnAuthorizedException(responseBodyDecoded['error'] ?? '');
    } else if (response.statusCode == 403) {
      throw ForbiddenException(responseBodyDecoded['error'] ?? '');
    } else if (response.statusCode == 404) {
      throw NotFoundException(responseBodyDecoded['error'] ?? '');
    } else {
      throw InternalServerException(responseBodyDecoded['error'] ?? '');
    }
  }

  List? _checkResponseAndReturnAll(Response response) {
    final responseBodyDecoded = jsonDecode(response.body);

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
