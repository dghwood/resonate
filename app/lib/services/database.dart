import 'package:idb_sqflite/idb_sqflite.dart' as idb;
import 'package:protobuf/protobuf.dart';
import 'package:resonate/api/auth.dart';
import 'package:resonate/errors/errors.dart';
import 'package:resonate/errors/errors.dart' as errors;
import 'package:resonate/models/models.dart';
// import 'package:sqflite/sqflite.dart';

import 'package:logging/logging.dart';

final _log = Logger('database');

typedef UpgradeFunction =
    Future<void> Function(idb.VersionChangeEvent versionChangeEvent);

typedef DatabaseStoreType = Map<String, Object?>;

abstract class AbstractDatabaseService {
  Future<void> init(AuthUser user);
  Future<void> setValue(String storeName, DatabaseStoreType value);
  Future<void> setValues(
    String storeName,
    Map<String, DatabaseStoreType> values,
  );
  Future<DatabaseStoreType> getValue(String storeName, String key);
  Future<Iterable<DatabaseStoreType>> getMany(
    String storeName,
    Iterable<String> keys,
  );
  Future<void> deleteValue(String storeName, String key);
  Future<Iterable<DatabaseStoreType>> getAllValues(String storeName);
  Future<Iterable<DatabaseStoreType>> getAllValuesFromIndex(
    String storeName,
    String indexName,
    String value,
  );
  Future<Iterable<DatabaseStoreType>> getAllValuesFromSortedIndex(
    String storeName,
    String indexName,
    Object value,
  );
  Future<Iterable<DatabaseStoreType>> getAllValuesFromLowerBoundIndex(
    String storeName,
    String indexName,
    Object lowerBound,
  );
  Future<void> clear(String storeName);
  void registerStore(String storeName, UpgradeFunction upgradeFunction);
}

/* Implementation */
class DatabaseService implements AbstractDatabaseService {
  DatabaseService(idb.IdbFactory factory) : _factory = factory;
  // eg. idb.getIdbFactorySqflite(databaseFactory);
  final idb.IdbFactory _factory;

  AuthUser? _authUser;
  late idb.Database _db;

  idb.Database get testAccessDb => _db;
  bool isInitialized = false;
  final Map<String, UpgradeFunction> _upgradeFunctions = {};

  final String databaseName = 'resonate.db';
  final int databaseVersion = 2;

  @override
  void registerStore(String storeName, UpgradeFunction upgradeFunction) {
    _upgradeFunctions[storeName] = upgradeFunction;
  }

  @override
  Future<void> init(AuthUser authUser) async {
    if (isInitialized) {
      return;
    }
    _log.info('Initializing DatabaseService::${_upgradeFunctions.length}');
    _authUser = authUser;
    var userId = _authUser?.user?.id ?? '';
    _db = await _factory.open(
      '$userId.$databaseName',
      version: databaseVersion,
      onUpgradeNeeded: (idb.VersionChangeEvent versionChangeEvent) async {
        _log.info('onUpgradeNeeded');
        for (var upgradeFunction in _upgradeFunctions.values) {
          _log.info('Running upgrade function for store');
          try {
            await upgradeFunction(versionChangeEvent);
          } on Exception catch (e) {
            _log.severe('Error during upgrade: $e');
            throw e; // Rethrow to handle it in the caller
          }
        }
      },
    );
    isInitialized = true;
    _log.info('DatabaseService initialized');
  }

