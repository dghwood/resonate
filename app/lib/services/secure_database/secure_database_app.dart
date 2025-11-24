import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:resonate/errors/errors.dart';
import 'package:resonate/services/secure_database/secure_database.dart';

class SecureDatabase implements AbstractSecureDatabase {
  final FlutterSecureStorage _secureStorage;

  SecureDatabase() : _secureStorage = const FlutterSecureStorage();

  @override
  Future<void> write(String key, String value) async {
    try {
      await _secureStorage.write(key: key, value: value);
    } catch (e) {
      throw SystemStorageError('Failed to write to secure storage: $e');
    }
  }

  @override
  Future<String> read(String key) async {
    try {
      var value = await _secureStorage.read(key: key);
      if (value == null) {
        throw DatabaseNotFoundException('Key $key not found in secure storage');
      }
      return value;
    } catch (e) {
      throw SystemStorageError('Failed to read from secure storage: $e');
    }
  }

  @override
  Future<void> delete(String key) async {
    try {
      await _secureStorage.delete(key: key);
    } catch (e) {
      throw SystemStorageError('Failed to delete from secure storage: $e');
    }
  }

  @override
  Future<Map<String, String>> readAll() async {
    try {
      return await _secureStorage.readAll();
    } catch (e) {
      throw SystemStorageError('Failed to read all from secure storage: $e');
    }
  }

  @override
  Future<void> deleteAll() async {
    try {
      await _secureStorage.deleteAll();
    } catch (e) {
      throw SystemStorageError('Failed to delete all from secure storage: $e');
    }
  }
}
