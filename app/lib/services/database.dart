import 'dart:typed_data';

import 'package:idb_sqflite/idb_sqflite.dart' as idb;
import 'package:resonate/models/models.dart';
import 'package:sqflite/sqflite.dart';

typedef UpgradeFunction =
    Future<void> Function(idb.VersionChangeEvent versionChangeEvent);

abstract class AbstractDatabaseService {
  Future<void> init();
  Future<void> setValue(String storeName, String key, Uint8List value);
  Future<Uint8List> getValue(String storeName, String key);
  Future<void> deleteValue(String storeName, String key);
  Future<List<Uint8List>> getAllValues(String storeName);
  Future<List<Uint8List>> getAllValuesFromIndex(
    String storeName,
    String indexName,
    String value,
  );
  Future<void> clear(String storeName);
  void registerStore(UpgradeFunction upgradeFunction);
}

/* Implementation */
class DatabaseService implements AbstractDatabaseService {
  DatabaseService();
  late idb.Database _db;
  bool isInitialized = false;
  final List<UpgradeFunction> _upgradeFunctions = [];

  final String databaseName = 'resonate.db';
  final int databaseVersion = 1;

  @override
  void registerStore(UpgradeFunction upgradeFunction) {
    _upgradeFunctions.add(upgradeFunction);
  }

  @override
  Future<void> init() async {
    if (isInitialized) {
      return;
    }
    var factory = idb.getIdbFactorySqflite(databaseFactory);
    _db = await factory.open(
      databaseName,
      version: databaseVersion,
      onUpgradeNeeded: (idb.VersionChangeEvent versionChangeEvent) async {
        for (var upgradeFunction in _upgradeFunctions) {
          await upgradeFunction(versionChangeEvent);
        }
      },
    );
    isInitialized = true;
  }

  @override
  Future<List<Uint8List>> getAllValues(String storeName) async {
    var txn = _db.transaction(storeName, 'readonly');
    var store = txn.objectStore(storeName);
    var cursor = store.openCursor();

    var values = <Uint8List>[];
    await for (var c in cursor) {
      if (c.value is Uint8List) {
        values.add(c.value as Uint8List);
      }
    }
    await txn.completed;
    return values;
  }

  @override
  Future<List<Uint8List>> getAllValuesFromIndex(
    String storeName,
    String indexName,
    String value,
  ) async {
    var txn = _db.transaction(storeName, 'readonly');
    var store = txn.objectStore(storeName);
    var index = store.index(indexName);
    var cursor = index.openCursor(range: idb.KeyRange.only(value));
    var values = <Uint8List>[];
    await cursor.forEach((c) {
      if (c.value is Uint8List) {
        values.add(c.value as Uint8List);
      }
    });
    await txn.completed;
    return values;
  }

  @override
  Future<void> setValue(String storeName, String key, Uint8List value) async {
    var txn = _db.transaction(storeName, 'readwrite');
    var store = txn.objectStore(storeName);
    await store.put(value, key);
    await txn.completed;
  }

  @override
  Future<Uint8List> getValue(String storeName, String key) async {
    var txn = _db.transaction(storeName, 'readonly');
    var store = txn.objectStore(storeName);
    var value = await store.getObject(key);
    await txn.completed;
    if (value == null) {
      throw DatabaseNotFoundException('Key $key not found in store $storeName');
    }
    return value as Uint8List;
  }

  @override
  Future<void> deleteValue(String storeName, String key) async {
    var txn = _db.transaction(storeName, 'readwrite');
    var store = txn.objectStore(storeName);
    await store.delete(key);
    await txn.completed;
  }

  @override
  Future<void> clear(String storeName) async {
    var txn = _db.transaction(storeName, 'readwrite');
    var store = txn.objectStore(storeName);
    await store.clear();
    await txn.completed;
  }
}

/* Errors */
class DatabaseNotFoundException implements Exception {
  final String message;

  DatabaseNotFoundException(this.message);

  @override
  String toString() {
    return 'DatabaseNotFoundException: $message';
  }
}

/* Mock */
class MockDatabaseService implements AbstractDatabaseService {
  final Map<String, Map<String, Uint8List>> _mockDatabase = {};

  @override
  Future<void> init() async {
    // Mock initialization logic
  }

  @override
  Future<void> setValue(String storeName, String key, Uint8List value) async {
    _mockDatabase.putIfAbsent(storeName, () => {});
    _mockDatabase[storeName]![key] = value;
  }

  @override
  Future<Uint8List> getValue(String storeName, String key) async {
    if (!_mockDatabase.containsKey(storeName) ||
        !_mockDatabase[storeName]!.containsKey(key)) {
      throw DatabaseNotFoundException('Key $key not found in store $storeName');
    }
    return _mockDatabase[storeName]![key]!;
  }

  @override
  Future<void> deleteValue(String storeName, String key) async {
    if (_mockDatabase.containsKey(storeName)) {
      _mockDatabase[storeName]!.remove(key);
    }
  }

  @override
  Future<List<Uint8List>> getAllValues(String storeName) async {
    if (!_mockDatabase.containsKey(storeName)) {
      return [];
    }
    return _mockDatabase[storeName]!.values.toList();
  }

  @override
  Future<List<Uint8List>> getAllValuesFromIndex(
    String storeName,
    String indexName,
    String value,
  ) async {
    throw UnimplementedError(
      'getAllValuesFromIndex is not implemented in MockDatabaseService',
    );
  }

  @override
  Future<void> clear(String storeName) async {
    _mockDatabase[storeName]?.clear();
  }

  final List<UpgradeFunction> upgradeFunctions = [];
  @override
  void registerStore(UpgradeFunction upgradeFunction) {
    upgradeFunctions.add(upgradeFunction);
    print('Registering upgrade function: ${upgradeFunctions.length}');
  }
}

abstract class AbstractProtoModelDatabase<T extends BaseModel> {
  // Future<void> init();
  Future<void> put(T model);
  Future<T> get(T model);
  Future<Iterable<T>> list();
  Future<Iterable<T>> listFromIndex(String indexName, String value);
  T converter(Uint8List value);
  void upgradeFunction(idb.VersionChangeEvent versionChangeEvent);
}

class ProtoModelDatabase<T extends BaseModel>
    implements AbstractProtoModelDatabase<T> {
  ProtoModelDatabase(this.databaseService);

  @override
  T converter(Uint8List value) {
    throw UnimplementedError('converter must be implemented by subclasses');
  }

  final AbstractDatabaseService databaseService;

  final String storeName = 'default_store';

  @override
  Future<void> put(T model) async {
    if (model.id.isEmpty) {
      throw ArgumentError('Model must have a non-null id');
    }
    final key = model.id;
    final value = model.writeToBuffer();
    await databaseService.setValue(storeName, key, value);
  }

  @override
  Future<T> get(T model) async {
    if (model.id.isEmpty) {
      throw ArgumentError('ID must not be empty');
    }
    final value = await databaseService.getValue(storeName, model.id);
    return converter(value);
  }

  @override
  Future<Iterable<T>> list() async {
    final values = await databaseService.getAllValues(storeName);
    return values.map((value) => converter(value));
  }

  @override
  Future<Iterable<T>> listFromIndex(String indexName, String value) async {
    final values = await databaseService.getAllValuesFromIndex(
      storeName,
      indexName,
      value,
    );
    return values.map((v) => converter(v));
  }

  @override
  void upgradeFunction(idb.VersionChangeEvent versionChangeEvent) =>
      throw UnimplementedError(
        'registerStore must be implemented by subclasses',
      );
}
