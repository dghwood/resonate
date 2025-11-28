import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:logging/logging.dart';
import 'package:resonate/services/secure_database/secure_database.dart';

Logger _log = Logger('services/http');

abstract class AbstractHttpService {
  Future<Uint8List> post(
    Uri url, {
    Map<String, String>? headers,
    Uint8List? body,
  });
}

class HttpService implements AbstractHttpService {
  HttpService({required AbstractSecureDatabase secureDatabase})
    : _secureDatabase = secureDatabase;

  final AbstractSecureDatabase _secureDatabase;

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
        // load cookies from secure storage
        var cookies = await _secureDatabase.read('cookies');
        var cookieMap = jsonDecode(cookies);
        var cookieHeader = [];
        for (var key in cookieMap) {
          cookieHeader.add('$key=${cookieMap[key]}');
        }
        headers['Cookie'] = cookieHeader.join('; ');
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
        var cookieHeader = response.headers['set-cookie'];
        if (cookieHeader != null) {
          var cookieStrings = cookieHeader.split(',');
          Map<String, String> cookieMap = {};
          for (var cookieString in cookieStrings) {
            // just parse out the name=value pairs
            var cookie = cookieString.split(';')[0];
            var keyValue = cookie.split('=').map((e) => e.trim()).toList();
            if (keyValue[0] != '' && keyValue[1] != '') {
              cookieMap[keyValue[0]] = keyValue[1];
            }
          }
          if (cookieMap.isNotEmpty) {
            _log.info(cookieMap);
            await _secureDatabase.write('cookies', jsonEncode(cookieMap));
          }
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
