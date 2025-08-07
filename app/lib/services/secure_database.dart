import 'package:flutter_secure_storage/flutter_secure_storage.dart';

abstract class AbstractSecureDatabase {
  Future<void> write(String key, String value);
  Future<String?> read(String key);
  Future<void> delete(String key);
  Future<Map<String, String>> readAll();
  Future<void> deleteAll();
}

class SecureDatabase implements AbstractSecureDatabase {
  final FlutterSecureStorage _secureStorage;

  SecureDatabase() : _secureStorage = const FlutterSecureStorage();

  @override
  Future<void> write(String key, String value) async {
    try {
      await _secureStorage.write(key: key, value: value);
    } catch (e) {
      throw Exception('Failed to write to secure storage: $e');
    }
  }

  @override
  Future<String?> read(String key) async {
    try {
      return await _secureStorage.read(key: key);
    } catch (e) {
      throw Exception('Failed to read from secure storage: $e');
    }
  }

  @override
  Future<void> delete(String key) async {
    try {
      await _secureStorage.delete(key: key);
    } catch (e) {
      throw Exception('Failed to delete from secure storage: $e');
    }
  }

  @override
  Future<Map<String, String>> readAll() async {
    try {
      return await _secureStorage.readAll();
    } catch (e) {
      throw Exception('Failed to read all from secure storage: $e');
    }
  }

  @override
  Future<void> deleteAll() async {
    try {
      await _secureStorage.deleteAll();
    } catch (e) {
      throw Exception('Failed to delete all from secure storage: $e');
    }
  }
}
