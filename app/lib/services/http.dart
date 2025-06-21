import 'package:http/http.dart' as http;

/// A wrapper around the http client to allow for easier mocking in tests.
class HttpService {
  final http.Client _client;

  HttpService({http.Client? client}) : _client = client ?? http.Client();

  Future<http.Response> get(Uri url, {Map<String, String>? headers}) {
    return _client.get(url, headers: headers);
  }

  Future<http.Response> post(
    Uri url, {
    Map<String, String>? headers,
    Object? body,
  }) {
    return _client.post(url, headers: headers, body: body);
  }

  void close() {
    _client.close();
  }
}
