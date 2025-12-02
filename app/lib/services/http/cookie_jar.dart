import 'package:http/http.dart' as http;
import 'package:cookie_jar/cookie_jar.dart';
import 'package:logging/logging.dart';
import 'package:resonate/errors/errors.dart';
import 'package:resonate/services/secure_database/secure_database.dart';

final Logger _log = Logger('/services/http/cookie_jar');

class BetterPersistCookieJar extends PersistCookieJar {
  BetterPersistCookieJar({required Storage storage}) : super(storage: storage);

  Future<bool> actuallyLoadForRequest(
    Map<String, String> headers,
    Uri url,
  ) async {
    try {
      final cookies = await loadForRequest(url);
      _log.info(cookies);
      if (cookies.isNotEmpty) {
        headers['Cookie'] = cookies
            .map((c) => '${c.name}=${c.value}')
            .join('; ');
        _log.info('headers $headers');
      }
    } on DatabaseNotFoundException catch (_) {
      // Don't worry about not finding any cookies.
      return false;
    }
    return true;
  }

  Future<bool> actuallySaveFromResponse(Uri url, http.Response response) async {
    final setCookieHeader = response.headers['set-cookie'];

    if (setCookieHeader == null) {
      return true;
    }
    _log.info('cookieHeader $setCookieHeader');
    var cookies = <Cookie>[];
    var cookieParts = setCookieHeader.split(',');
    for (var part in cookieParts) {
      cookies.add(Cookie.fromSetCookieValue(part));
    }
    await saveFromResponse(url, cookies);
    return true;
  }
}

// Storage class for PersistantCookie Jar
class SecureCookieStorage implements Storage {
  SecureCookieStorage({required AbstractSecureDatabase secureDatabase})
    : _db = secureDatabase;

  final AbstractSecureDatabase _db;

  @override
  Future<void> delete(String key) {
    return _db.delete(key);
  }

  @override
  Future<void> deleteAll(List<String> keys) async {
    for (var key in keys) {
      await _db.delete(key);
    }
  }

  @override
  Future<void> init(bool persistSession, bool ignoreExpires) async {}

  @override
  Future<String?> read(String key) async {
    try {
      return await _db.read(key);
    } catch (e) {
      return null;
    }
  }

  @override
  Future<void> write(String key, String value) {
    return _db.write(key, value);
  }
}
