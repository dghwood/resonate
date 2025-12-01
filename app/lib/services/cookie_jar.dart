import 'package:cookie_jar/cookie_jar.dart';
import 'package:resonate/services/secure_database/secure_database.dart';

class SecureStorage implements Storage {
  SecureStorage(this._db);

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
