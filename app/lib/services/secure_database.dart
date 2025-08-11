import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:protobuf/protobuf.dart';
import 'package:resonate/errors/errors.dart';
import 'package:resonate/models/models.dart';

abstract class AbstractSecureDatabase {
  Future<void> write(String key, String value);
  Future<String> read(String key);
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

// Note this isn't tied to a user, but to the app as a whole
class SecureProtoDatabase<K extends GeneratedMessage, T extends BaseModel<K>> {
  SecureProtoDatabase({required AbstractSecureDatabase secureDatabase})
    : _secureDatabase = secureDatabase;
  final AbstractSecureDatabase _secureDatabase;

  // This is maybe a bit of a hack, to enable to write a single key / value
  // for storing the logged in user, which is the key for the UserStorageMessage
  Future<void> writeKey(String key, String value) async {
    await _secureDatabase.write(key, value);
  }

  Future<String> readKey(String key) async {
    return await _secureDatabase.read(key);
  }

  Future<void> write(String key, T message) async {
    await _secureDatabase.write(key, message.toStringStore());
  }

  Future<void> read(String key, T message) async {
    var value = await _secureDatabase.read(key);
    message.fromStringStore(value);
  }

  Future<void> delete(String key) async {
    await _secureDatabase.delete(key);
  }

  Future<void> deleteAll() async {
    await _secureDatabase.deleteAll();
  }
}
