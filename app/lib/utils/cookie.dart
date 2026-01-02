import 'package:flutter/foundation.dart';
import 'package:universal_html/html.dart' as html;

bool hasAuthCookie() {
  if (!kIsWeb) return true;
  var cookies = html.document.cookie;
  if (cookies == null) return false;
  for (var cookie in cookies.split(';')) {
    print(cookie);
    if (cookie.contains('Access-Token-Available')) {
      return true;
    }
  }
  return false;
}
