import 'package:resonate/errors/errors.dart';
import 'package:resonate/services/secure_database/secure_database.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SecureDatabase implements AbstractSecureDatabase {
  @override
  Future<void> delete(String key) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(key);
  }

  @override
  Future<void> deleteAll() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

  @override
  Future<String> read(String key) async {
    final prefs = await SharedPreferences.getInstance();
    final value = prefs.getString(key);
    if (value == null) {
      throw DatabaseNotFoundException('Key $key not found in secure storage');
    }
    return value;
  }

  @override
  Future<Map<String, String>> readAll() async {
    final prefs = await SharedPreferences.getInstance();
    final keys = prefs.getKeys();
    final Map<String, String> result = {};
    for (var key in keys) {
      result[key] = prefs.getString(key) ?? '';
    }
    return result;
  }

  @override
  Future<void> write(String key, String value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(key, value);
  }

  static final SecureDatabase instance = SecureDatabase();
}
