import 'package:resonate/services/secure_database/secure_database.dart';

class SecureDatabase implements AbstractSecureDatabase {
  @override
  Future<void> delete(String key) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<void> deleteAll() {
    // TODO: implement deleteAll
    throw UnimplementedError();
  }

  @override
  Future<String> read(String key) {
    // TODO: implement read
    throw UnimplementedError();
  }

  @override
  Future<Map<String, String>> readAll() {
    // TODO: implement readAll
    throw UnimplementedError();
  }

  @override
  Future<void> write(String key, String value) {
    // TODO: implement write
    throw UnimplementedError();
  }
}
