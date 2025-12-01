import 'dart:io';

import 'package:cookie_jar/cookie_jar.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:logging/logging.dart';

Logger _log = Logger('services/http');

abstract class AbstractHttpService {
  Future<Uint8List> post(
    Uri url, {
    Map<String, String>? headers,
    Uint8List? body,
  });
}

class HttpService implements AbstractHttpService {
  HttpService({required this.cookieJar});

  final CookieJar cookieJar;

  @override
  Future<Uint8List> post(
    Uri url, {
    Map<String, String>? headers,
    Uint8List? body,
  }) async {
    headers ??= {};
    headers['Content-Type'] = 'application/octet-stream';
    try {
      if (!kIsWeb) {
        if (kReleaseMode && url.scheme != 'https') {
          throw Exception('only send cookies in secure');
        }
        final cookies = await cookieJar.loadForRequest(url);
        if (cookies.isNotEmpty) {
          headers['cookie'] =
              cookies.map((c) => '${c.name}=${c.value}').join('; ');
        }
      }
    } on Exception {
      // do nothing
    }
    try {
      var response = await http.post(url, headers: headers, body: body);
      if (response.statusCode != 200) {
        throw HttpServiceException(
          'Failed to post to $url: ${response.statusCode} ${response.reasonPhrase}',
        );
      }

      // Handle cookies in app
      if (!kIsWeb) {
        final setCookieHeader = response.headers['set-cookie'];
        if (setCookieHeader != null) {
          var cookies = <Cookie>[];
          var cookieParts = setCookieHeader.split(RegExp(r',(?=[a-zA-Z])'));
          for (var part in cookieParts) {
            try {
              cookies.add(Cookie.fromSetCookieValue(part));
            } catch (e) {
              _log.warning('Failed to parse cookie part: $part');
            }
          }
          await cookieJar.saveFromResponse(url, cookies);
        }
      }

      return response.bodyBytes;
    } catch (e) {
      throw HttpServiceException('Failed to post to $url: $e');
    }
  }
}

class MockHttpService implements AbstractHttpService {
  MockHttpService(this.response);
  Map<String, Uint8List Function()> response = {};

  @override
  Future<Uint8List> post(
    Uri url, {
    Map<String, String>? headers,
    Uint8List? body,
  }) async {
    _log.info('post::$url');
    await Future.delayed(Duration(seconds: 2));
    if (response.containsKey(url.path)) {
      return response[url.path]!();
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
