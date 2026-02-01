import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:logging/logging.dart';
import 'package:resonate/services/http/cookie_jar.dart';
import 'package:resonate/services/secure_database/secure_database.dart';
import 'package:resonate/services/http/client.dart'
    if (dart.library.io) 'package:resonate/services/http/android_client.dart';

Logger _log = Logger('services/http');

abstract class AbstractHttpService {
  Future<Uint8List> post(
    Uri url, {
    Map<String, String>? headers,
    Uint8List? body,
  });
}

class HttpService implements AbstractHttpService {
  HttpService({required AbstractSecureDatabase secureDatabse})
    : cookieJar = BetterPersistCookieJar(
        storage: SecureCookieStorage(secureDatabase: secureDatabse),
      ) {
    _client = HttpClientImpl().customHttpClient;
  }

  late final http.Client _client;
  final BetterPersistCookieJar cookieJar;

  @override
  Future<Uint8List> post(
    Uri url, {
    Map<String, String>? headers,
    Uint8List? body,
  }) async {
    headers ??= {};
    headers['User-Agent'] = 'resonates.xyz';
    headers['Content-Type'] = 'application/octet-stream';
    try {
      if (!kIsWeb) {
        await cookieJar.actuallyLoadForRequest(headers, url);
      }
      var response = await _client.post(url, headers: headers, body: body);
      if (response.statusCode != 200) {
        throw HttpServiceException(
          'Failed to post to $url: ${response.statusCode} ${response.reasonPhrase}',
        );
      }
      if (!kIsWeb) {
        await cookieJar.actuallySaveFromResponse(url, response);
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