  @override
  Future<Iterable<DatabaseStoreType>> getAllValues(String storeName) async {
    if (_authUser == null || !_authUser!.isSignedIn) {
      throw UserNotSignedInError();
    }
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
  Future<Iterable<DatabaseStoreType>> getAllValuesFromSortedIndex(
    String storeName,
    String indexName,
    Object value,
  ) async {
    if (_authUser == null || !_authUser!.isSignedIn) {
      throw UserNotSignedInError();
    }
    // TODO(duncan): This throws an error when the object store
    // doesn't exixt.
    var txn = _db.transaction(storeName, 'readonly');
    var store = txn.objectStore(storeName);
    var index = store.index(indexName);
    var cursor = index.openCursor(
      // The index is [podcastId, timestamp]
      range: idb.KeyRange.bound([value, 0], [value, -1 >>> 1]),
      autoAdvance: true,
      direction: idb.idbDirectionPrev, // descending
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
  Future<List<DatabaseStoreType>> getAllValuesFromIndex(
    String storeName,
    String indexName,
    Object value,
  ) async {
    if (_authUser == null || !_authUser!.isSignedIn) {
      throw UserNotSignedInError();
    }
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
  Future<List<DatabaseStoreType>> getAllValuesFromLowerBoundIndex(
    String storeName,
    String indexName,
    Object lowerBound,
  ) async {
    if (_authUser == null || !_authUser!.isSignedIn) {
      throw UserNotSignedInError();
    }
    var txn = _db.transaction(storeName, 'readonly');
    var store = txn.objectStore(storeName);
    var index = store.index('podcastId');
    // var index = store.index(indexName);
    var cursor = index.openCursor(
      range: idb.KeyRange.lowerBound(lowerBound),
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
  Future<void> setValue(String storeName, DatabaseStoreType value) async {
    _log.info('setValue::$storeName');
    if (_authUser == null || !_authUser!.isSignedIn) {
      throw UserNotSignedInError();
    }
    var txn = _db.transaction(storeName, 'readwrite');
    var store = txn.objectStore(storeName);
    await store.put(value);
    await txn.completed;
  }

  @override
  Future<void> setValues(
    String storeName,
    Map<String, DatabaseStoreType> values,
  ) async {
    if (_authUser == null || !_authUser!.isSignedIn) {
      throw UserNotSignedInError();
    }
    var txn = _db.transaction(storeName, 'readwrite');
    var store = txn.objectStore(storeName);
    for (var entry in values.entries) {
      await store.put(entry.value);
    }
    await txn.completed;
  }

  @override
  Future<DatabaseStoreType> getValue(String storeName, String key) async {
    if (_authUser == null || !_authUser!.isSignedIn) {
      throw UserNotSignedInError();
    }
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
  Future<Iterable<DatabaseStoreType>> getMany(
    String storeName,
    Iterable<String> keys,
  ) async {
    if (_authUser == null || !_authUser!.isSignedIn) {
      throw UserNotSignedInError();
    }
    _log.info('getMany::$keys');
    var txn = _db.transaction(storeName, 'readonly');
    var store = txn.objectStore(storeName);
    var values = <DatabaseStoreType>[];
    for (var key in keys) {
      var value = await store.getObject(key);
      if (value != null && value is DatabaseStoreType) {
        values.add(value);
      }
    }
    await txn.completed;
    return values;
  }

  @override
  Future<void> deleteValue(String storeName, String key) async {
    if (_authUser == null || !_authUser!.isSignedIn) {
      throw UserNotSignedInError();
    }
    var txn = _db.transaction(storeName, 'readwrite');
    var store = txn.objectStore(storeName);
    await store.delete(key);
    await txn.completed;
  }

  @override
  Future<void> clear(String storeName) async {
    if (_authUser == null || !_authUser!.isSignedIn) {
      throw UserNotSignedInError();
    }
    var txn = _db.transaction(storeName, 'readwrite');
    var store = txn.objectStore(storeName);
    await store.clear();
    await txn.completed;
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
  Future<void> getMany(Iterable<T> models);
  Future<Iterable<T>> list();
  Future<Iterable<T>> listFromIndex(String indexName, String value);
  Future<Iterable<T>> listFromSortedIndex(String indexName, Object value);
  Future<Iterable<T>> getAllValuesFromLowerBoundIndex(
    String indexName,
    Object lowerBound,
  );
  T onBeforePut(T model);
  void upgradeFunction(idb.VersionChangeEvent versionChangeEvent);
}

/* ProtoModelDatabase 

  I need this to able to be created multiple times, given I 
  don't want to pass around a single reference everywhere. 
*/
abstract class ProtoModelDatabase<
  K extends GeneratedMessage,
  T extends StorageModel<K>
>
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
    _log.info('put::${model.runtimeType}');
    if (model.id.isEmpty) {
      throw ArgumentError('Model must have a non-null id');
    }
    await databaseService.setValue(storeName, onBeforePut(model).toStore());
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
    // Note: We do this after filling the model object
    if (model.metadata.isDeleted) {
      throw errors.DatabaseDeletedException("item found and deleted");
    }
  }

  @override
  Future<void> getMany(Iterable<T> models) async {
    final keys = models.map((m) => m.id);
    final values = await databaseService.getMany(storeName, keys);
    if (values.length != models.length) {
      throw UnimplementedError('Not all models found');
    }
    for (var i = 0; i < values.length; i++) {
      // Note: for models not found
      models.elementAt(i).fromStore(values.elementAt(i));
    }
  }

  //
  Iterable<T> _toModels(
    Iterable<DatabaseStoreType> values, {
    bool includeDeleted = false,
  }) {
    final models = values.map((value) => newInstance()..fromStore(value));
    if (includeDeleted) {
      return models;
    }
    return models.where((m) => m.metadata.isDeleted == false);
  }

  @override
  Future<Iterable<T>> list({bool includeDeleted = false}) async {
    final values = await databaseService.getAllValues(storeName);
    return _toModels(values, includeDeleted: includeDeleted);
  }

  @override
  Future<Iterable<T>> listFromIndex(
    String indexName,
    String value, {
    bool includeDeleted = false,
  }) async {
    final values = await databaseService.getAllValuesFromIndex(
      storeName,
      indexName,
      value,
    );
    return _toModels(values, includeDeleted: includeDeleted);
  }

  @override
  Future<Iterable<T>> listFromSortedIndex(
    String indexName,
    Object value, {
    bool includeDeleted = false,
  }) async {
    final values = await databaseService.getAllValuesFromSortedIndex(
      storeName,
      indexName,
      value,
    );
    return _toModels(values, includeDeleted: includeDeleted);
  }

  //getAllValuesFromLowerBoundIndex
  @override
  Future<Iterable<T>> getAllValuesFromLowerBoundIndex(
    String indexName,
    Object lowerBound, {
    bool includeDeleted = false,
  }) async {
    final values = await databaseService.getAllValuesFromLowerBoundIndex(
      storeName,
      indexName,
      lowerBound,
    );
    return _toModels(values, includeDeleted: includeDeleted);
  }

  @override
  void upgradeFunction(idb.VersionChangeEvent versionChangeEvent) =>
      throw UnimplementedError(
        'registerStore must be implemented by subclasses',
      );
}
