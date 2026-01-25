import 'package:http/http.dart' as http;

abstract class AbstractHttpClient {
  http.Client get customHttpClient;
}

class HttpClientImpl implements AbstractHttpClient {
  @override
  http.Client get customHttpClient => http.Client();
}
