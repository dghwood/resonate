import 'dart:typed_data';

import 'package:idb_sqflite/idb_sqflite.dart' as idb;
import 'package:protobuf/protobuf.dart';
import 'package:resonate/models/models.dart';
import 'package:sqflite/sqflite.dart';

typedef UpgradeFunction =
    Future<void> Function(idb.VersionChangeEvent versionChangeEvent);

typedef DatabaseStoreType = Map<String, Object?>;

abstract class AbstractDatabaseService {
  Future<void> init();
  Future<void> setValue(String storeName, String key, DatabaseStoreType value);
  Future<void> setValues(
    String storeName,
    Map<String, DatabaseStoreType> values,
  );
  Future<DatabaseStoreType> getValue(String storeName, String key);
  Future<void> deleteValue(String storeName, String key);
  Future<Iterable<DatabaseStoreType>> getAllValues(String storeName);
  Future<Iterable<DatabaseStoreType>> getAllValuesFromIndex(
    String storeName,
    String indexName,
    String value,
  );
  Future<void> clear(String storeName);
  void registerStore(String storeName, UpgradeFunction upgradeFunction);
}

/* Implementation */
class DatabaseService implements AbstractDatabaseService {
  DatabaseService(idb.IdbFactory factory) : _factory = factory;
  // eg. idb.getIdbFactorySqflite(databaseFactory);
  final idb.IdbFactory _factory;
  late idb.Database _db;

  idb.Database get testAccessDb => _db;
  bool isInitialized = false;
  final Map<String, UpgradeFunction> _upgradeFunctions = {};

  final String databaseName = 'resonate.db';
  final int databaseVersion = 1;

  @override
  void registerStore(String storeName, UpgradeFunction upgradeFunction) {
    _upgradeFunctions[storeName] = upgradeFunction;
  }

  @override
  Future<void> init() async {
    if (isInitialized) {
      return;
    }

    _db = await _factory.open(
      databaseName,
      version: databaseVersion,
      onUpgradeNeeded: (idb.VersionChangeEvent versionChangeEvent) async {
        print('running onUpgradeNeeded::${_upgradeFunctions.length}');
        for (var upgradeFunction in _upgradeFunctions.values) {
          print('registering store');
          await upgradeFunction(versionChangeEvent);
        }
      },
    );
    isInitialized = true;
  }

  @override
  Future<Iterable<DatabaseStoreType>> getAllValues(String storeName) async {
    var txn = _db.transaction(storeName, 'readonly');
    var store = txn.objectStore(storeName);
    var cursor = store.openCursor(autoAdvance: true);

    var values = <DatabaseStoreType>[];

    await for (var c in cursor) {
      if (c.value is DatabaseStoreType) {
        values.add(c.value as DatabaseStoreType);
      }
    }
    await txn.completed;
    return values;
  }

  @override
  Future<List<DatabaseStoreType>> getAllValuesFromIndex(
    String storeName,
    String indexName,
    Object value,
  ) async {
    var txn = _db.transaction(storeName, 'readonly');
    var store = txn.objectStore(storeName);
    var index = store.index(indexName);
    var cursor = index.openCursor(
      range: idb.KeyRange.only(value),
      autoAdvance: true,
    );
    var values = <DatabaseStoreType>[];
    await cursor.forEach((c) {
      if (c.value is DatabaseStoreType) {
        values.add(c.value as DatabaseStoreType);
      }
    });
    await txn.completed;
    return values;
  }

  @override
  Future<void> setValue(
    String storeName,
    String key,
    DatabaseStoreType value,
  ) async {
    var txn = _db.transaction(storeName, 'readwrite');
    var store = txn.objectStore(storeName);
    print(value);
    await store.put(value);
    await txn.completed;
  }

  @override
  Future<void> setValues(
    String storeName,
    Map<String, DatabaseStoreType> values,
  ) async {
    var txn = _db.transaction(storeName, 'readwrite');
    var store = txn.objectStore(storeName);
    for (var entry in values.entries) {
      await store.put(entry.value);
    }
    await txn.completed;
  }

  @override
  Future<DatabaseStoreType> getValue(String storeName, String key) async {
    var txn = _db.transaction(storeName, 'readonly');
    var store = txn.objectStore(storeName);
    var value = await store.getObject(key);
    await txn.completed;
    if (value == null) {
      throw DatabaseNotFoundException('Key $key not found in store $storeName');
    }
    return value as DatabaseStoreType;
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

abstract class AbstractProtoModelDatabase<
  K extends GeneratedMessage,
  T extends BaseModel<K>
> {
  T newInstance();
  Future<void> put(T model);
  Future<void> putAll(Iterable<T> models);
  Future<void> get(T model);
  Future<Iterable<T>> list();
  Future<Iterable<T>> listFromIndex(String indexName, String value);

  T onBeforePut(T model);
  void upgradeFunction(idb.VersionChangeEvent versionChangeEvent);
}

class ProtoModelDatabase<K extends GeneratedMessage, T extends BaseModel<K>>
    implements AbstractProtoModelDatabase<K, T> {
  ProtoModelDatabase(this.databaseService);

  @override
  T newInstance() =>
      throw UnimplementedError('newInstance must be implemented by subclasses');

  final AbstractDatabaseService databaseService;

  String get storeName =>
      throw UnimplementedError('storeName must be implemented by subclasses');

  @override
  T onBeforePut(T model) => model;

  @override
  Future<void> put(T model) async {
    if (model.id.isEmpty) {
      throw ArgumentError('Model must have a non-null id');
    }
    await databaseService.setValue(
      storeName,
      model.id,
      onBeforePut(model).toStore(),
    );
  }

  @override
  Future<void> putAll(Iterable<T> models) {
    Map<String, DatabaseStoreType> values = {};
    for (var model in models) {
      if (model.id.isEmpty) {
        throw ArgumentError('Model must have a non-null id');
      }
      values[model.id] = onBeforePut(model).toStore();
    }
    return databaseService.setValues(storeName, values);
  }

  @override
  Future<void> get(T model) async {
    final value = await databaseService.getValue(storeName, model.id);
    model.fromStore(value);
  }

  @override
  Future<Iterable<T>> list() async {
    final values = await databaseService.getAllValues(storeName);
    print('list::${values.length}');
    return values.map((value) => newInstance()..fromStore(value));
  }

  @override
  Future<Iterable<T>> listFromIndex(String indexName, String value) async {
    final values = await databaseService.getAllValuesFromIndex(
      storeName,
      indexName,
      value,
    );
    return values.map((v) => newInstance()..fromStore(v));
  }

  @override
  void upgradeFunction(idb.VersionChangeEvent versionChangeEvent) =>
      throw UnimplementedError(
        'registerStore must be implemented by subclasses',
      );
}
