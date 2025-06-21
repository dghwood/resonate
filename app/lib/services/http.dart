import 'dart:typed_data';

import 'package:http/http.dart' as http;

abstract class AbstractHttpService {
  Future<Uint8List> post(Uri url, {Map<String, String>? headers, Object? body});
}

class HttpService implements AbstractHttpService {
  HttpService();

  @override
  Future<Uint8List> post(
    Uri url, {
    Map<String, String>? headers,
    Object? body,
  }) async {
    try {
      var response = await http.post(url, headers: headers, body: body);
      if (response.statusCode != 200) {
        throw HttpServiceException(
          'Failed to post to $url: ${response.statusCode} ${response.reasonPhrase}',
        );
      }
      return response.bodyBytes;
    } catch (e) {
      throw HttpServiceException('Failed to post to $url: $e');
    }
  }
}

class MockHttpService implements AbstractHttpService {
  MockHttpService(this.response);
  Map<String, Uint8List> response = {};

  @override
  Future<Uint8List> post(
    Uri url, {
    Map<String, String>? headers,
    Object? body,
  }) async {
    if (response.containsKey(url.path)) {
      return response[url.path]!;
    } else {
      throw HttpServiceNotFoundException(url.path);
    }
  }
}

/* Errors */

class HttpServiceNotFoundException implements Exception {
  final String message;

  HttpServiceNotFoundException(this.message);

  @override
  String toString() {
    return 'HttpServiceNotFoundException: $message';
  }
}

class HttpServiceException implements Exception {
  final String message;

  HttpServiceException(this.message);

  @override
  String toString() {
    return 'HttpServiceException: $message';
  }
}
