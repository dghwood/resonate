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
