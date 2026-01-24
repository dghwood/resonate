import 'package:flutter/foundation.dart';
import 'package:universal_io/io.dart';

String get BASE_URL {
  if (kReleaseMode) {
    return const String.fromEnvironment("BASE_URL");
  } else if (Platform.isAndroid) {
    // Android uses 10.0.2.2 for localhost
    return 'https://10.0.2.2';
  }
  return 'https://localhost';
}

const String CLIENT_VERSION = String.fromEnvironment("CLIENT_VERSION");
