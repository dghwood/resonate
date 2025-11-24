import 'package:protobuf/protobuf.dart';
import 'package:resonate/models/models.dart';
export 'package:resonate/services/secure_database/secure_database_stub.dart'
    if (dart.library.io) 'package:resonate/services/secure_database/secure_database_app.dart'
    if (dart.library.js_interop) 'package:resonate/services/secure_database/secure_database_web.dart';

abstract class AbstractSecureDatabase {
  Future<void> write(String key, String value);
  Future<String> read(String key);
  Future<void> delete(String key);
  Future<Map<String, String>> readAll();
  Future<void> deleteAll();
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
