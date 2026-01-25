import 'package:cronet_http/cronet_http.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:resonate/services/http/client.dart';
import 'package:universal_io/io.dart';

class HttpClientImpl implements AbstractHttpClient {
  @override
  http.Client get customHttpClient {
    if (!Platform.isAndroid && !kDebugMode) {
      return http.Client();
    }
    final engine = CronetEngine.build(
      cacheMode: CacheMode.memory,
      cacheMaxSize: 2 * 1024 * 1024,
      userAgent: 'resonates.xyz',
    );
    return CronetClient.fromCronetEngine(engine, closeEngine: true);
  }
}
